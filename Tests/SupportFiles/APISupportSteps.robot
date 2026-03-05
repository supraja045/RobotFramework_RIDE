*** Settings ***
Library           RequestsLibrary
Library           JSONLibrary
Library           Collections
Library           OperatingSystem
Library           JSONLibrary

*** Keywords ***
Create_My_Session
    ${headers}    Create Dictionary    content-type=application/json
    Create session    api1    ${BASE_URL}    headers=${headers}
    Set Global Variable    ${headers}

ExtractBearerToken
    {login_body}    Create Dictionary    username=admin    password=abc123
    ${login_response}    POST On Session    loginApi    /api1/v2    json=${login_body}
    ${token}    Get Value From Json    ${login_response.json()}    $.token
    Set Global Variable    ${token}    ${token}[0]
