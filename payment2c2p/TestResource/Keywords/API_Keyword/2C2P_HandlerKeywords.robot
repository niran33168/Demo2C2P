*** Settings ***
Resource    ../AllKeywords.txt

*** Keywords ***
API_Handling_Error
    [Arguments]                   ${rowNo}                                 ${statusCode}    ${testcaseName}
    Generate_File_Path_Request    ${JSON_REDIRECT}
    ${data_test}                  Read_Excel_For_Test                      ${EXCEL_NAME}    ${SHEET_NAME}      ${rowNo}
    ${request}                    Prepare_Data_For_API_Payment_Redirect    ${data_test}
    ${data}                       Post_Handling_Error                      ${request}       ${statusCode}      ${rowNo}

Post_Handling_Error
    [Arguments]       ${request}            ${statusCode}    ${rowNo}
    Generate_Token
    Create Session    handling              ${HOST_NAME}     verify=${True}
    Run Keyword If    ${statusCode}==404    Url_Worng        ${request}        ${statusCode}    ${rowNo}    ELSE    Json_Worng    ${request}    ${statusCode}    ${rowNo}    

Url_Worng
    [Arguments]                              ${request}                       ${statusCode}                 ${rowNo}
    ${HEADER_PAYMENT}=                       create dictionary                Authorization=${token}        Content-Type=application/json    sourceTransID=${sourceTransID}    clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    Log                                      ${request}
    ${response}=                             POST On Session                  handling                      ${API_Handling['${ENV}']}        data=${request}                   headers=${HEADER_PAYMENT}         expected_status=${statusCode}
    Log many                                 ${response.text}
    ${json}                                  Convert String To JSON           ${response.text}
    Should Be Equal As Strings               ${statusCode}                    ${response.status_code}
    Set Test Variable                        ${actual}                        ${response.text}
    ${status} =                              Run Keyword And Return Status    Should Be Equal As Strings    ${statusCode}                    ${response.status_code}
    Write_Result_Status_To_Excel_Handling    ${EXCEL_NAME}                    ${SHEET_NAME}                 ${rowNo}                         ${status}                         ${response.status_code}
    Run Keyword If                           ${status}==False                 Log                           Fail
    ...                                      ELSE IF                          ${status}==True               Log                              ${actual}

Json_Worng
    [Arguments]                              ${request}                       ${statusCode}                 ${rowNo}
    ${request}                               Run Keyword If                   ${rowNo}==19                  Convert JSON To String               ${request}                        ELSE                              Set Variable                              ${request}	
    ${HEADER_PAYMENT}=                       create dictionary                Authorization=${token}        Content-Type=application/json        sourceTransID=${sourceTransID}    clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    Log                                      ${request}
    ${response}=                             POST On Session                  handling                      ${API_PAYMENT_REDIRECT['${ENV}']}    data=${request}                   headers=${HEADER_PAYMENT}         expected_status=${statusCode}
    Log many                                 ${response.text}
    ${json}                                  Convert String To JSON           ${response.text}
    Should Be Equal As Strings               ${statusCode}                    ${response.status_code}
    Set Test Variable                        ${actual}                        ${response.text}
    ${status} =                              Run Keyword And Return Status    Should Be Equal As Strings    ${statusCode}                        ${response.status_code}
    Write_Result_Status_To_Excel_Handling    ${EXCEL_NAME}                    ${SHEET_NAME}                 ${rowNo}                             ${status}                         ${response.status_code}
    Run Keyword If                           ${status}==False                 Log                           Fail
    ...                                      ELSE IF                          ${status}==True               Log                                  ${actual}

API_Handling_Error_Quickpay
    [Arguments]                   ${rowNo}                                 ${statusCode}    ${testcaseName}
    Generate_File_Path_Request    ${JSON_REDIRECT}
    ${data_test}                  Read_Excel_For_Test                      ${EXCEL_NAME}    ${SHEET_NAME}      ${rowNo}
    ${request}                    Prepare_Data_For_API_Payment_Quickpay    ${data_test}
    ${data}                       Post_Handling_Error_Quickpay             ${request}       ${statusCode}      ${rowNo}

Post_Handling_Error_Quickpay
    [Arguments]       ${request}            ${statusCode}         ${rowNo}
    Generate_Token
    Create Session    handling              ${HOST_NAME}          verify=${True}
    Run Keyword If    ${statusCode}==404    Url_Worng_Quickpay    ${request}        ${statusCode}    ${rowNo}    ELSE    Json_Worng_Quickpay    ${request}    ${statusCode}    ${rowNo}    

