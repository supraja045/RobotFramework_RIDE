*** Settings ***
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           RequestsLibrary
Library           OperatingSystem
Library           Collections
Library           CSVLibrary
Library           String
Resource          ../SupportFiles/SupportSteps.robot
Library           ImageHorizonLibrary    reference_folder=${EXECDIR}/Data

*** Test Cases ***
Title
    [Tags]    title
    Open Browser    https://www.leafground.com/dashboard.xhtml    options=add_argument("--headless");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage");add_argument("--window-size=1920,1080")
    Wait Until Page Contains    Dashboard
    Title Should Be    Dashboard

Alert
    Set Selenium Implicit Wait    5s
    Open Browser    https://www.leafground.com/alert.xhtml    chrome
    Maximize Browser Window
    Element Should Be Visible    id:j_idt88:j_idt93
    Sleep    5s
    Click Element    id:j_idt88:j_idt93
    Handle Alert    DISMISS    5s
    Alert Should Not Be Present
    ${text}    Get Text    id:result
    Should Be Equal As Strings    ${text}    User Clicked : Cancel

Frames
    Open Browser    https://www.leafground.com/frame.xhtml    chrome
    Maximize Browser Window
    ${countFrame}    Get Element Count    //iframe
    ${innerCount}    Set Variable    0
    FOR    ${i}    IN RANGE    1    ${countFrame}+1
    Select Frame    xpath:(//iframe)[${i}]
    ${inner}=    Get Element Count    xpath://iframe
    #    Run Keyword If    ${inner}>0    ${innerCount}=    Evaluate    ${innerCount}+1
    IF    ${inner}>0
    ${innerCount}=    Evaluate    ${innerCount}+1
    END
    Log    Frame ${i} contains ${inner} nested frames
    Unselect Frame
    END
    ${totalCount}    Evaluate    ${countFrame}+${innerCount}
    Select Frame    xpath://iframe[@src='page.xhtml']
    Select Frame    xpath://iframe[@src='framebutton.xhtml']
    Click Element    //*[@id="Click"]
    Sleep    2s
    ${text}    Get Text    //*[@id="Click"]
    Should Be Equal As Strings    ${text}    Hurray! You Clicked Me.

MouseActions
    Open Browser    https://www.leafground.com/drag.xhtml    chrome
    Maximize Browser Window
    Drag And Drop    id:form:drag_content    id:form:drop
    sleep    2s
    ${dropped}    Get Text    //*[@id="form:drop_content"]//p
    Should Be Equal As Strings    ${dropped}    Dropped!
    Drag And Drop By Offset    id:form:conpnl    200    0
    sleep    5s

Links
    Open Browser    https://www.leafground.com/link.xhtml    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@class="grid formgrid"]
    ${attribute}    Get Element Attribute    (//*[@id="j_idt87"]//a)[contains(text(),'without clicking me.')]    href
    Should Contain    ${attribute}    grid.xhtml

DropDowns
    Open Browser    https://www.leafground.com/select.xhtml    headlesschrome
    Click Element    //h5[contains(text(),'Which is your favorite UI Automation tool?')]/..//select
    Select From List By Label    //h5[contains(text(),'Which is your favorite UI Automation tool?')]/..//select    Cypress
    sleep    3s

MultipleWindow
    Open Browser    https://www.leafground.com/    chrome
    Maximize Browser Window
    ${handles}    Get Window Handles
    Execute Javascript    window.open("https://www.leafground.com/alert.xhtml")
    ${noOfWindows}    Get Window Handles
    Switch Window    NEW
    Page Should Contain    Alert
    sleep    5s
    Switch Window    ${noOfWindows}[0]
    Page Should Contain    Dashboard
    sleep    5s

Webtable
    [Tags]    file
    Open Browser    https://www.leafground.com/table.xhtml    chrome
    Maximize Browser Window
    ${noOfRows}    Get Element Count    //*[@id="form:j_idt89_data"]/tr
    Log To Console    ${noOfRows}
    Log    ${noOfRows}
    FOR    ${i}    IN RANGE    ${noOfRows}
    ${country}    Get Text    //*[@data-ri="${i}"]//span[text()='Country']/following-sibling::span[2]
    END
    sleep    10s

FileUpload
    [Tags]    file
    [Setup]    Remove File    C:\\Users\\supra\\Downloads\\TestLeaf Logo(1).png
    Open Browser    https://www.leafground.com/file.xhtml
    Maximize Browser Window
    Choose File    //*[@id="j_idt88:j_idt89_input"]    D:\\Professional\\Resume\\Resume_Trainer.pdf
    sleep    5s
    ${fileName}    Get Text    //*[@id="j_idt88:j_idt89"]/span[contains(@class,'filename')]
    Should Be Equal As Strings    ${fileName}    Resume_Trainer.pdf 35.8 KB
    Click Element    //*[@id="j_idt93:j_idt95"]
    sleep    5s
    Wait Until Keyword Succeeds    1m    5s    File Should Exist    C:\\Users\\supra\\Downloads\\TestLeaf Logo(1).png

DropdownSorting
    Open Browser    https://www.leafground.com/select.xhtml    chrome
    Maximize Browser Window
    Set Selenium Implicit Wait    10s
    Element Should Be Visible    //*[@id="j_idt87:country_input"]/preceding::select
    ${items}    Get List Items    //*[@id="j_idt87:country_input"]/preceding::select
    ${copy}    Copy List    ${items}
    Sort List    ${copy}
    Sort List    ${items}
    Remove Values From List    ${copy}    Select Tool
    Remove Values From List    ${items}    Select Tool
    Should Be Equal    ${items}    ${copy}
    #Finding Duplicates
    ${unique}    Remove Duplicates    ${items}
    Should Be Equal    ${items}    ${unique}
    Select From List By Label    //*[@id="j_idt87:country_input"]/preceding::select    Selenium
    sleep    5s

ImageTesting
    Open Browser    https://www.leafground.com/charts.xhtml    chrome
    Maximize Browser Window
    Wait Until Page Contains    id=j_idt89_canvas    2m
    Element Should Be Visible    id=j_idt89_canvas
    Capture element screenshot    id=j_idt89_canvas    chart_screenshot.png
    Wait For    chart_screenshot.png
    Click Image    chart_screenshot.png

FileHandling
    ${contents}    Get File    D:\\Professional\\Learning\\My Learnings\\Scenario Based\\FileWriting.txt
    ${lineCount}    Get Line Count    ${contents}
    FOR    ${i}    IN RANGE    2
        ${line}    Get Line    ${contents}    ${i}
    END
