*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections
Resource   variable_validate_api.robot



*** Test Cases ***
Validate Key & Value on Get User List Request
    [Documentation]    Test Get request to endpoint
    [Tags]             api
    Create Session                   api_testing                                         ${get_userList_endpoint}
    ${response}=                     GET On Session                                      api_testing                                                           get
    ${json_response_getUserList}=    Set Variable                                        ${response.json()}
    Status Should Be                 200                                                 ${response}
    #Verify page
    Dictionary Should Contain Key    ${json_response_getUserList}                        page
    ${page_is_int}=                  Evaluate                                            isinstance(${json_response_getUserList['page']}, int)
    #Verify per_page
    Dictionary Should Contain Key    ${json_response_getUserList}                        per_page
    ${per_page_is_int}=              Evaluate                                            isinstance(${json_response_getUserList['per_page']}, int)
    #Verify total
    Dictionary Should Contain Key    ${json_response_getUserList}                        total
    ${total_is_int}=                 Evaluate                                            isinstance(${json_response_getUserList['total']}, int)
    #Verify total_pages
    Dictionary Should Contain Key    ${json_response_getUserList}                        total_pages
    ${total_pages_is_int}=           Evaluate                                            isinstance(${json_response_getUserList['total_pages']}, int)
    #Verify data
    Dictionary Should Contain Key    ${json_response_getUserList}                        data
    ${data_is_int}=                  Evaluate                                            isinstance(${json_response_getUserList['data']}, list)
    #Verify support
    Dictionary Should Contain Key    ${json_response_getUserList}                        support
    ${support_is_int}=               Evaluate                                            isinstance(${json_response_getUserList['support']}, object)
    #Verify support url
    Dictionary Should Contain Key    ${json_response_getUserList['support']}             url
    ${support_url}                   Set Variable                                        ${json_response_getUserList['support']['url']}
    ${support_is_string}             Evaluate                                            isinstance('${support_url}', str)
    #Verify support text
    Dictionary Should Contain Key    ${json_response_getUserList['support']}             text
    ${support_text}                  Set Variable                                        ${json_response_getUserList['support']['text']}
    ${is_string}                     Evaluate                                            isinstance("${support_text}", str)

    #Loop For get array object
    FOR    ${user}    IN    @{json_response_getUserList['data'][0]}
    ${value}                         Set Variable                                        ${user}
    Dictionary Should Contain Key    ${json_response_getUserList['data'][0]}             ${user}
    ${value}                         Set Variable                                        ${json_response_getUserList['data'][0]}
    Append To List                   ${my_list}                                          ${value}
    END
    
    #Loop For check each key in object
    FOR    ${item}    IN    @{my_list}
    #Verify id
    Dictionary Should Contain Key    ${item}                                             id
    ${item_id}                       Set Variable                                        ${item['id']}
    ${item_id_is_int}=               Evaluate                                            isinstance(${item_id}, int)
    #Verify name
    Dictionary Should Contain Key    ${item}                                             name
    ${item_name}                     Set Variable                                        ${item['name']}
    ${item_name_is_str}=             Evaluate                                            isinstance('${item_name}', str)
    #Verify year
    Dictionary Should Contain Key    ${item}                                             year
    ${item_year}                     Set Variable                                        ${item['year']}
    ${item_year_is_str}=             Evaluate                                            isinstance(${item_year}, str)
    #Verify color
    Dictionary Should Contain Key    ${item}                                             color
    ${item_color}                    Set Variable                                        ${item['color']}
    ${item_year_is_str}=             Evaluate                                            isinstance('${item_color}', str)
    #Verify pantone_value
    Dictionary Should Contain Key    ${item}                                             pantone_value
    ${item_pantone_value}            Set Variable                                        ${item['pantone_value']}
    ${item_pantone_value_is_str}=    Evaluate                                            isinstance(${item_pantone_value}, str)
    END

Validate Key & Value on Post Create User Request
    [Documentation]    Test POST request to endpoint
    [Tags]             api
    Create Session                   api_testing                                         ${post_addUser_endpoint}
    ${body}=                         Create Dictionary                                   name=FirstName001 Lastname001                                        job=Automate test
    ${headers}=                      Create Dictionary                                   Content-Type=application/json
    ${response}=                     POST On Session                                     api_testing                                                          /users                    ${body}    ${headers}
    ${json_response_postAddUser}=    Set Variable                                        ${response.json()}
    Status Should Be                 201                                                 ${response}
    #Verify name
    Dictionary Should Contain Key    ${json_response_postAddUser}                        name
    ${name}=                         Set Variable                                        FirstName001 Lastname001
    Should Be Equal                  ${name}                                             ${json_response_postAddUser['name']}
    #Verify job
    Dictionary Should Contain Key    ${json_response_postAddUser}                        job
    ${job}=                          Set Variable                                        Automate test
    Should Be Equal                  ${job}                                              ${json_response_postAddUser['job']}
    #Verify id
    Dictionary Should Contain Key    ${json_response_postAddUser}                        id
    ${page_is_int}=                  Evaluate                                            isinstance('${json_response_postAddUser['id']}', str)
    #Verify createdAt
    Dictionary Should Contain Key    ${json_response_postAddUser}                        createdAt
    ${page_is_int}=                  Evaluate                                            isinstance('${json_response_postAddUser['createdAt']}', str)