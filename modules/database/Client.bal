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
        stream<User, sql:Error?> userStream = self.db->query(`SELECT * FROM User`);

        User[] userArray = [];
        error? result = userStream.forEach(function(User user) {
        userArray.push(user);
        });

        check userStream.close();
        return userArray;
    }

    public function getUser(string id) returns User|error {
        stream<User, sql:Error?> userStream = self.db->query(`SELECT * FROM User WHERE ID = ${id}`);
        
        record {| User value; |}? result = check userStream.next();
        check userStream.close();
        
        if result is () {
            return error("User not found");
        }
        return result.value;
    }

    public function addUser(User newUser) returns error? {
        _ = check self.db->execute(`INSERT INTO User (id, name, email, age, role) VALUES (${newUser.id}, ${newUser.name}, ${newUser.email}, ${newUser.age}, ${newUser.role})`);
        io:println("Successfully added user");
    }

    public function deleteUser(string id) returns error? {
        _ = check self.db->execute(`DELETE FROM User WHERE id = ${id}`);
        io:println("Deleted user successfully");
    }

    public function updateUser(string id, User user) returns error? {
        _ = check self.db->execute(`UPDATE User SET name = ${user.name}, email = ${user.email}, age = ${user.age}, role = ${user.role} WHERE id = ${id}`);
        io:println("Updated user sucessfully.");
    }

    public function searchUser(string name) returns User[] | error {
        io:println( "name: " + name);
        stream<User, sql:Error?> userStream = self.db->query(`SELECT * FROM User WHERE name = ${name}`);
        
        User[] userArray = [];
        error? result = userStream.forEach(function(User user) {
            userArray.push(user);
        });
        
        foreach User user in userArray {
            io:println(user.name + user.email);
        }
        // check userStream.close();
        return userArray;
    }

}