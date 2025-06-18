import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;
import ballerina/io;

configurable string HOST = "localhost";
configurable int PORT = 3306;
configurable string USER = "root";
configurable string PASSWORD = "abc123";
configurable string DATABASE = "test";

public class DatabaseClient {
    private final mysql:Client db;
    // Initialize the MySQL client
    public function init() returns error? {
        self.db = check new (HOST, USER, PASSWORD, DATABASE, PORT);
    }

    public function getAllUsers() returns User[]|error {
        // Execute query to retrieve all users from the User table
        stream<User, sql:Error?> userStream = self.db->query(getAllUsersQuery());

        User[] userArray = [];
        error? result = userStream.forEach(function(User user) {
            userArray.push(user);
        });

        check userStream.close();
        return userArray;
    }

    public function getUser(string id) returns User|error {
        stream<User, sql:Error?> userStream = self.db->query(getUserQuery(id));
        
        record {| User value; |}? result = check userStream.next();
        check userStream.close();
        
        if result is () {
            return error("User not found");
        }
        return result.value;
    }

    public function addUser(User newUser) returns error? {
        _ = check self.db->execute(addUserQuery(newUser));
        io:println("Successfully added user");
    }

    public function deleteUser(string id) returns error? {
        _ = check self.db->execute(deleteUserQuery(id));
        io:println("Deleted user successfully");
    }

    public function updateUser(string id, User user) returns error? {
        _ = check self.db->execute(updateUserQuery(id, user));
        io:println("Updated user sucessfully.");
    }

    public function searchUser(string name) returns User[] | error {
        io:println( "name: " + name);
        stream<User, sql:Error?> userStream = self.db->query(searchUserQuery(name));
        
        User[] userArray = [];
        error? result = userStream.forEach(function(User user) {
            userArray.push(user);
        });
        
        foreach User user in userArray {
            io:println(user.name + user.email);
        }
        return userArray;
    }

}