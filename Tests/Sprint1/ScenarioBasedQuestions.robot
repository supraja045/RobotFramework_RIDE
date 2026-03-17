*** Settings ***
Test Teardown     Close All Browsers
Library           SeleniumLibrary
Library           RequestsLibrary
Library           OperatingSystem
Library           Collections

*** Test Cases ***
SwitchToaSpecificWindow
    Open Browser    https://www.leafground.com/window.xhtml    headlesschrome
    Wait Until Element Is Visible    //*[@id="j_idt88:new"]
    Click Element    //*[@id="j_idt88:new"]
    ${windows}    Get Window Titles
    Switch Window    Dashboard
    Title Should Be    Dashboard
    Switch Window    Window
    Title Should Be    Window

SelectDropDownWOIndex
    Open Browser    https://www.leafground.com/select.xhtml    chrome
    Maximize Browser Window
    Page Should Contain Element    //*[@class="ui-selectonemenu"]
    Click Element    //*[@class="ui-selectonemenu"]
    Select From List By Label    //*[@class="ui-selectonemenu"]    Selenium
    sleep    5s

MultiSelectDropdown
    Open Browser    https://www.htmlelements.com/demos/dropdownlist/multiple-selection/index.htm    chrome
    Wait Until Element Is Visible    //*[@smart-id="actionButton"]    2m
    Click Element    //*[@smart-id="actionButton"]
    Click Element    (//*[@smart-id="itemContainer"])[1]
    Click Element    (//*[@smart-id="itemContainer"])[3]
    sleep    5s

SlowLoadingIssue
    Open Browser    https://www.leafground.com/window.xhtml
    Set Selenium Page Load Timeout    30s

ExceptionHandling
    #Way1
    TRY
    Click Button    //button
    EXCEPT
    Log    Some exception
    FINALLY
    Log    This always executes
    END
    #Way2
    Run Keyword And Ignore Error
    #Way3
    #Explicit wait conditions
    Wait Until Page Contains Element    #id

TooltipWithPopup
    Open Browser    https://www.leafground.com/select.xhtml    chrome
    Maximize Browser Window
    ${attribute}    Get Element Attribute    //*[@id="menuform:j_idt36"]    class
    Log To Console    $attribute}
    sleep    5s

UploadMultipleFiles
    Open Browser    https://davidwalsh.name/demo/multiple-file-upload.php    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    //*[@id="filesToUpload"]    1m
    ${FILE1}    Set Variable    C:\\Users\\supra\\OneDrive\\Pictures\\Screenshots\\AAA1.png
    ${FILE2}    Set Variable    C:\\Users\\supra\\OneDrive\\Pictures\\Screenshots\\AAA2.png
    ${files}    Catenate    SEPARATOR=\n    ${FILE1}    ${FILE2}
    Choose File    //*[@id="filesToUpload"]    ${files}
    sleep    5s

ScrollToBottomofAPage
    Open Browser    https://www.leafground.com/dashboard.xhtml    chrome
    Maximize Browser Window
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight)
    sleep    5s
    Execute Javascript    window.scrollTo(0,0)
    sleep    5s

CheckboxApperasDynamically
    #Consider a scenario where a "Terms and Conditions" checkbox is displayed only if a user selects a specific option/link. How would you verify this dynamic behavior in your test?    I would first validate the initial state of the checkbox, whether it is hidden or absent. Then I would trigger the user action, such as selecting the specific option or link, and use an explicit wait to verify that the Terms and Conditions checkbox appears. The exact assertion depends on whether the element is hidden initially or dynamically added to the DOM.
    Open Browser
    Maximize Browser Window
    Element Should Not Be Visible
    Click Element
    Wait Until Element Is Visible
    Element Should Be Visible
