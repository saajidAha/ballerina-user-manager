import ballerina/sql;

# Build query to create the User table if it does not exist.
# + return - sql:ParameterizedQuery for table creation
isolated function createUserTableQuery() returns sql:ParameterizedQuery =>
    `CREATE TABLE IF NOT EXISTS User
     (
        id INT PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        email VARCHAR(255) NOT NULL,
        age INT,
        role VARCHAR(255)
    )`;

# Build query to insert multiple dummy users.
# + return - sql:ParameterizedQuery for inserting dummy data
isolated function insertDummyUsersQuery() returns sql:ParameterizedQuery =>
    `INSERT INTO User
        (   
        id,
        name,
        email,
        age,
        role
        )
        VALUES
        (1, 'Alice', 'alice@example.com', 25, 'admin'),
        (2, 'Bob', 'bob@example.com', 30, 'user'),
        (3, 'Charlie', 'charlie@example.com', 28, 'user'),
        (4, 'Diana', 'diana@example.com', 22, 'manager'),
        (5, 'Eve', 'eve@example.com', 35, 'admin')`;

# Build query to fetch all users.
# + return - sql:ParameterizedQuery for select all
isolated function getAllUsersQuery() returns sql:ParameterizedQuery =>
    `SELECT
        *
     FROM
        User`;

# Build query to fetch a user by ID.
# + id - User ID
# + return - sql:ParameterizedQuery for select by ID
isolated function getUserQuery(string id) returns sql:ParameterizedQuery =>
    `SELECT
        *
     FROM
        User
     WHERE
        id = ${id}`;

# Build query to search users by name.
# + name - Name to search for
# + return - sql:ParameterizedQuery for search
isolated function searchUserQuery(string name) returns sql:ParameterizedQuery =>
    `SELECT
        *
     FROM
        User
     WHERE
        name = ${name}`;

# Build query to add a user.
# + user - User record to add
# + return - sql:ParameterizedQuery for insert
isolated function addUserQuery(User user) returns sql:ParameterizedQuery =>
    `INSERT INTO User
        (
            id,
            name,
            email,
            age,
            role
        )
     VALUES
        (
            ${user.id},
            ${user.name},
            ${user.email},
            ${user.age},
            ${user.role}
        )`;

# Build query to delete a user by ID.
# + id - User ID
# + return - sql:ParameterizedQuery for delete
isolated function deleteUserQuery(string id) returns sql:ParameterizedQuery =>
    `DELETE FROM
        User
     WHERE
        id = ${id}`;

# Build query to update a user by ID.
# + id - User ID
# + user - Updated User record
# + return - sql:ParameterizedQuery for update
isolated function updateUserQuery(string id, User user) returns sql:ParameterizedQuery =>
    `UPDATE
        User
     SET
        name = ${user.name},
        email = ${user.email},
        age = ${user.age},
        role = ${user.role}
     WHERE
        id = ${id}`;
