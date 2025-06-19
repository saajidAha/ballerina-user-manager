import ballerinax/mysql;

// load the database configuration variables from the config.toml
public configurable DatabaseConfig dbConfig = ?;

// Initialize a database connection
public final mysql:Client db_connection = check new (host = dbConfig.HOST, user = dbConfig.USER, password = dbConfig.PASSWORD, database = dbConfig.DATABASE, port = dbConfig.PORT);