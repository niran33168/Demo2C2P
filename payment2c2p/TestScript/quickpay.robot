*** Settings ***
Resource    ../TestResource/Keywords/AllKeywords.txt

*** Test Cases ***
Quick Pay Main flow Credit Card
    [Setup]       Run Keywords               Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                        Set Test Variable    ${SHEET_NAME}    ${SHEET_Quickpay}
    [Teardown]    Close Browser
    [Template]    API_Validation_Quickpay
   #rowNo        statusCode                 testcaseNo           cardtype
    2             200                        QP1001_001           visa
    3             200                        QP1001_002           mastercard
    4             200                        QP1001_003           JCB
    5             200                        QP1001_004           unionpay
    63            200                        QP1001_011           visa
    64            200                        QP1001_012           visa
    65            200                        QP1001_013           Installment
    66            200                        QP1001_014           Installment

Quick Pay Main flow QR
    [Setup]       Run Keywords                  Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                           Set Test Variable    ${SHEET_NAME}    ${SHEET_Quickpay}
    [Teardown]    Close Browser
    [Template]    API_Validation_Quickpay_QR
   #rowNo        statusCode                    testcaseNo           cardtype
    6             200                           QP1001_005           shopee
    7             200                           QP1001_006           visa
    8             200                           QP1001_007           upi
    9             200                           QP1001_008           mastercard
    10            200                           QP1001_009           promptpay
    11            200                           QP1001_010           grabpay

Quick Pay in case error from Handling error
    [Setup]       Run Keywords                   Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                            Set Test Variable    ${SHEET_NAME}    ${SHEET_Quickpay}
    [Teardown]    Close Browser
    [Template]    API_Handling_Error_Quickpay
   #rowNo        statusCode                     testcaseNo
    13            404                            QP1002_200 
    14            400                            QP1002_201

validations in case error from Business Case
    [Setup]       Run Keywords               Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                        Set Test Variable    ${SHEET_NAME}    ${SHEET_Quickpay}
    [Teardown]    Close Browser
    [Template]    API_Validation_Quickpay
   #rowNo        statusCode                 testcaseNo           cardtype
    16            200                        QP1003_300           visa

Quick Pay in case validate parameter body Mandatory / Optional condition Missing
    [Setup]       Run Keywords                                 Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                                          Set Test Variable    ${SHEET_NAME}    ${SHEET_Quickpay}
    [Teardown]    Close Browser
    [Template]    API_Validation_Parameter_Quickpay_Missing
   #rowNo        statusCode                                   testcaseNo
    18            400                                          QP1004_400 
    19            400                                          QP1004_401
    20            400                                          QP1004_402
    21            400                                          QP1004_403
    22            400                                          QP1004_404
    23            400                                          QP1004_405
    24            400                                          QP1004_406
    25            400                                          QP1004_407
    26            200                                          QP1004_408
    27            200                                          QP1004_409

Quick Pay in case validate parameter body Mandatory / Optional condition Empty
    [Setup]       Run Keywords                               Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                                        Set Test Variable    ${SHEET_NAME}    ${SHEET_Quickpay}
    [Teardown]    Close Browser
    [Template]    API_Validation_Parameter_Quickpay_Empty
   #rowNo        statusCode                                 testcaseNo
    28            400                                        QP1004_600
    29            400                                        QP1004_601
    30            400                                        QP1004_602
    31            400                                        QP1004_603
    32            400                                        QP1004_604
    33            400                                        QP1004_605
    34            400                                        QP1004_606
    35            400                                        QP1004_607
    36            200                                        QP1004_608
    37            200                                        QP1004_609

Quick Pay in case validate parameter body Mandatory / Optional condition Invalid
    [Setup]       Run Keywords                                 Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                                          Set Test Variable    ${SHEET_NAME}    ${SHEET_Quickpay}
    [Teardown]    Close Browser
    [Template]    API_Validation_Parameter_Quickpay_Invalid
   #rowNo        statusCode                                   testcaseNo
    38            200                                          QP1004_800 
    39            200                                          QP1004_801
    40            200                                          QP1004_802
    41            200                                          QP1004_803
    42            200                                          QP1004_804
    43            200                                          QP1004_805
    44            200                                          QP1004_806
    45            200                                          QP1004_807
    46            200                                          QP1004_808
    47            200                                          QP1004_809
    48            200                                          QP1004_810
    49            200                                          QP1004_811
    50            200                                          QP1004_812
    51            200                                          QP1004_813
    52            200                                          QP1004_814

Quick Pay in case validate parameter body Optional Invalid
    [Setup]       Run Keywords                                 Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                                          Set Test Variable    ${SHEET_NAME}    ${SHEET_Quickpay}
    [Teardown]    Close Browser
    [Template]    API_Validation_Parameter_Quickpay_Invalid
   #rowNo        statusCode                                   testcaseNo
    53            200                                          QP1005_800 
    54            200                                          QP1005_801
    55            400                                          QP1005_802
    56            200                                          QP1005_803
    57            200                                          QP1005_804
    58            400                                          QP1005_805
    59            200                                          QP1005_806
    60            200                                          QP1005_807
    61            400                                          QP1005_808
    62            400                                          QP1005_809