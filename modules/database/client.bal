import ballerinax/mysql;

// Variables for the database configurations
configurable string HOST = "localhost";
configurable int PORT = 3306;
configurable string USER = "root";
configurable string PASSWORD = "abc123";
configurable string DATABASE = "test";

// Initialize a database connection
public final mysql:Client db_connection = check new (host = HOST, user = USER, password = PASSWORD, database = DATABASE, port = PORT);