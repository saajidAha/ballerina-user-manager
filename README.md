# User Management Backend

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

| Code | Description |
|------|-------------|
| 200  | Success     |
| 404  | Not Found   |

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

| Code | Description |
|------|-------------|
| 200  | Success     |
| 400  | Bad Request |
| 404  | Not Found   |

---

#### DELETE

##### Summary:
Delete a user by ID.

##### Parameters

| Name | Located in | Description | Required | Schema |
|------|------------|-------------|----------|--------|
| id   | path       | User ID     | Yes      | string |

##### Responses

| Code | Description |
|------|-------------|
| 204  | No Content  |
| 404  | Not Found   |
| 500  | Internal Server Error |

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
| 200  | Success     | ```json
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
| 404  | Not Found   | ```json
{ "error": "Failed to retrieve user with name: Alice. User does not exist" }
``` |
| 500  | Internal Server Error | ```json
{ "error": "Failed to retrieve user with name: Alice" }
``` |

---

### /users

#### GET

##### Summary:
Retrieve all users.

##### Responses

| Code | Description |
|------|-------------|
| 200  | Success     |
| 500  | Internal Server Error |

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

| Code | Description |
|------|-------------|
| 201  | Created     |
| 400  | Bad Request |