Url_Worng_Quickpay
    [Arguments]                             ${request}                       ${statusCode}                 ${rowNo}
    ${HEADER_PAYMENT}=                      create dictionary                Authorization=${token}        Content-Type=application/json         sourceTransID=${sourceTransID}    clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    Log                                     ${request}
    ${response}=                            POST On Session                  handling                      ${API_Handling_Quickpay['${ENV}']}    data=${request}                   headers=${HEADER_PAYMENT}         expected_status=${statusCode}
    Log many                                ${response.text}
    ${json}                                 Convert String To JSON           ${response.text}
    Should Be Equal As Strings              ${statusCode}                    ${response.status_code}
    Set Test Variable                       ${actual}                        ${response.text}
    ${status} =                             Run Keyword And Return Status    Should Be Equal As Strings    ${statusCode}                         ${response.status_code}
    Write_Result_Status_To_Excel_Payment    ${EXCEL_NAME}                    ${SHEET_NAME}                 ${rowNo}                              ${status}
    Run Keyword If                          ${status}==False                 Log                           Fail
    ...                                     ELSE IF                          ${status}==True               Log                                   ${actual}

Json_Worng_Quickpay
    [Arguments]                             ${request}                       ${statusCode}                 ${rowNo}
    ${request}                              Run Keyword If                   ${rowNo}==14                  Convert JSON To String           ${request}                        ELSE                              Set Variable                              ${request}	
    ${HEADER_PAYMENT}=                      create dictionary                Authorization=${token}        Content-Type=application/json    sourceTransID=${sourceTransID}    clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    Log                                     ${request}
    ${response}=                            POST On Session                  handling                      ${API_QUICKPAY['${ENV}']}        data=${request}                   headers=${HEADER_PAYMENT}         expected_status=${statusCode}
    Log many                                ${response.text}
    ${json}                                 Convert String To JSON           ${response.text}
    Should Be Equal As Strings              ${statusCode}                    ${response.status_code}
    Set Test Variable                       ${actual}                        ${response.text}
    ${status} =                             Run Keyword And Return Status    Should Be Equal As Strings    ${statusCode}                    ${response.status_code}
    Write_Result_Status_To_Excel_Payment    ${EXCEL_NAME}                    ${SHEET_NAME}                 ${rowNo}                         ${status}
    Run Keyword If                          ${status}==False                 Log                           Fail
    ...                                     ELSE IF                          ${status}==True               Log                              ${actual}

API_Handling_Error_Cardtokenization
    [Arguments]                   ${rowNo}                                         ${statusCode}    ${testcaseName}
    Generate_File_Path_Request    ${JSON_REDIRECT}
    ${data_test}                  Read_Excel_For_Test                              ${EXCEL_NAME}    ${SHEET_NAME}      ${rowNo}
    ${request}                    Prepare_Data_For_API_Payment_CardTokenization    ${data_test}
    ${data}                       Post_Handling_Error_Cardtokenization             ${request}       ${statusCode}      ${rowNo}

Post_Handling_Error_Cardtokenization
    [Arguments]       ${request}            ${statusCode}                 ${rowNo}
    Generate_Token
    Create Session    handling              ${HOST_NAME}                  verify=${True}
    Run Keyword If    ${statusCode}==404    Url_Worng_Cardtokenization    ${request}        ${statusCode}    ${rowNo}    ELSE    Json_Worng_Cardtokenization    ${request}    ${statusCode}    ${rowNo}    

Url_Worng_Cardtokenization
    [Arguments]                                      ${request}                       ${statusCode}                 ${rowNo}
    ${HEADER_PAYMENT}=                               create dictionary                Authorization=${token}        Content-Type=application/json                  sourceTransID=${sourceTransID}    clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    Log                                              ${request}
    ${response}=                                     POST On Session                  handling                      ${API_Handling_CardTokenizationy['${ENV}']}    data=${request}                   headers=${HEADER_PAYMENT}         expected_status=${statusCode}
    Log many                                         ${response.text}
    ${json}                                          Convert String To JSON           ${response.text}
    Should Be Equal As Strings                       ${statusCode}                    ${response.status_code}
    Set Test Variable                                ${actual}                        ${response.text}
    ${status} =                                      Run Keyword And Return Status    Should Be Equal As Strings    ${statusCode}                                  ${response.status_code}
    Write_Result_Status_To_Excel_CardTokenization    ${EXCEL_NAME}                    ${SHEET_NAME}                 ${rowNo}                                       ${status}                         ${response.status_code}
    Run Keyword If                                   ${status}==False                 Log                           Fail
    ...                                              ELSE IF                          ${status}==True               Log                                            ${actual}

