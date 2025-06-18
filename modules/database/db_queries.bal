import ballerina/sql;

/// Build query to add a user.
/// + user - User record to add
/// + return - sql:ParameterizedQuery for insert
isolated function addUserQuery(User user) returns sql:ParameterizedQuery =>
    `INSERT INTO User (id, name, email, age, role) VALUES (${user.id}, ${user.name}, ${user.email}, ${user.age}, ${user.role})`;

/// Build query to fetch all users.
/// + return - sql:ParameterizedQuery for select all
isolated function getAllUsersQuery() returns sql:ParameterizedQuery =>
    `SELECT * FROM User`;

/// Build query to fetch a user by ID.
/// + id - User ID
/// + return - sql:ParameterizedQuery for select by ID
isolated function getUserQuery(string id) returns sql:ParameterizedQuery =>
    `SELECT * FROM User WHERE id = ${id}`;

/// Build query to delete a user by ID.
/// + id - User ID
/// + return - sql:ParameterizedQuery for delete
isolated function deleteUserQuery(string id) returns sql:ParameterizedQuery =>
    `DELETE FROM User WHERE id = ${id}`;

/// Build query to update a user by ID.
/// + id - User ID
/// + user - Updated User record
/// + return - sql:ParameterizedQuery for update
isolated function updateUserQuery(string id, User user) returns sql:ParameterizedQuery =>
    `UPDATE User SET name = ${user.name}, email = ${user.email}, age = ${user.age}, role = ${user.role} WHERE id = ${id}`;

/// Build query to search users by name.
/// + name - Name to search for
/// + return - sql:ParameterizedQuery for search
isolated function searchUserQuery(string name) returns sql:ParameterizedQuery =>
    `SELECT * FROM User WHERE name = ${name}`;
