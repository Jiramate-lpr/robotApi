*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections

*** Variables ***
${get_userList_endpoint}       https://reqres.in/api/users?page=2
${post_addUser_endpoint}       https://reqres.in/api/users
${DATETIME_REGEX}              ^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}Z$
@{my_list}