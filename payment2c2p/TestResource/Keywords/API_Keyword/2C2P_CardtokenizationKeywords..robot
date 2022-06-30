*** Settings ***
Resource    ../AllKeywords.txt

*** Keywords ***
API_Validation_Cardtokenization
    [Arguments]                   ${rowNo}                                         ${statusCode}    ${testcaseName}
    Generate_File_Path_Request    ${JSON_CardTokenization}
    ${data_test}                  Read_Excel_For_Test                              ${EXCEL_NAME}    ${SHEET_NAME}      ${rowNo}
    ${request}                    Prepare_Data_For_API_Payment_CardTokenization    ${data_test}
    ${data}                       Post_Validation_CardTokenization                 ${request}       ${statusCode}      ${rowNo}
    ${data}                       Post_Validation_Payment_Card                     ${request}       ${data}            ${statusCode}    ${rowNo}

API_Validation_Cardtokenization_Direct
    [Arguments]                   ${rowNo}                                         ${statusCode}    ${testcaseName}
    Generate_File_Path_Request    ${JSON_CardTokenization_Direct}
    ${data_test}                  Read_Excel_For_Test                              ${EXCEL_NAME}    ${SHEET_NAME}      ${rowNo}
    ${request}                    Prepare_Data_For_API_Payment_CardTokenization    ${data_test}
    ${data}                       Post_Validation_CardTokenization                 ${request}       ${statusCode}      ${rowNo}
    ${data}                       Post_Validation_Payment_Card                     ${request}       ${data}            ${statusCode}    ${rowNo}

API_Validation_Cardtokenization_Business
    [Arguments]                   ${rowNo}                                         ${statusCode}    ${testcaseName}
    Generate_File_Path_Request    ${JSON_CardTokenization}
    ${data_test}                  Read_Excel_For_Test                              ${EXCEL_NAME}    ${SHEET_NAME}      ${rowNo}
    ${request}                    Prepare_Data_For_API_Payment_CardTokenization    ${data_test}
    ${data}                       Post_Validation_CardTokenization_Business        ${request}       ${statusCode}      ${rowNo}

Post_Validation_CardTokenization
    [Arguments]                                      ${request}                            ${statusCode}                 ${rowNo}
    Generate_Token
    Create Session                                   tokenization                          ${HOST_NAME}                  verify=${True}
    ${HEADER_PAYMENT}=                               create dictionary                     Authorization=${token}        Content-Type=application/json        sourceTransID=${sourceTransID}    clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    ${response}=                                     POST On Session                       tokenization                  ${API_CardTokenization['${ENV}']}    data=${request}                   headers=${HEADER_PAYMENT}         expected_status=${statusCode}
    Log many                                         ${response.text}
    ${json}                                          Convert String To JSON                ${response.text}
    ${request_json}                                  Convert String To JSON                ${request}
    Should Be Equal As Strings                       ${statusCode}                         ${response.status_code}
    Should Be Equal As Strings                       ${request_json['version']}            ${json['version']}
    Should Be Equal As Strings                       ${request_json['merchantID']}         ${json['merchantID']}
    Should Be Equal As Strings                       ${request_json['panBank']}            ${json['panBank']}
    Should Be Equal As Strings                       ${request_json['panCountry']}         ${json['panCountry']}
    Should Be Equal As Strings                       ${request_json['cardHolderName']}     ${json['cardholderName']}
    Should Be Equal As Strings                       ${request_json['cardHolderEmail']}    ${json['cardholderEmail']}
    Set Test Variable                                ${actual}                             ${response.text}
    ${status} =                                      Run Keyword And Return Status         Should Be Equal As Strings    ${statusCode}                        ${response.status_code}
    Write_Result_Status_To_Excel_CardTokenization    ${EXCEL_NAME}                         ${SHEET_NAME}                 ${rowNo}                             ${status}                         ${response.status_code}
    Run Keyword If                                   ${status}==False                      Log                           Fail
    ...                                              ELSE IF                               ${status}==True               Log                                  ${actual}
    [Return]                                         ${json}

