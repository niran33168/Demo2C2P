*** Settings ***
Resource    ../AllKeywords.txt

*** Keywords ***
API_Validation_Quickpay
    [Arguments]                   ${rowNo}                                 ${statusCode}    ${testcaseName}    ${card_type}
    Generate_File_Path_Request    ${JSON_QuickPay}
    ${data_test}                  Read_Excel_For_Test                      ${EXCEL_NAME}    ${SHEET_NAME}      ${rowNo}
    ${request}                    Prepare_Data_For_API_Payment_Quickpay    ${data_test}
    ${data}                       Post_Validation_Quickpay                 ${request}       ${statusCode}      ${card_type}    ${rowNo}

Post_Validation_Quickpay
    [Arguments]                             ${request}                                                                                           ${statusCode}                                                                                        ${card_type}                     ${rowNo}
    Generate_Token
    Create Session                          quickpay                                                                                             ${HOST_NAME}                                                                                         verify=${True}
    ${HEADER_PAYMENT}=                      create dictionary                                                                                    Authorization=${token}                                                                               Content-Type=application/json    sourceTransID=${sourceTransID}      clientId=${clientId['${ENV}']}      clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    Log                                     ${request}
    ${response}=                            POST On Session                                                                                      quickpay                                                                                             ${API_QUICKPAY['${ENV}']}        data=${request}                     headers=${HEADER_PAYMENT}           expected_status=${statusCode}
    Log many                                ${response.text}
    ${json}                                 Convert String To JSON                                                                               ${response.text}
    ${request_json}                         Convert String To JSON                                                                               ${request}
    Log many                                ${request_json} 
    Should Be Equal As Strings              ${statusCode}                                                                                        ${response.status_code}
    Run Keyword If                          ${rowNo}!=16 and ${rowNo}!=63 and ${rowNo}!=64 and ${rowNo}!=65 and ${rowNo}!=66 and ${rowNo}!=67    verifyRespone                                                                                        ${json}                          ${request_json}                     ELSE                                Log                                       Fail                          
    Set Test Variable                       ${actual}                                                                                            ${response.text}
    ${status} =                             Run Keyword And Return Status                                                                        Should Be Equal As Strings                                                                           ${statusCode}                    ${response.status_code}
    Write_Result_Status_To_Excel_Payment    ${EXCEL_NAME}                                                                                        ${SHEET_NAME}                                                                                        ${rowNo}                         ${status}
    Run Keyword If                          ${status}==False                                                                                     Log                                                                                                  Fail
    ...                                     ELSE IF                                                                                              ${status}==True                                                                                      Log                              ${actual}
    Run Keyword If                          ${rowNo}!=16 and ${rowNo}!=63 and ${rowNo}!=64 and ${rowNo}!=65 and ${rowNo}!=66 and ${rowNo}!=67    Web_Payment_Quickpay                                                                                 ${json['url']}                   ${card_type}                        ${request_json['orderIdPrefix']}
    Run Keyword If                          ${rowNo}!=16 and ${rowNo}!=63 and ${rowNo}!=64 and ${rowNo}!=65 and ${rowNo}!=66 and ${rowNo}!=67    Open Web Mail
    ${CARD_NO}                              Run Keyword If                                                                                       ${rowNo}!=16 and ${rowNo}!=63 and ${rowNo}!=64 and ${rowNo}!=65 and ${rowNo}!=66 and ${rowNo}!=67    Open WebPayment Log              ${request_json['orderIdPrefix']}    ${rowNo}

verifyRespone
    [Arguments]                   ${json}                             ${request_json}
    Should Be Equal As Strings    Success                             ${json['resDesc']}
    Should Be Equal As Strings    ${request_json['version']}          ${json['version']}
    Should Be Equal As Strings    ${request_json['orderIdPrefix']}    ${json['orderIdPrefix']}
    Should Be Equal As Strings    ${request_json['currency']}         ${json['currency']}
    Should Be Equal As Strings    ${request_json['amount']}           ${json['amount']}
    Should Be Equal As Strings    ${request_json['expiry']}           ${json['expiry']}

