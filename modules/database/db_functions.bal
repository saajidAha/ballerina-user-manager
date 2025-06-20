import ballerina/sql;
import ballerinax/mysql.driver as _;

# Create the User table if it does not exist.
# + return - error? (nil if successful)
public function createUserTable() returns error? {
    _ = check db_connection->execute(createUserTableQuery());
}

# Insert dummy users into the User table.
# + return - error? (nil if successful)
public function insertDummyUsers() returns error? {
    _ = check db_connection->execute(insertDummyUsersQuery());
}

# Fetch all users from the User table.
# + return - Array of User records or error
public function getAllUsers() returns User[]|error {
    // Execute query to retrieve all users from the User table
    stream<User, sql:Error?> userStream = db_connection->query(getAllUsersQuery());
    return check from User user in userStream select user;
}

# Fetch a user by ID.
# + id - User ID
# + return - User record or error
public function getUser(string id) returns User|error {
    return check db_connection->queryRow(getUserQuery(id));
}

# Add a new user to the User table.
# + newUser - User record to add
# + return - error? (nil if successful)
public function addUser(User newUser) returns error? {
    _ = check db_connection->execute(addUserQuery(newUser));
}

# Delete a user by ID.
# + id - User ID
# + return - error? (nil if successful)
public function deleteUser(string id) returns error? {
    _ = check db_connection->execute(deleteUserQuery(id));
}

# Update a user by ID.
# + id - User ID
# + user - Updated User record
# + return - error? (nil if successful)
public function updateUser(string id, User user) returns error? {
    _ = check db_connection->execute(updateUserQuery(id, user));
}

# Search users by name.
# + name - Name to search for
# + return - Array of User records or error
public function searchUser(string name) returns User[] | error {
    stream<User, sql:Error?> userStream = db_connection->query(searchUserQuery(name));
    return check from User result in userStream select result;
}