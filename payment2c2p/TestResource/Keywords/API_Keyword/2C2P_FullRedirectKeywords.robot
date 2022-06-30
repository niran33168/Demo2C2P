*** Settings ***
Resource    ../AllKeywords.txt

*** Keywords ***
API_Validation_Payment
    [Arguments]                   ${rowNo}                                 ${statusCode}    ${testcaseName}    ${card_type}
    Generate_File_Path_Request    ${JSON_REDIRECT}
    ${data_test}                  Read_Excel_For_Test                      ${EXCEL_NAME}    ${SHEET_NAME}      ${rowNo}
    ${request}                    Prepare_Data_For_API_Payment_Redirect    ${data_test}
    ${data}                       Post_Validation_Payment                  ${request}       ${statusCode}      ${card_type}    ${rowNo}
    ${data}                       Post_Validation_Inquiry                  ${request}       ${statusCode}      ${card_type}    ${rowNo}
    Verify_Message_Log_Kafka

Post_Validation_Payment
    [Arguments]                             ${request}                       ${statusCode}                                   ${card_type}                                    ${rowNo}
    Generate_Token
    Create Session                          payment                          ${HOST_NAME}                                    verify=${True}
    ${HEADER_PAYMENT}=                      create dictionary                Authorization=${token}                          Content-Type=application/json                   sourceTransID=${sourceTransID}    clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    Log                                     ${request}
    ${response}=                            POST On Session                  payment                                         ${API_PAYMENT_REDIRECT['${ENV}']}               data=${request}                   headers=${HEADER_PAYMENT}         expected_status=${statusCode}
    Log many                                ${response.text}
    ${json}                                 Convert String To JSON           ${response.text}
    Should Be Equal As Strings              ${statusCode}                    ${response.status_code}
    Should Be Equal As Strings              Success                          ${json['respDesc']}
    Should Be Equal As Strings              0000                             ${json['respCode']}
    Set Test Variable                       ${actual}                        ${response.text}
    ${status} =                             Run Keyword And Return Status    Should Be Equal As Strings                      ${statusCode}                                   ${response.status_code}
    Write_Result_Status_To_Excel_Payment    ${EXCEL_NAME}                    ${SHEET_NAME}                                   ${rowNo}                                        ${status}
    Run Keyword If                          ${status}==False                 Log                                             Fail
    ...                                     ELSE IF                          ${status}==True                                 Log                                             ${actual}
    ${request_json}                         Convert String To JSON           ${request}
    Web_Payment                             ${json['webPaymentUrl']}         ${card_type}                                    ${request_json['paymentToken']['invoiceNo']}
    Open Web Mail
    ${CARD_NO}                              Open WebPayment Log              ${request_json['paymentToken']['invoiceNo']}    ${rowNo}

API_Validation_Payment_Recurring
    [Arguments]                   ${rowNo}                                  ${statusCode}    ${testcaseName}    ${card_type}
    Generate_File_Path_Request    ${JSON_REDIRECTRECURRING}
    ${data_test}                  Read_Excel_For_Test                       ${EXCEL_NAME}    ${SHEET_NAME}      ${rowNo}
    ${request}                    Prepare_Data_For_API_Payment_Recurring    ${data_test}
    ${data}                       Post_Validation_Payment_Recurring         ${request}       ${statusCode}      ${card_type}    ${rowNo}

Post_Validation_Payment_Recurring
    [Arguments]                             ${request}                       ${statusCode}                 ${card_type}                         ${rowNo}
    Generate_Token
    Create Session                          payment                          ${HOST_NAME}                  verify=${True}
    ${HEADER_PAYMENT}=                      create dictionary                Authorization=${token}        Content-Type=application/json        sourceTransID=${sourceTransID}    clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    Log                                     ${request}
    ${response}=                            POST On Session                  payment                       ${API_PAYMENT_REDIRECT['${ENV}']}    data=${request}                   headers=${HEADER_PAYMENT}         expected_status=${statusCode}
    Log many                                ${response.text}
    ${json}                                 Convert String To JSON           ${response.text}
    Should Be Equal As Strings              ${statusCode}                    ${response.status_code}
    Should Be Equal As Strings              Success                          ${json['respDesc']}
    Should Be Equal As Strings              0000                             ${json['respCode']}
    Set Test Variable                       ${actual}                        ${response.text}
    ${status} =                             Run Keyword And Return Status    Should Be Equal As Strings    ${statusCode}                        ${response.status_code}
    Write_Result_Status_To_Excel_Payment    ${EXCEL_NAME}                    ${SHEET_NAME}                 ${rowNo}                             ${status}
    Run Keyword If                          ${status}==False                 Log                           Fail
    ...                                     ELSE IF                          ${status}==True               Log                                  ${actual}
    ${request_json}                         Convert String To JSON           ${request}

API_Validation_Payment_Installment
    [Arguments]                   ${rowNo}                                    ${statusCode}    ${testcaseName}    ${card_type}
    Generate_File_Path_Request    ${JSON_REDIRECTINSTALLMENT}
    ${data_test}                  Read_Excel_For_Test                         ${EXCEL_NAME}    ${SHEET_NAME}      ${rowNo}
    ${request}                    Prepare_Data_For_API_Payment_Installment    ${data_test}
    ${data}                       Post_Validation_Payment_Installment         ${request}       ${statusCode}      ${card_type}    ${rowNo}

