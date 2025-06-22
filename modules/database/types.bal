// User type representing the User table in the database
public type User record {
    int id;
    string name;
    string email;
    int age?;
    string role?;
};

// Configuration type to load the db configuration variables from the config.toml 
public type DatabaseConfig record {|
    string HOST;
    string USER;
    string PASSWORD;
    string DATABASE;
    int PORT;
|};