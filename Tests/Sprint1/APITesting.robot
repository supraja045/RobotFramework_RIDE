*** Variables ***
${baseUrl}        https://petstore.swagger.io/

*** Settings ***
Library           RequestsLibrary
Library           FakerLibrary
Library           JSONLibrary
Library           OperatingSystem
Resource          ../SupportFiles/APISupportSteps.robot

*** Test Cases ***    \
GET                   [Tags]                                              get
                      Create_My_Session
                      ${response}                                         GET On Session                                                                                                                                                                   api1                             /v2/pet/170190
                      ${id}                                               JSONLibrary.Get Value From Json                                                                                                                                                  ${response.json()}               $..id
                      Should Be Equal As Strings                          ${id}[0]                                                                                                                                                                         170190

POST                  [Tags]                                              post
                      #                                                   ${headers}                                                                                                                                                                       Create Dictionary                content-type=application/json
                      #                                                   Create Session                                                                                                                                                                   api1                             ${baseUrl}
                      #                                                   ${body}                                                                                                                                                                          Set Variable                     {"id": 180892, "name": "doggie", "status": "available"}
                      Create_My_Session
                      ${body}                                             Create Dictionary                                                                                                                                                                id=180894                        name="Supraja J"                                           status="available"
                      ${response}                                         POST On Session                                                                                                                                                                  api1                             /v2/pet                                                    headers=${headers}    json=${body}
                      Log To Console                                      ${response.json()}
                      ${id}                                               JSONLibrary.Get Value From Json                                                                                                                                                  ${response.json()}               $..id
                      ${response}                                         GET On Session                                                                                                                                                                   api1                             /v2/pet/${id}[0]
                      Log To Console                                      ${response.json()}

POST1                 [Tags]                                              post1
                      ${headers}                                          Create Dictionary                                                                                                                                                                content-type=application/json
                      # ${AUTH}                                           Create Dictionary                                                                                                                                                                auth=abc123
                      Create Session                                      api1                                                                                                                                                                             https://petstore.swagger.io/     headers=${headers}
                      ${body}                                             Create Dictionary                                                                                                                                                                id=170191                        name="muthu"
                      ${response}                                         POST On Session                                                                                                                                                                  api1                             /v2/pet                                                    json=${body}
                      # ${response}                                       POST On Session                                                                                                                                                                  api1                             /v2/pet                                                    headers=${headers}    json=${body}
                      ${id}                                               Get Value From Json                                                                                                                                                              ${response.json()}               id
                      ${name}                                             Get Value From Json                                                                                                                                                              ${response.json()}               $..name
                      ${photoUrl}                                         Get Value From Json                                                                                                                                                              ${response.json()}               $..photoUrls
                      Log To Console                                      Trying to commit from feature branch supraja045-patch-1
                      Log                                                 adding details supraja045-patch-1 branch ${/}

PUT                   Create_My_Session
                      ${body}                                             Create Dictionary                                                                                                                                                                id=170190                        name=Navaneethakrishnan
                      ${response}                                         PUT On Session                                                                                                                                                                   api1                             /v2/pet                                                    headers=${headers}    json=${body}
                      ${id}                                               Get Value From Json                                                                                                                                                              ${response.json()}               $.id
                      ${name}                                             Get Value From Json                                                                                                                                                              ${response.json()}               $.name

SampleTCWithBearerToken
                      Create Session                                      api1                                                                                                                                                                             ${BASE_URL}
                      ${headers}                                          Create Dictionary                                                                                                                                                                content-type=application/json    Authorization=Bearer ${token}
                      ${body}                                             Create Dictionary                                                                                                                                                                id=1808192                       name=Suppuni
                      ${response}                                         POST On Session                                                                                                                                                                  api1                             /v2/pet                                                    headers=${headers}    json=${body}
                      ${id}                                               Get Value From Json                                                                                                                                                              ${response.json()}               $.id
                      ${name}                                             Get Value From Json                                                                                                                                                              ${response.json()}               $.name
                      #QUERY PARAMS ARE PASSED USING params=${params}}    #In Robot Framework, path parameters are passed directly in the endpoint URL, while query parameters are passed using the params argument as a dictionary in RequestsLibrary.

DELETE                ${headers}                                          Create Dictionary                                                                                                                                                                content-type=application/json    api_key=abc123
                      Create Session                                      api1                                                                                                                                                                             https://petstore.swagger.io      headers=${headers}
                      ${response}                                         DELETE On Session                                                                                                                                                                api1                             /v2/pet/399548
                      ${status}                                           Get Value From Json                                                                                                                                                              ${response.json()}               $.message