Post_Validation_CardTokenization_Business
    [Arguments]                                      ${request}                       ${statusCode}                 ${rowNo}
    Generate_Token
    Create Session                                   tokenization                     ${HOST_NAME}                  verify=${True}
    ${HEADER_PAYMENT}=                               create dictionary                Authorization=${token}        Content-Type=application/json        sourceTransID=${sourceTransID}    clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    ${response}=                                     POST On Session                  tokenization                  ${API_CardTokenization['${ENV}']}    data=${request}                   headers=${HEADER_PAYMENT}         expected_status=${statusCode}
    Log many                                         ${response.text}
    ${json}                                          Convert String To JSON           ${response.text}
    ${request_json}                                  Convert String To JSON           ${request}
    Should Be Equal As Strings                       ${statusCode}                    ${response.status_code}
    Should Be Equal As Strings                       ${request_json['version']}       ${json['version']}
    Should Be Equal As Strings                       ${request_json['merchantID']}    ${json['merchantID']}
    Set Test Variable                                ${actual}                        ${response.text}
    ${status} =                                      Run Keyword And Return Status    Should Be Equal As Strings    ${statusCode}                        ${response.status_code}
    Write_Result_Status_To_Excel_CardTokenization    ${EXCEL_NAME}                    ${SHEET_NAME}                 ${rowNo}                             ${status}                         ${response.status_code}
    Run Keyword If                                   ${status}==False                 Log                           Fail
    ...                                              ELSE IF                          ${status}==True               Log                                  ${actual}
    [Return]                                         ${json}

Post_Validation_Payment_Card
    [Arguments]           ${request}           ${data}                   ${statusCode}                        ${rowNo}
    ${request}            Update_Json          ${request}                ${data}
    Generate_Token
    Create Session        payment              ${HOST_NAME}              verify=${True}
    ${HEADER_PAYMENT}=    create dictionary    Authorization=${token}    Content-Type=application/json        sourceTransID=${sourceTransID}    clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    ${response}=          POST On Session      payment                   ${API_PAYMENT_REDIRECT['${ENV}']}    data=${request}                   headers=${HEADER_PAYMENT}         expected_status=${statusCode}
    Log many              ${response.text}

API_Validation_Parameter_Cardtokenization_Missing
    [Arguments]                   ${rowNo}                                         ${statusCode}    ${testcaseName}
    Generate_File_Path_Request    ${JSON_CardTokenization}
    ${data_test}                  Read_Excel_For_Test                              ${EXCEL_NAME}    ${SHEET_NAME}      ${rowNo}
    ${request}                    Prepare_Data_For_API_Payment_CardTokenization    ${data_test}
    ${data}                       Post_Validation_CardTokenization_Missing         ${request}       ${statusCode}      ${rowNo}

Post_Validation_CardTokenization_Missing
    [Arguments]                                      ${request}                       ${statusCode}                       ${rowNo}
    Generate_Token
    Create Session                                   tokenization                     ${HOST_NAME}                        verify=${True}
    ${HEADER_PAYMENT}=                               create dictionary                Authorization=${token}              Content-Type=application/json        sourceTransID=${sourceTransID}    clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    Log                                              ${request}
    ${response}=                                     POST On Session                  tokenization                        ${API_CardTokenization['${ENV}']}    data=${request}                   headers=${HEADER_PAYMENT}         expected_status=${statusCode}
    Log many                                         ${response.text}
    ${json}                                          Convert String To JSON           ${response.text}
    Should Be Equal As Strings                       ${Error_2_MS_101}                ${json['integrationStatusCode']}
    Set Test Variable                                ${actual}                        ${response.text}
    ${status} =                                      Run Keyword And Return Status    Should Be Equal As Strings          ${statusCode}                        ${response.status_code}
    Write_Result_Status_To_Excel_CardTokenization    ${EXCEL_NAME}                    ${SHEET_NAME}                       ${rowNo}                             ${status}                         ${response.status_code}
    Run Keyword If                                   ${status}==False                 Log                                 Fail
    ...                                              ELSE IF                          ${status}==True                     Log                                  ${actual}

API_Validation_Parameter_Cardtokenization_Empty
    [Arguments]                   ${rowNo}                                         ${statusCode}    ${testcaseName}
    Generate_File_Path_Request    ${JSON_CardTokenization}
    ${data_test}                  Read_Excel_For_Test                              ${EXCEL_NAME}    ${SHEET_NAME}      ${rowNo}
    ${request}                    Prepare_Data_For_API_Payment_CardTokenization    ${data_test}
    ${data}                       Post_Validation_CardTokenization_Empty           ${request}       ${statusCode}      ${rowNo}

