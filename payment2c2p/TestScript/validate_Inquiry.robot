*** Settings ***
Resource    ../TestResource/Keywords/AllKeywords.txt

*** Test Cases ***
Full Payment in case validate parameter body Mandatory / Optional condition Missing
    [Setup]       Run Keywords                                Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                                         Set Test Variable    ${SHEET_NAME}    ${SHEET_Validate_Inquiry}
    [Teardown]    Close Browser
    [Template]    API_Validation_Parameter_Inquiry_Missing
   #rowNo        statusCode                          testcaseNo
    2             400                                         APISI1001_400
    3             400                                         APISI1001_401
    4             400                                         APISI1001_403

Full Payment in case validate parameter body Mandatory / Optional condition Empty
    [Setup]       Run Keywords                              Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                                       Set Test Variable    ${SHEET_NAME}    ${SHEET_Validate_Inquiry}
    [Teardown]    Close Browser
    [Template]    API_Validation_Parameter_Inquiry_Empty
   #rowNo        statusCode                          testcaseNo
    5             400                                       APISI1001_400
    6             400                                       APISI1001_401
    7             400                                       APISI1001_403

Full Payment in case validate parameter body Mandatory / Optional condition Invalid
    [Setup]       Run Keywords                                Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                                         Set Test Variable    ${SHEET_NAME}    ${SHEET_Validate_Inquiry}
    [Teardown]    Close Browser
    [Template]    API_Validation_Parameter_Inquiry_Invalid
   #rowNo        statusCode                          testcaseNo
    8             400                                         APISI1001_800
    9             400                                         APISI1001_801
    10            400                                         APISI1001_803