*** Settings ***
Resource    ../AllKeywords.txt

*** Keywords ***
API_Validation_Payment_Direct
    [Arguments]                   ${rowNo}                               ${statusCode}    ${testcaseName}
    Generate_File_Path_Request    ${JSON_DIRECT}
    ${data_test}                  Read_Excel_For_Test                    ${EXCEL_NAME}    ${SHEET_NAME}      ${rowNo}
    ${request}                    Prepare_Data_For_API_Payment_Direct    ${data_test}
    ${data}                       Post_Validation_Payment_Direct         ${request}       ${statusCode}      ${rowNo}

Post_Validation_Payment_Direct
    [Arguments]                             ${request}                                    ${statusCode}                 ${rowNo}
    Generate_Token
    Create Session                          payment                                       ${HOST_NAME}                  verify=${True}
    ${HEADER_PAYMENT}=                      create dictionary                             Authorization=${token}        Content-Type=application/json        sourceTransID=${sourceTransID}    clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}                      languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    Log                                     ${request}
    ${response}=                            POST On Session                               payment                       ${API_PAYMENT_REDIRECT['${ENV}']}    data=${request}                   headers=${HEADER_PAYMENT}         expected_status=${statusCode}
    Log many                                ${response.text}
    ${json}                                 Convert String To JSON                        ${response.text}
    Should Be Equal As Strings              ${statusCode}                                 ${response.status_code}
    Set Test Variable                       ${actual}                                     ${response.text}
    ${status} =                             Run Keyword And Return Status                 Should Be Equal As Strings    ${statusCode}                        ${response.status_code}
    Write_Result_Status_To_Excel_Payment    ${EXCEL_NAME}                                 ${SHEET_NAME}                 ${rowNo}                             ${status}
    Run Keyword If                          ${status}==False                              Log                           Fail
    ...                                     ELSE IF                                       ${status}==True               Log                                  ${actual}
    ${request_json}                         Convert String To JSON                        ${request}
   
Web_Payment_Direct
    [Arguments]                    ${URL}    ${invoice}
    Open WebPayment 2C2P Direct    ${URL}    ${invoice}