public function createAndPopulateDB() returns error? {
    // Create the User table if it does not exist
    check createUserTable();
    // Insert dummy users
    check insertDummyUsers();
}