Post_Validation_Payment_Installment
    [Arguments]                             ${request}                       ${statusCode}                 ${card_type}                                    ${rowNo}
    Generate_Token
    Create Session                          payment                          ${HOST_NAME}                  verify=${True}
    ${HEADER_PAYMENT}=                      create dictionary                Authorization=${token}        Content-Type=application/json                   sourceTransID=${sourceTransID}    clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    Log                                     ${request}
    ${response}=                            POST On Session                  payment                       ${API_PAYMENT_REDIRECT['${ENV}']}               data=${request}                   headers=${HEADER_PAYMENT}         expected_status=${statusCode}
    Log many                                ${response.text}
    ${json}                                 Convert String To JSON           ${response.text}
    Should Be Equal As Strings              ${statusCode}                    ${response.status_code}
    Should Be Equal As Strings              Success                          ${json['respDesc']}
    Should Be Equal As Strings              0000                             ${json['respCode']}
    Set Test Variable                       ${actual}                        ${response.text}
    ${status} =                             Run Keyword And Return Status    Should Be Equal As Strings    ${statusCode}                                   ${response.status_code}
    Write_Result_Status_To_Excel_Payment    ${EXCEL_NAME}                    ${SHEET_NAME}                 ${rowNo}                                        ${status}
    Run Keyword If                          ${status}==False                 Log                           Fail
    ...                                     ELSE IF                          ${status}==True               Log                                             ${actual}
    ${request_json}                         Convert String To JSON           ${request}
    Web_Payment_Installment                 ${json['webPaymentUrl']}         ${card_type}                  ${request_json['paymentToken']['invoiceNo']}

Web_Payment_Installment
    [Arguments]                         ${URL}    ${card_type}    ${invoice}
    Open WebPayment 2C2P Installment    ${URL}    ${card_type}    ${invoice}    

Web_Payment
    [Arguments]             ${URL}    ${card_type}    ${invoice}
    Open WebPayment 2C2P    ${URL}    ${card_type}    ${invoice}

Web_Payment_Quickpay
    [Arguments]                      ${URL}    ${card_type}    ${invoice}
    Open WebPayment 2C2P Quickpay    ${URL}    ${card_type}    ${invoice}

Web_MAIL
    Open Web Mail

Web_Check_Log
    Open WebPayment Log

API_Validation_Payment_QR
    [Arguments]                   ${rowNo}                                 ${statusCode}    ${testcaseName}    ${card_type}
    Generate_File_Path_Request    ${JSON_REDIRECT}
    ${data_test}                  Read_Excel_For_Test                      ${EXCEL_NAME}    ${SHEET_NAME}      ${rowNo}
    ${request}                    Prepare_Data_For_API_Payment_Redirect    ${data_test}
    ${data}                       Post_Validation_Payment_QR               ${request}       ${statusCode}      ${card_type}    ${rowNo}

Post_Validation_Payment_QR
    [Arguments]                             ${request}                       ${statusCode}                 ${card_type}                                    ${rowNo}
    Generate_Token
    Create Session                          payment                          ${HOST_NAME}                  verify=${True}
    ${HEADER_PAYMENT}=                      create dictionary                Authorization=${token}        Content-Type=application/json                   sourceTransID=${sourceTransID}    clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    Log                                     ${request}
    ${response}=                            POST On Session                  payment                       ${API_PAYMENT_REDIRECT['${ENV}']}               data=${request}                   headers=${HEADER_PAYMENT}         expected_status=${statusCode}
    Log many                                ${response.text}
    ${json}                                 Convert String To JSON           ${response.text}
    Should Be Equal As Strings              ${statusCode}                    ${response.status_code}
    Should Be Equal As Strings              Success                          ${json['respDesc']}
    Should Be Equal As Strings              0000                             ${json['respCode']}
    Set Test Variable                       ${actual}                        ${response.text}
    ${status} =                             Run Keyword And Return Status    Should Be Equal As Strings    ${statusCode}                                   ${response.status_code}
    Write_Result_Status_To_Excel_Payment    ${EXCEL_NAME}                    ${SHEET_NAME}                 ${rowNo}                                        ${status}
    Run Keyword If                          ${status}==False                 Log                           Fail
    ...                                     ELSE IF                          ${status}==True               Log                                             ${actual}
    ${request_json}                         Convert String To JSON           ${request}
    Web_Payment_QR                          ${json['webPaymentUrl']}         ${card_type}                  ${request_json['paymentToken']['invoiceNo']}

Web_Payment_QR
    [Arguments]                ${URL}    ${card_type}    ${invoice}
    Open WebPayment 2C2P QR    ${URL}    ${card_type}    ${invoice}

Web_Payment_QR_Quickpay
    [Arguments]                         ${URL}    ${card_type}    ${invoice}
    Open WebPayment 2C2P Quickpay QR    ${URL}    ${card_type}    ${invoice}

Verify_Message_Log_Kafka
    Open Web kafdropdev
