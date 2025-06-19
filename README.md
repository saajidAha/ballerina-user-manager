# User Management Backend

> **Note:** Please set up a local MySQL database and edit the `modules/database/client.bal` file based on your database configuration. Then, create a table called `User` in your database according to the structure defined in `modules/database/types.bal`.
>
> **Demo:** A demo video is also available in the root of this repository as `DEMO_VIDEO.webm`.

## Version: 1

### /users/{id}

#### GET

##### Summary:
Retrieve a user by ID.

##### Parameters

| Name | Located in | Description | Required | Schema |
|------|------------|-------------|----------|--------|
| id   | path       | User ID     | Yes      | string |

##### Responses

| Code | Description | Example Payload |
|------|-------------|----------------|
| 200  | Success     | 
```json
{
  "id": "1",
  "name": "Alice",
  "email": "alice@example.com",
  "age": 25,
  "role": "admin"
}
```
| 404  | Not Found   | 
```json
{ "error": "Failed to retreive user with id: 1. User does not exist" }
```

---

#### PUT

##### Summary:
Update a user by ID.

##### Parameters

| Name | Located in | Description      | Required | Schema |
|------|------------|------------------|----------|--------|
| id   | path       | User ID          | Yes      | string |
| user | Payload    | Updated user     | Yes      | User   |

Example Payload:
```json
{
  "id": "1",
  "name": "Alice Updated",
  "email": "alice.updated@example.com",
  "age": 26,
  "role": "admin"
}
```

##### Responses

| Code | Description | Example Payload |
|------|-------------|----------------|
| 200  | Success     |                |
| 400  | Bad Request | 
```json
{ "error": "Failed to update user with id: 1. Please check if the you have added the user info in a correct format" }
```
| 404  | Not Found   | 
```json
{ "error": "Failed to update user with id: 1. User does not exist" }
```

---

#### DELETE

##### Summary:
Delete a user by ID.

##### Parameters

| Name | Located in | Description | Required | Schema |
|------|------------|-------------|----------|--------|
| id   | path       | User ID     | Yes      | string |

##### Responses

| Code | Description | Example Payload |
|------|-------------|----------------|
| 204  | No Content  |                |
| 404  | Not Found   | 
```json
{ "error": "Failed to delete user with id: 1. User does not exist" }
```
| 500  | Internal Server Error | 
```json
{ "error": "Failed to delete user with id: 1" }
```

---

### /user

#### GET

##### Summary:
Search for users by name.

##### Parameters

| Name | Located in | Description   | Required | Schema |
|------|------------|---------------|----------|--------|
| name | query      | User name     | Yes      | string |

##### Responses

| Code | Description | Example Payload |
|------|-------------|----------------|
| 200  | Success     | 
```json
[
  {
    "id": "1",
    "name": "Alice",
    "email": "alice@example.com",
    "age": 25,
    "role": "admin"
  }
]
```
| 404  | Not Found   | 
```json
{ "error": "Failed to retrieve user with name: Alice. User does not exist" }
```
| 500  | Internal Server Error | 
```json
{ "error": "Failed to retrieve user with name: Alice" }
```

---

### /users

#### GET

##### Summary:
Retrieve all users.

##### Responses

| Code | Description | Example Payload |
|------|-------------|----------------|
| 200  | Success     | 
```json
[
  {
    "id": "1",
    "name": "Alice",
    "email": "alice@example.com",
    "age": 25,
    "role": "admin"
  }
]
```
| 500  | Internal Server Error | 
```json
{ "error": "Failed to retrieve users" }
```

---

#### POST

##### Summary:
Add a new user.

##### Parameters

| Name    | Located in | Description      | Required | Schema |
|---------|------------|------------------|----------|--------|
| newUser | Payload    | User to add      | Yes      | User   |

Example Payload:
```json
{
  "id": "2",
  "name": "Bob",
  "email": "bob@example.com",
  "age": 30,
  "role": "user"
}
```

##### Responses

| Code | Description | Example Payload |
|------|-------------|----------------|
| 201  | Created     |                |
| 400  | Bad Request | 
```json
{ "error": "Failed to add new user. Please check if the you have added the user info in a correct format" }
```
