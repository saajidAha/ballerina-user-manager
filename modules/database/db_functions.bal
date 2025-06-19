import ballerina/sql;
import ballerina/io;
import ballerinax/mysql.driver as _;

# Create the User table if it does not exist.
# + return - error? (nil if successful)
public function createUserTable() returns error? {
    _ = check db_connection->execute(createUserTableQuery());
    io:println("User table created or already exists.");
}

# Insert dummy users into the User table.
# + return - error? (nil if successful)
public function insertDummyUsers() returns error? {
    _ = check db_connection->execute(insertDummyUsersQuery());
    io:println("Dummy users inserted or updated.");
}

# Fetch all users from the User table.
# + return - Array of User records or error
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

# Fetch a user by ID.
# + id - User ID
# + return - User record or error
public function getUser(string id) returns User|error {
    stream<User, sql:Error?> userStream = db_connection->query(getUserQuery(id));
    
    record {| User value; |}? result = check userStream.next();
    check userStream.close();
    
    if result is () {
        return error("User not found");
    }
    return result.value;
}

# Add a new user to the User table.
# + newUser - User record to add
# + return - error? (nil if successful)
public function addUser(User newUser) returns error? {
    _ = check db_connection->execute(addUserQuery(newUser));
    io:println("Successfully added user");
}

# Delete a user by ID.
# + id - User ID
# + return - error? (nil if successful)
public function deleteUser(string id) returns error? {
    _ = check db_connection->execute(deleteUserQuery(id));
    io:println("Deleted user successfully");
}

# Update a user by ID.
# + id - User ID
# + user - Updated User record
# + return - error? (nil if successful)
public function updateUser(string id, User user) returns error? {
    _ = check db_connection->execute(updateUserQuery(id, user));
    io:println("Updated user sucessfully.");
}

# Search users by name.
# + name - Name to search for
# + return - Array of User records or error
public function searchUser(string name) returns User[] | error {
    io:println( "name: " + name);
    stream<User, sql:Error?> userStream = db_connection->query(searchUserQuery(name));
    
    User[] userArray = [];
    error? result = userStream.forEach(function(User user) {
        userArray.push(user);
    });
    return userArray;
}