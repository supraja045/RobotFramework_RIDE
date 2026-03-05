*** Variables ***
${baseUrl}        https://petstore.swagger.io/

*** Settings ***
Library           RequestsLibrary
Library           FakerLibrary
Library           JSONLibrary
Library           OperatingSystem

*** Test Cases ***
GET
    [Tags]    get
    ${headers}    Create Dictionary    content-type=application/json
    ${BASE_URL}    Get Environment Variable    BASE_URL
    Log    ${BASE_URL}
    Create Session    api1    \    headers=${headers}
    ${response}    GET On Session    api1    /v2/pet/170190
    ${id}    JSONLibrary.Get Value From Json    ${response.json()}    $..id
    Should Be Equal As Strings    ${id}[0]    170190

POST
    [Tags]    post
    ${headers}    Create Dictionary    content-type=application/json
    Create Session    api1    ${baseUrl}
    #    ${body}    Set Variable    {"id": 180892, "name": "doggie", "status": "available"}
    ${body}    Create Dictionary    id=180894    name="Supraja J"    status="available"
    ${response}    POST On Session    api1    /v2/pet    headers=${headers}    json=${body}
    Log To Console    ${response.json()}
    ${id}    JSONLibrary.Get Value From Json    ${response.json()}    $..id
    ${response}    GET On Session    api1    /v2/pet/${id}[0]
    Log To Console    ${response.json()}

POST1
    [Tags]    post1
    ${headers}    Create Dictionary    content-type=application/json
    # ${AUTH}    Create Dictionary    auth=abc123
    Create Session    api1    https://petstore.swagger.io/    headers=${headers}
    ${body}    Create Dictionary    id=170191    name="muthu"
    ${response}    POST On Session    api1    /v2/pet    json=${body}
    # ${response}    POST On Session    api1    /v2/pet    headers=${headers}    json=${body}
    ${id}    Get Value From Json    ${response.json()}    id
    ${name}    Get Value From Json    ${response.json()}    $..name
    ${photoUrl}    Get Value From Json    ${response.json()}    $..photoUrls
    Log To Console    Trying to commit from feature branch supraja045-patch-1
    Log    adding details supraja045-patch-1 branch ${/}
