*** Settings ***
Resource    ../TestResource/Keywords/AllKeywords.txt

*** Test Cases ***
Payment Redirect Main flow status approve Credit
    [Setup]       Run Keywords              Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                       Set Test Variable    ${SHEET_NAME}    ${SHEET_Redirect}
    [Teardown]    Close Browser
    [Template]    API_Validation_Payment
   #rowNo        statusCode                testcaseNo           cardtype
    2             200                       RDR1001_001          visa
    3             200                       RDR1001_002          mastercard
    4             200                       RDR1001_003          JCB
    5             200                       RDR1001_004          unionpay
    12            200                       RDR1001_011          visa

Payment Redirect Main flow status approve QR
    [Setup]       Run Keywords                 Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                          Set Test Variable    ${SHEET_NAME}    ${SHEET_Redirect}
    [Teardown]    Close Browser
    [Template]    API_Validation_Payment_QR
   #rowNo        statusCode                   testcaseNo           cardtype
    6             200                          RDR1001_005          shopee
    7             200                          RDR1001_006          visa
    8             200                          RDR1001_007          upi
    9             200                          RDR1001_008          mastercard
    10            200                          RDR1001_009          promptpay
    11            200                          RDR1001_010          grabpay
    13            200                          RDR1001_012          mastercard

Payment Redirect Main flow status void
    [Setup]       Run Keywords                   Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                            Set Test Variable    ${SHEET_NAME}    ${SHEET_Redirect}
    [Teardown]    Close Browser
    [Template]    API_Validation_Payment_Void
   #rowNo        statusCode                     testcaseNo           cardtype
    14            200                            RDR1002_001          visa
    15            200                            RDR1002_002          mastercard
    16            200                            RDR1002_003          JCB
    17            200                            RDR1002_004          unionpay

Redirect in case error from Handling error
    [Setup]       Run Keywords          Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                   Set Test Variable    ${SHEET_NAME}    ${SHEET_Redirect}
    [Teardown]    Close Browser
    [Template]    API_Handling_Error
   #rowNo        statusCode            testcaseNo
    18            404                   RDR1003_200 
    19            400                   RDR1003_201

validations in case error from Business Case
    [Setup]       Run Keywords          Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                   Set Test Variable    ${SHEET_NAME}    ${SHEET_Redirect}
    [Teardown]    Close Browser
    [Template]    API_Handling_Error
   #rowNo        statusCode                     testcaseNo
    20            400                   RDR1004_300 
