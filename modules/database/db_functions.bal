import ballerina/sql;
// import ballerinax/mysql;
import ballerinax/mysql.driver as _;
import ballerina/io;

public function getAllUsers() returns User[]|error {
    // Execute query to retrieve all users from the User table
    stream<User, sql:Error?> userStream = db_connection->query(getAllUsersQuery());

    User[] userArray = [];
    error? result = userStream.forEach(function(User user) {
        userArray.push(user);
    });

    check userStream.close();
    return userArray;
}

public function getUser(string id) returns User|error {
    stream<User, sql:Error?> userStream = db_connection->query(getUserQuery(id));
    
    record {| User value; |}? result = check userStream.next();
    check userStream.close();
    
    if result is () {
        return error("User not found");
    }
    return result.value;
}

public function addUser(User newUser) returns error? {
    _ = check db_connection->execute(addUserQuery(newUser));
    io:println("Successfully added user");
}

public function deleteUser(string id) returns error? {
    _ = check db_connection->execute(deleteUserQuery(id));
    io:println("Deleted user successfully");
}

public function updateUser(string id, User user) returns error? {
    _ = check db_connection->execute(updateUserQuery(id, user));
    io:println("Updated user sucessfully.");
}

public function searchUser(string name) returns User[] | error {
    io:println( "name: " + name);
    stream<User, sql:Error?> userStream = db_connection->query(searchUserQuery(name));
    
    User[] userArray = [];
    error? result = userStream.forEach(function(User user) {
        userArray.push(user);
    });
    
    foreach User user in userArray {
        io:println(user.name + user.email);
    }
    return userArray;
}