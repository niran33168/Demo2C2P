*** Settings ***
Resource    ../TestResource/Keywords/AllKeywords.txt

*** Test Cases ***
Payment Direct Main flow status approve Credit
    [Setup]       Run Keywords                     Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                              Set Test Variable    ${SHEET_NAME}    ${SHEET_Direct}
    [Teardown]    Close Browser
    [Template]    API_Validation_Payment_Direct
   #rowNo        statusCode                       testcaseNo
    2             200                              DR1001_001
    3             200                              DR1001_002
    4             200                              DR1001_003

Direct in case error from Handling error
    [Setup]       Run Keywords                 Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                          Set Test Variable    ${SHEET_NAME}    ${SHEET_Direct}
    [Teardown]    Close Browser
    [Template]    API_Handling_Error_Direct
   #rowNo        statusCode                   testcaseNo
    5             404                          DR1003_200 
    6             400                          DR1003_201

validations in case error from Business Case
    [Setup]       Run Keywords                     Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                              Set Test Variable    ${SHEET_NAME}    ${SHEET_Direct}
    [Teardown]    Close Browser
    [Template]    API_Validation_Payment_Direct
   #rowNo        statusCode                   testcaseNo
    7             400                              DR1004_300
    10            400                              DR1004_301
