import ballerina/http;
import backend.database;

# User management REST API service
service / on new http:Listener(9090){

    # Get a user by ID
    # + id - User ID
    # + return - 200: Success, 404: Not Found
    resource function get users/[string id]() returns http:Response {
        database:User | error user = database:getUser(id);
        http:Response res = new;
        if user is error {
            res.statusCode = 404;
            res.setPayload({"error" :"Failed to retreive user with id: " + id + ". User does not exist"});
            return res;
        }
        res.setPayload(user);
        return res;
    }

    # Search for a user by name
    # + name - User name
    # + return - 200: Success, 404: Not Found
    resource function get user(@http:Query string name) returns http:Response{
        database:User[] | error result = database:searchUser(name);
        http:Response res = new;

        if result is error{
            res.statusCode = 404;
            res.setPayload({"error": "Failed to retrieve user with name: " + name});
            return res;
        } 
        res.statusCode = 200;
        res.setPayload(result);
        return res;
    }

    # Get all users
    # + return - 200: Success, 500: Internal Server Error
    resource function get users() returns http:Response {
        database:User[] | error users = database:getAllUsers();
        http:Response res = new;       
        if users is error {
            res.statusCode = 500;
            res.setPayload({"error": "Failed to retrieve users"});
            return res;
        }
        res.statusCode = 200;
        res.setPayload(users);
        return res;
    }

    # Add a new user
    # + newUser - User record to add
    # + return - 201: Created, 400: Bad Request
    resource function post users(@http:Payload database:User newUser) returns http:Response{
       error? result = database:addUser(newUser);
       http:Response res = new;
       if result is error {
        res.statusCode = 400;
        res.setPayload({"error" : "Failed to add new user. Please check if the you have added the user info in a correct format"});
        return res;
       }
       res.statusCode = 201;
       return res;
       }

    # Update a user by ID
    # + id - User ID
    # + user - Updated User record
    # + return - 200: Success, 400: Bad Request, 404: not found
    resource function put users/[string id](@http:Payload database:User user) returns http:Response{
        database:User | error existingUser = database:getUser(id);
        http:Response res = new;
        if existingUser is error{
            res.statusCode = 404;
            res.setPayload({"error": "Failed to update user with id: " + id + ". User does not exist"});
            return res;
        }
        error? result = database:updateUser(id, user);
        if result is error{
            res.statusCode = 400;
            res.setPayload({"error": "Failed to update user with id: " + id + ". Please check if the you have added the user info in a correct format"});
            return res;
        }
        res.statusCode = 200;
        return res;
    }

    # Delete a user by ID
    # + id - User ID
    # + return - 204: No Content, 404: Not Found, 500: Internal Server Error
    resource function delete users/[string id]() returns http:Response{
        database:User | error existingUser = database:getUser(id);
        http:Response res = new;
        if existingUser is error{
            res.statusCode = 404;
            res.setPayload({"error": "Failed to delete user with id: " + id + ". User does not exist"});
            return res;
        }
        error? result = database:deleteUser(id);
        if result is error{
            res.statusCode = 500;
            res.setPayload({"error": "Failed to delete user with id: " + id});
        }
        res.statusCode = 204;
        return res;
    }

}