Json_Worng_Cardtokenization
    [Arguments]                                      ${request}                       ${statusCode}                 ${rowNo}
    ${request}                                       Run Keyword If                   ${rowNo}==8                   Convert JSON To String               ${request}                        ELSE                              Set Variable                              ${request}	
    ${HEADER_PAYMENT}=                               create dictionary                Authorization=${token}        Content-Type=application/json        sourceTransID=${sourceTransID}    clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    Log                                              ${request}
    ${response}=                                     POST On Session                  handling                      ${API_CardTokenization['${ENV}']}    data=${request}                   headers=${HEADER_PAYMENT}         expected_status=${statusCode}
    Log many                                         ${response.text}
    ${json}                                          Convert String To JSON           ${response.text}
    Should Be Equal As Strings                       ${statusCode}                    ${response.status_code}
    Set Test Variable                                ${actual}                        ${response.text}
    ${status} =                                      Run Keyword And Return Status    Should Be Equal As Strings    ${statusCode}                        ${response.status_code}
    Write_Result_Status_To_Excel_CardTokenization    ${EXCEL_NAME}                    ${SHEET_NAME}                 ${rowNo}                             ${status}                         ${response.status_code}
    Run Keyword If                                   ${status}==False                 Log                           Fail
    ...                                              ELSE IF                          ${status}==True               Log                                  ${actual}

API_Handling_Error_Direct
    [Arguments]                   ${rowNo}                               ${statusCode}    ${testcaseName}
    Generate_File_Path_Request    ${JSON_DIRECT}
    ${data_test}                  Read_Excel_For_Test                    ${EXCEL_NAME}    ${SHEET_NAME}      ${rowNo}
    ${request}                    Prepare_Data_For_API_Payment_Direct    ${data_test}
    ${data}                       Post_Handling_Error_Direct             ${request}       ${statusCode}      ${rowNo}

Post_Handling_Error_Direct
    [Arguments]       ${request}            ${statusCode}       ${rowNo}
    Generate_Token
    Create Session    handling              ${HOST_NAME}        verify=${True}
    Run Keyword If    ${statusCode}==404    Url_Worng_Direct    ${request}        ${statusCode}    ${rowNo}    ELSE    Json_Worng_Direct    ${request}    ${statusCode}    ${rowNo}    

Url_Worng_Direct
    [Arguments]                              ${request}                       ${statusCode}                 ${rowNo}
    ${HEADER_PAYMENT}=                       create dictionary                Authorization=${token}        Content-Type=application/json                  sourceTransID=${sourceTransID}    clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    Log                                      ${request}
    ${response}=                             POST On Session                  handling                      ${API_Handling_CardTokenizationy['${ENV}']}    data=${request}                   headers=${HEADER_PAYMENT}         expected_status=${statusCode}
    Log many                                 ${response.text}
    ${json}                                  Convert String To JSON           ${response.text}
    Should Be Equal As Strings               ${statusCode}                    ${response.status_code}
    Set Test Variable                        ${actual}                        ${response.text}
    ${status} =                              Run Keyword And Return Status    Should Be Equal As Strings    ${statusCode}                                  ${response.status_code}
    Write_Result_Status_To_Excel_Handling    ${EXCEL_NAME}                    ${SHEET_NAME}                 ${rowNo}                                       ${status}                         ${response.status_code}
    Run Keyword If                           ${status}==False                 Log                           Fail
    ...                                      ELSE IF                          ${status}==True               Log                                            ${actual}

Json_Worng_Direct
    [Arguments]                              ${request}                       ${statusCode}                 ${rowNo}
    ${request}                               Convert JSON To String           ${request}
    ${HEADER_PAYMENT}=                       create dictionary                Authorization=${token}        Content-Type=application/json        sourceTransID=${sourceTransID}    clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    Log                                      ${request}
    ${response}=                             POST On Session                  handling                      ${API_CardTokenization['${ENV}']}    data=${request}                   headers=${HEADER_PAYMENT}         expected_status=${statusCode}
    Log many                                 ${response.text}
    ${json}                                  Convert String To JSON           ${response.text}
    Should Be Equal As Strings               ${statusCode}                    ${response.status_code}
    Set Test Variable                        ${actual}                        ${response.text}
    ${status} =                              Run Keyword And Return Status    Should Be Equal As Strings    ${statusCode}                        ${response.status_code}
    Write_Result_Status_To_Excel_Handling    ${EXCEL_NAME}                    ${SHEET_NAME}                 ${rowNo}                             ${status}                         ${response.status_code}
    Run Keyword If                           ${status}==False                 Log                           Fail
    ...                                      ELSE IF                          ${status}==True               Log                                  ${actual}
