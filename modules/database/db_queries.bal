// Copyright (c) 2024, WSO2 LLC. (https://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 LLC. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/sql;

isolated function addUserQuery(User user) returns sql:ParameterizedQuery =>
    `INSERT INTO User (id, name, email, age, role) VALUES (${user.id}, ${user.name}, ${user.email}, ${user.age}, ${user.role})`;

isolated function getAllUsersQuery() returns sql:ParameterizedQuery =>
    `SELECT * FROM User`;

isolated function getUserQuery(string id) returns sql:ParameterizedQuery =>
    `SELECT * FROM User WHERE id = ${id}`;

isolated function deleteUserQuery(string id) returns sql:ParameterizedQuery =>
    `DELETE FROM User WHERE id = ${id}`;

isolated function updateUserQuery(string id, User user) returns sql:ParameterizedQuery =>
    `UPDATE User SET name = ${user.name}, email = ${user.email}, age = ${user.age}, role = ${user.role} WHERE id = ${id}`;

isolated function searchUserQuery(string name) returns sql:ParameterizedQuery =>
    `SELECT * FROM User WHERE name = ${name}`;
