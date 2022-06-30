*** Settings ***
Resource    ../TestResource/Keywords/AllKeywords.txt

*** Test Cases ***
Card Tokenization Main flow
    [Setup]       Run Keywords                       Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                                Set Test Variable    ${SHEET_NAME}    ${SHEET_Validate_CardTokenization}
    [Teardown]    Close Browser
    [Template]    API_Validation_Cardtokenization
   #rowNo        statusCode                 testcaseNo
    2             200                                CT1001_001
    3             200                                CT1001_002
    4             200                                CT1001_003
    5             200                                CT1001_004
    6             200                                CT1001_005

Card Tokenization in case error from Handling error
    [Setup]       Run Keywords                           Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                                    Set Test Variable    ${SHEET_NAME}    ${SHEET_Validate_CardTokenization}
    [Teardown]    Close Browser
    [Template]    API_Handling_Error_Cardtokenization
   #rowNo        statusCode                 testcaseNo
    7             404                                    CT1002_200
    8             400                                    CT1002_201

Card Tokenization validations in case error from Business Case
    [Setup]       Run Keywords                                Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                                         Set Test Variable    ${SHEET_NAME}    ${SHEET_Validate_CardTokenization}
    [Teardown]    Close Browser
    [Template]    API_Validation_Cardtokenization_Business
     #rowNo        statusCode                 testcaseNo
    9             200                                         CT1003_300
    10            200                                         CT1003_301
    11            200                                         CT1003_302

Card Tokenization in case validate parameter body Mandatory / Optional condition Missing
    [Setup]       Run Keywords                                         Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                                                  Set Test Variable    ${SHEET_NAME}    ${SHEET_Validate_CardTokenization}
    [Teardown]    Close Browser
    [Template]    API_Validation_Parameter_Cardtokenization_Missing
   #rowNo        statusCode                 testcaseNo
    12            400                                                  CT1004_400
    13            400                                                  CT1004_401
    14            400                                                  CT1004_402
    15            400                                                  CT1004_403
    16            400                                                  CT1004_404
    17            400                                                  CT1004_405

Card Tokenization in case validate parameter body Mandatory / Optional condition Empty
    [Setup]       Run Keywords                                       Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                                                Set Test Variable    ${SHEET_NAME}    ${SHEET_Validate_CardTokenization}
    [Teardown]    Close Browser
    [Template]    API_Validation_Parameter_Cardtokenization_Empty
   #rowNo        statusCode                                         testcaseNo
    18            400                                                CT1004_600
    19            400                                                CT1004_601
    20            400                                                CT1004_602
    21            400                                                CT1004_603
    22            400                                                CT1004_604
    23            400                                                CT1004_605

Card Tokenization in case validate parameter body Mandatory / Optional condition Invalid
    [Setup]       Run Keywords                                         Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                                                  Set Test Variable    ${SHEET_NAME}    ${SHEET_Validate_CardTokenization}
    [Teardown]    Close Browser
    [Template]    API_Validation_Parameter_Cardtokenization_Invalid
   #rowNo        statusCode                                           testcaseNo
    24            200                                                  CT1004_800
    25            500                                                  CT1004_801
    26            400                                                  CT1004_802
    27            200                                                  CT1004_803
    28            400                                                  CT1004_804
    29            400                                                  CT1004_805

Card Tokenization in case validate parameter body Optional
    [Setup]       Run Keywords                                         Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                                                  Set Test Variable    ${SHEET_NAME}    ${SHEET_Validate_CardTokenization}
    [Teardown]    Close Browser
    [Template]    API_Validation_Parameter_Cardtokenization_Invalid
   #rowNo        statusCode                                           testcaseNo
    30            400                                                  CT1005_800
    31            400                                                  CT1005_801
    32            400                                                  CT1005_802
    33            200                                                  CT1005_803
    34            400                                                  CT1005_804

Card Tokenization Main flow Direct
    [Setup]       Run Keywords                              Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                                       Set Test Variable    ${SHEET_NAME}    ${SHEET_Validate_CardTokenization}
    [Teardown]    Close Browser
    [Template]    API_Validation_Cardtokenization_Direct
   #rowNo        statusCode                                testcaseNo
    35            200                                       CT1006_001
    36            200                                       CT1006_002
    37            200                                       CT1006_003
    38            200                                       CT1006_004
    39            200                                       CT1006_005