API_Validation_Quickpay_QR
    [Arguments]                   ${rowNo}                                 ${statusCode}    ${testcaseName}    ${card_type}
    Generate_File_Path_Request    ${JSON_QuickPay}
    ${data_test}                  Read_Excel_For_Test                      ${EXCEL_NAME}    ${SHEET_NAME}      ${rowNo}
    ${request}                    Prepare_Data_For_API_Payment_Quickpay    ${data_test}
    ${data}                       Post_Validation_Quickpay_QR              ${request}       ${statusCode}      ${card_type}    ${rowNo}

Post_Validation_Quickpay_QR
    [Arguments]                             ${request}                          ${statusCode}                 ${card_type}                        ${rowNo}
    Generate_Token
    Create Session                          quickpay                            ${HOST_NAME}                  verify=${True}
    ${HEADER_PAYMENT}=                      create dictionary                   Authorization=${token}        Content-Type=application/json       sourceTransID=${sourceTransID}    clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    Log                                     ${request}
    ${response}=                            POST On Session                     quickpay                      ${API_QUICKPAY['${ENV}']}           data=${request}                   headers=${HEADER_PAYMENT}         expected_status=${statusCode}
    Log many                                ${response.text}
    ${json}                                 Convert String To JSON              ${response.text}
    ${request_json}                         Convert String To JSON              ${request}
    Log many                                ${request_json} 
    Should Be Equal As Strings              ${statusCode}                       ${response.status_code}
    Should Be Equal As Strings              Success                             ${json['resDesc']}
    Should Be Equal As Strings              ${request_json['version']}          ${json['version']}
    Should Be Equal As Strings              ${request_json['orderIdPrefix']}    ${json['orderIdPrefix']}
    Should Be Equal As Strings              ${request_json['currency']}         ${json['currency']}
    Should Be Equal As Strings              ${request_json['amount']}           ${json['amount']}
    Should Be Equal As Strings              ${request_json['expiry']}           ${json['expiry']}
    Set Test Variable                       ${actual}                           ${response.text}
    ${status} =                             Run Keyword And Return Status       Should Be Equal As Strings    ${statusCode}                       ${response.status_code}
    Write_Result_Status_To_Excel_Payment    ${EXCEL_NAME}                       ${SHEET_NAME}                 ${rowNo}                            ${status}
    Run Keyword If                          ${status}==False                    Log                           Fail
    ...                                     ELSE IF                             ${status}==True               Log                                 ${actual}
    ${request_json}                         Convert String To JSON              ${request}
    Web_Payment_QR_Quickpay                 ${json['url']}                      ${card_type}                  ${request_json['orderIdPrefix']}

API_Validation_Parameter_Quickpay_Missing
    [Arguments]                   ${rowNo}                                 ${statusCode}    ${testcaseName}
    Generate_File_Path_Request    ${JSON_Varidate}
    ${data_test}                  Read_Excel_For_Test                      ${EXCEL_NAME}    ${SHEET_NAME}      ${rowNo}
    ${request}                    Prepare_Data_For_API_Payment_Quickpay    ${data_test}
    ${data}                       Post_Validation_Quickpay_Missing         ${request}       ${statusCode}      ${rowNo}

Post_Validation_Quickpay_Missing
    [Arguments]                              ${request}                       ${statusCode}                 ${rowNo}
    Generate_Token
    Create Session                           quickpay                         ${HOST_NAME}                  verify=${True}
    ${HEADER_PAYMENT}=                       create dictionary                Authorization=${token}        Content-Type=application/json    sourceTransID=${sourceTransID}      clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    Log                                      ${request}
    ${response}=                             POST On Session                  quickpay                      ${API_QUICKPAY['${ENV}']}        data=${request}                     headers=${HEADER_PAYMENT}         expected_status=${statusCode}
    Log many                                 ${response.text}
    ${json}                                  Convert String To JSON           ${response.text}
    Run Keyword If                           ${rowNo}==26 and ${rowNo}==27    Should Be Equal As Strings    ${Error_2_MS_101}                ${json['integrationStatusCode']}
    Set Test Variable                        ${actual}                        ${response.text}
    ${status} =                              Run Keyword And Return Status    Should Be Equal As Strings    ${statusCode}                    ${response.status_code}
    Write_Result_Status_To_Excel_Quickpay    ${EXCEL_NAME}                    ${SHEET_NAME}                 ${rowNo}                         ${status}
    Run Keyword If                           ${status}==False                 Log                           Fail
    ...                                      ELSE IF                          ${status}==True               Log                              ${actual}