Post_Validation_CardTokenization_Empty
    [Arguments]                                      ${request}                       ${statusCode}                 ${rowNo}
    Generate_Token
    Create Session                                   tokenization                     ${HOST_NAME}                  verify=${True}
    ${HEADER_PAYMENT}=                               create dictionary                Authorization=${token}        Content-Type=application/json        sourceTransID=${sourceTransID}      clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    Log                                              ${request}
    ${response}=                                     POST On Session                  tokenization                  ${API_CardTokenization['${ENV}']}    data=${request}                     headers=${HEADER_PAYMENT}         expected_status=${statusCode}
    Log many                                         ${response.text}
    ${json}                                          Convert String To JSON           ${response.text}
    Run Keyword If                                   ${rowno}==23                     Should Be Equal As Strings    ${Error_2_MS_101}                    ${json['integrationStatusCode']}    ELSE                              Should Be Equal As Strings                ${Error_2_MS_VAD100}          ${json['integrationStatusCode']}
    Set Test Variable                                ${actual}                        ${response.text}
    ${status} =                                      Run Keyword And Return Status    Should Be Equal As Strings    ${statusCode}                        ${response.status_code}
    Write_Result_Status_To_Excel_CardTokenization    ${EXCEL_NAME}                    ${SHEET_NAME}                 ${rowNo}                             ${status}                           ${response.status_code}
    Run Keyword If                                   ${status}==False                 Log                           Fail
    ...                                              ELSE IF                          ${status}==True               Log                                  ${actual}

API_Validation_Parameter_Cardtokenization_Invalid
    [Arguments]                   ${rowNo}                                         ${statusCode}    ${testcaseName}
    Generate_File_Path_Request    ${JSON_CardTokenization}
    ${data_test}                  Read_Excel_For_Test                              ${EXCEL_NAME}    ${SHEET_NAME}      ${rowNo}
    ${request}                    Prepare_Data_For_API_Payment_CardTokenization    ${data_test}
    ${data}                       Post_Validation_CardTokenization_Invalid         ${request}       ${statusCode}      ${rowNo}

Post_Validation_CardTokenization_Invalid
    [Arguments]                                      ${request}                                                      ${statusCode}                 ${rowNo}
    Generate_Token
    Create Session                                   tokenization                                                    ${HOST_NAME}                  verify=${True}
    ${HEADER_PAYMENT}=                               create dictionary                                               Authorization=${token}        Content-Type=application/json        sourceTransID=${sourceTransID}    clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}          languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    Log                                              ${request}
    ${response}=                                     POST On Session                                                 tokenization                  ${API_CardTokenization['${ENV}']}    data=${request}                   headers=${HEADER_PAYMENT}         expected_status=${statusCode}
    Log many                                         ${response.text}
    ${json}                                          Convert String To JSON                                          ${response.text}
    Run Keyword If                                   ${rowNo}==24 or ${rowNo}==25 or ${rowNo}==27 or ${rowNo}==33    Log                           TRUE                                 ELSE                              Should Be Equal As Strings        ${Error_2_MS_101}                         ${json['integrationStatusCode']}
    Set Test Variable                                ${actual}                                                       ${response.text}
    ${status} =                                      Run Keyword And Return Status                                   Should Be Equal As Strings    ${statusCode}                        ${response.status_code}
    Write_Result_Status_To_Excel_CardTokenization    ${EXCEL_NAME}                                                   ${SHEET_NAME}                 ${rowNo}                             ${status}                         ${response.status_code}
    Run Keyword If                                   ${status}==False                                                Log                           Fail
    ...                                              ELSE IF                                                         ${status}==True               Log                                  ${actual}

Update_Json
    [Arguments]         ${request}                ${data}
    ${request_json}     Convert String To JSON    ${request}
    ${cardTokens}       Create List               
    Insert Into List    ${cardTokens}             0                  ${data['storeCardUniqueID']}
    ${request_json}     Update Value To Json      ${request_json}    $..paymentToken.cardTokens      ${cardTokens}
    ${request_json}     Delete Object From Json    ${request_json}    $..version
    ${request_json}     Delete Object From Json    ${request_json}    $..action
    ${request_json}     Delete Object From Json    ${request_json}    $..pan
    ${request_json}     Delete Object From Json    ${request_json}    $..panExpiry
    ${request_json}     Delete Object From Json    ${request_json}    $..panBank
    ${request_json}     Delete Object From Json    ${request_json}    $..panCountry
    ${request_json}     Delete Object From Json    ${request_json}    $..panCurrency
    ${request_json}     Delete Object From Json    ${request_json}    $..cardHolderName
    ${request_json}     Delete Object From Json    ${request_json}    $..cardHolderEmail   
    ${request_json}     Delete Object From Json    ${request_json}    $.merchantID   
    ${request}          Convert JSON To String    ${request_json}
    [Return]            ${request}