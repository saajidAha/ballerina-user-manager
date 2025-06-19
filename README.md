# User Management Backend

## Version: 1

### /users

#### GET

##### Summary:
Retrieve all users.

##### Responses

| Code | Description | Example Payload |
|------|-------------|----------------|
| 200  | OK          | ```json
[
  {
    "id": "1",
    "name": "Alice",
    "email": "alice@example.com",
    "age": 25,
    "role": "admin"
  }
]
``` |
| 500  | Internal Server Error | ```json
{ "message": "Error occurred while retrieving users." }
``` |

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
| 400  | Bad Request | ```json
{ "message": "Invalid user data." }
``` |

---

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
| 200  | OK          | ```json
{
  "id": "1",
  "name": "Alice",
  "email": "alice@example.com",
  "age": 25,
  "role": "admin"
}
``` |
| 404  | Not Found   | ```json
{ "message": "User not found." }
``` |

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
| 200  | OK          |                |
| 400  | Bad Request | ```json
{ "message": "Invalid user data." }
``` |

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
| 400  | Bad Request | ```json
{ "message": "Invalid user ID." }
``` |

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
| 200  | OK          | ```json
[
  {
    "id": "1",
    "name": "Alice",
    "email": "alice@example.com",
    "age": 25,
    "role": "admin"
  }
]
``` |
| 400  | Bad Request | ```json
{ "message": "Invalid query parameter." }
``` |
