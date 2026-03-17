*** Settings ***
Library           CSVLibrary
Library           DatabaseLibrary
Library           OperatingSystem

*** Test Cases ***
TC1_DB
    DatabaseLibrary.Connect To Database    pymysql    employeeschema    root    root    127.0.0.1    3306
    ${query_result}    Query    SELECT * FROM emp_personal_details;
    OperatingSystem.Create File    ${CURDIR}/test.csv
    CSVLibrary.Append To Csv File    ${CURDIR}/test.csv    ${query_result}
    DatabaseLibrary.Row Count

