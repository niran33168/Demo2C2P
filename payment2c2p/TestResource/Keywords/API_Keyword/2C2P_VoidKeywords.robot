*** Settings ***
Resource    ../AllKeywords.txt

*** Keywords ***
API_Validation_Payment_Void
    [Arguments]                   ${rowNo}                                 ${statusCode}    ${testcaseName}    ${card_type}
    Generate_File_Path_Request    ${JSON_REDIRECT}
    ${data_test}                  Read_Excel_For_Test                      ${EXCEL_NAME}    ${SHEET_NAME}      ${rowNo}
    ${request}                    Prepare_Data_For_API_Payment_Redirect    ${data_test}
    ${data}                       Post_Validation_Void                     ${request}       ${statusCode}      ${rowNo}

Post_Validation_Void
    [Arguments]                             ${request}                        ${statusCode}                 ${rowNo}
    Generate_Token
    Create Session                          void                              ${HOST_NAME}                  verify=${True}
    ${HEADER_VOID}=                         create dictionary                 Authorization=${token}        Content-Type=application/json    sourceTransID=${sourceTransID}    clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    ${response}=                            POST On Session                   void                          ${API_VOID['${ENV}']}            data=${request}                   headers=${HEADER_VOID}            expected_status=${statusCode}
    Log many                                ${response.text}
    ${request_json}                         Convert String To JSON            ${request}
    Log many                                ${request_json} 
    ${json}                                 Convert String To JSON            ${response.text}
    Log many                                ${json}
    Should Be Equal As Strings              ${statusCode}                     ${response.status_code}
    Should Be Equal As Strings              00                                ${json['respCode']}
    Should Be Equal As Strings              Success                           ${json['respDesc']}
    Should Be Equal As Strings              ${request_json['version']}        ${json['version']}
    Should Be Equal As Strings              ${request_json['processType']}    ${json['processType']}
    Set Test Variable                       ${actual}                         ${response.text}
    ${status} =                             Run Keyword And Return Status     Should Be Equal As Strings    ${statusCode}                    ${response.status_code}
    Write_Result_Status_To_Excel_Payment    ${EXCEL_NAME}                     ${SHEET_NAME}                 ${rowNo}                         ${status}
    Run Keyword If                          ${status}==False                  Log                           Fail
    ...                                     ELSE IF                           ${status}==True               Log                              ${actual}
    Open WebPayment Log                     ${request_json['invoiceNo']}      ${rowNo}