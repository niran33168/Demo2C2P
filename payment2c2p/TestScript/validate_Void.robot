*** Settings ***
Resource    ../TestResource/Keywords/AllKeywords.txt

*** Test Cases ***
Full Payment in case validate parameter body Mandatory / Optional condition Missing
    [Setup]       Run Keywords                             Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                                      Set Test Variable    ${SHEET_NAME}    ${SHEET_Validate_Void}
    [Teardown]    Close Browser
    [Template]    API_Validation_Parameter_Void_Missing
   #rowNo        statusCode                          testcaseNo
    2             400                                      APIV1001_400
    3             400                                      APIV1001_401
    4             400                                      APIV1001_402
    5             400                                      APIV1001_403

Full Payment in case validate parameter body Mandatory / Optional condition Empty
    [Setup]       Run Keywords                           Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                                    Set Test Variable    ${SHEET_NAME}    ${SHEET_Validate_Void}
    [Teardown]    Close Browser
    [Template]    API_Validation_Parameter_Void_Empty
   #rowNo        statusCode                          testcaseNo
    6             400                                    APIV1001_600
    7             400                                    APIV1001_601
    8             400                                    APIV1001_602
    9             400                                    APIV1001_603

Full Payment in case validate parameter body Mandatory / Optional condition Invalid
    [Setup]       Run Keywords                             Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                                      Set Test Variable    ${SHEET_NAME}    ${SHEET_Validate_Void}
    [Teardown]    Close Browser
    [Template]    API_Validation_Parameter_Void_Invalid
   #rowNo        statusCode                          testcaseNo
    10            400                                      APIV1001_800
    11            400                                      APIV1001_801
    12            400                                      APIV1001_802
    13            400                                      APIV1001_803