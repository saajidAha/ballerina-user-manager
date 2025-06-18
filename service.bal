import ballerina/http;
import backend.database;

service / on new http:Listener(9090){
    resource function get users() returns database:User[] | error {
        database:User[] | error users = database:getAllUsers();
        return users;
    }

    resource function get users/[string id]() returns database:User | error {
        database:User | error user = database:getUser(id);
        return user;
    }

    resource function post users(@http:Payload database:User newUser) returns http:STATUS_CREATED | http:STATUS_BAD_REQUEST | error {
       error? result = database:addUser(newUser);
       if result is error {
           return http:STATUS_BAD_REQUEST;
       }
       return http:STATUS_CREATED;
    }
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
}