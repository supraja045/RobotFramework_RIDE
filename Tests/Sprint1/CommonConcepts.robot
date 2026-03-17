*** Settings ***
Library           RequestsLibrary
Library           SeleniumLibrary
Library           OperatingSystem
Library           CSVLibrary
Library           ImageHorizonLibrary
Library           Process
Library           DatabaseLibrary
Library           DateTime
Library           String

*** Test Cases ***
SoftAssertion
    Open Browser    https://www.leafground.com    chrome
    Maximize Browser Window
    Run Keyword And Ignore Error
    Run Keyword If All Tests Passed
