import ballerina/http;
import backend.database;

# User management REST API service
service / on new http:Listener(9090){
    # Get all users
    # + return - Array of User records or error
    resource function get users() returns database:User[] | error {
        database:User[] | error users = database:getAllUsers();
        return users;
    }

    # Get a user by ID
    # + id - User ID
    # + return - User record or error
    resource function get users/[string id]() returns database:User | error {
        database:User | error user = database:getUser(id);
        return user;
    }

    # Search for a user by name
    # + name - User name
    # + return - HTTP response with status and User records
    resource function get user(@http:Query string name) returns http:Response{
        database:User[] | error result = database:searchUser(name);
        http:Response res = new;

        if result is error{
            res.statusCode = 400;
            return res;
        }
        
        res.statusCode = 200;
        res.setPayload(result);

        return res;
    }

    # Add a new user
    # + newUser - User record to add
    # + return - 201 Created, 400 Bad Request, or error
    resource function post users(@http:Payload database:User newUser) returns http:STATUS_CREATED | http:STATUS_BAD_REQUEST | error {
       error? result = database:addUser(newUser);
       if result is error {
           return http:STATUS_BAD_REQUEST;
       }
       return http:STATUS_CREATED;
    }

    # Delete a user by ID
    # + id - User ID
    # + return - HTTP response with status
    resource function delete users/[string id]() returns http:Response{
        error? result = database:deleteUser(id);
        http:Response res = new;
        if result is error{
            res.statusCode = 400;
            return res;
        }
        res.statusCode = 204;
        return res;
    }

    # Update a user by ID
    # + id - User ID
    # + user - Updated User record
    # + return - HTTP response with status
    resource function put users/[string id](@http:Payload database:User user) returns http:Response{
        error? result = database:updateUser(id, user);
        http:Response res = new;
        if result is error{
            res.statusCode = 400;
            return res;
        }
        res.statusCode = 200;
        return res;
    }

}