API_Validation_Parameter_Quickpay_Empty
    [Arguments]                   ${rowNo}                                 ${statusCode}    ${testcaseName}
    Generate_File_Path_Request    ${JSON_Varidate}
    ${data_test}                  Read_Excel_For_Test                      ${EXCEL_NAME}    ${SHEET_NAME}      ${rowNo}
    ${request}                    Prepare_Data_For_API_Payment_Quickpay    ${data_test}
    ${data}                       Post_Validation_Quickpay_Empty           ${request}       ${statusCode}      ${rowNo}

Post_Validation_Quickpay_Empty
    [Arguments]                              ${request}                       ${statusCode}                 ${rowNo}
    Generate_Token
    Create Session                           quickpay                         ${HOST_NAME}                  verify=${True}
    ${HEADER_PAYMENT}=                       create dictionary                Authorization=${token}        Content-Type=application/json    sourceTransID=${sourceTransID}    clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}          languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    Log                                      ${request}
    ${response}=                             POST On Session                  quickpay                      ${API_QUICKPAY['${ENV}']}        data=${request}                   headers=${HEADER_PAYMENT}         expected_status=${statusCode}
    Log many                                 ${response.text}
    ${json}                                  Convert String To JSON           ${response.text}
    Run Keyword If                           ${rowNo}==36 or ${rowNo}==37     Log                           True                             ELSE                              Should Be Equal As Strings        ${Error_2_MS_101}                         ${json['integrationStatusCode']}
    Set Test Variable                        ${actual}                        ${response.text}
    ${status} =                              Run Keyword And Return Status    Should Be Equal As Strings    ${statusCode}                    ${response.status_code}
    Write_Result_Status_To_Excel_Quickpay    ${EXCEL_NAME}                    ${SHEET_NAME}                 ${rowNo}                         ${status}
    Run Keyword If                           ${status}==False                 Log                           Fail
    ...                                      ELSE IF                          ${status}==True               Log                              ${actual}

API_Validation_Parameter_Quickpay_Invalid
    [Arguments]                   ${rowNo}                                 ${statusCode}    ${testcaseName}
    Generate_File_Path_Request    ${JSON_Varidate}
    ${data_test}                  Read_Excel_For_Test                      ${EXCEL_NAME}    ${SHEET_NAME}      ${rowNo}
    ${request}                    Prepare_Data_For_API_Payment_Quickpay    ${data_test}
    ${data}                       Post_Validation_Quickpay_Invalid         ${request}       ${statusCode}      ${rowNo}

Post_Validation_Quickpay_Invalid
    [Arguments]                              ${request}                       ${statusCode}                 ${rowNo}
    Generate_Token
    Create Session                           quickpay                         ${HOST_NAME}                  verify=${True}
    ${HEADER_PAYMENT}=                       create dictionary                Authorization=${token}        Content-Type=application/json    sourceTransID=${sourceTransID}    clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    Log                                      ${request}
    ${response}=                             POST On Session                  quickpay                      ${API_QUICKPAY['${ENV}']}        data=${request}                   headers=${HEADER_PAYMENT}         expected_status=${statusCode}
    Log many                                 ${response.text}
    ${json}                                  Convert String To JSON           ${response.text}
    # Should Be Equal As Strings              ${Error_2_MS_101}                ${json['integrationStatusCode']}
    Set Test Variable                        ${actual}                        ${response.text}
    ${status} =                              Run Keyword And Return Status    Should Be Equal As Strings    ${statusCode}                    ${response.status_code}
    Write_Result_Status_To_Excel_Quickpay    ${EXCEL_NAME}                    ${SHEET_NAME}                 ${rowNo}                         ${status}
    Run Keyword If                           ${status}==False                 Log                           Fail
    ...                                      ELSE IF                          ${status}==True               Log                              ${actual}
