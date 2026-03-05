*** Settings ***
Library           SeleniumLibrary
Library           RequestsLibrary
Library           OperatingSystem
Library           Collections
Library           CSVLibrary
Library           Screenshot
Library           String

*** Keywords ***
I open the browser to the Leaf ground page
    Open Browser    https://www.leafground.com/dashboard.xhtml chrome    chrome

I wait for the page to load
    Wait Until Page Contains    Dashboard

I should see the title "Dashboard"
    Title Should Be    Dashboard
    [Teardown]    Close All Browsers

I click on the Browser button
    Wait Until Element Is Visible    //*[@class='pi pi-globe layout-menuitem-icon']
    Click Element    //*[@class='pi pi-globe layout-menuitem-icon']

I click on the Alert box section
    Wait Until Element Is Visible    //*[@class="pi pi-fw pi-clone layout-menuitem-icon"]
    Click Element //*[@class="pi pi-fw pi-clone layout-menuitem-icon"]

I should see the simple alert message "I am a simple alert"
    Wait Until Element Is Visible    //*[@id="simple_result"]/preceding::button
    Click Element //*[@id="simple_result"]/preceding::button
    SeleniumLibrary.Handle Alert    action=ACCEPT
    ${simpleAlertOp}=    Get Text    //*[@id="simple_result"]
    Should Be Equal    ${simpleAlertOp}    You have successfully clicked an alert
    Capture Page Screenshot

I should see the alert message "You have successfully clicked an alert"
    Wait Until Element Is Visible    //*[@id="j_idt88:j_idt93"]
    Click Element    //*[@id="j_idt88:j_idt93"]
    SeleniumLibrary.Handle Alert    action=ACCEPT
    ${confirmAlertOp}=    Get Text    //*[@id="result"]
    Should Be Equal    ${confirmAlertOp}    User Clicked : OK
    Capture Page Screenshot
