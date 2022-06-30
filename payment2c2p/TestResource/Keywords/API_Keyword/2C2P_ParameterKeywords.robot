*** Settings ***
Resource    ../AllKeywords.txt

*** Keywords ***
API_Validation_Parameter_Payment_Missing
    [Arguments]                   ${rowNo}                                   ${statusCode}    ${testcaseName}
    Generate_File_Path_Request    ${JSON_Varidate}
    ${data_test}                  Read_Excel_For_Test                        ${EXCEL_NAME}    ${SHEET_NAME}      ${rowNo}
    ${request}                    Prepare_Data_For_API_Payment_Validation    ${data_test}     ${testcaseName}    
    ${data}                       Post_Validation_Parameter_Missing          ${request}       ${statusCode}      ${rowNo}

Post_Validation_Parameter_Missing
    [Arguments]                                      ${request}                       ${statusCode}                 ${rowNo}
    Generate_Token
    Create Session                                   payment                          ${HOST_NAME}                  verify=${True}
    ${HEADER_PAYMENT}=                               create dictionary                Authorization=${token}        Content-Type=application/json        sourceTransID=${sourceTransID}      clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}                                          requestTime=${requestTime}    languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    Log                                              ${request}
    ${response}=                                     POST On Session                  payment                       ${API_PAYMENT_REDIRECT['${ENV}']}    data=${request}                     headers=${HEADER_PAYMENT}         expected_status=${statusCode}
    Log many                                         ${response.text}
    ${json}                                          Convert String To JSON           ${response.text}
    Run Keyword If                                   ${rowNo}==10 or ${rowNo}==13     Should Be Equal As Strings    ${Error_2_MS_2C2P101}                ${json['integrationStatusCode']}    ELSE IF                           ${rowNo}==14 or ${rowNo}==15 or ${rowNo}==18 or ${rowNo}==19 or ${rowNo}==21    Should Be Equal As Strings    ${Error_2_MS_VAD100}                        ${json['integrationStatusCode']}            ELSE                          Should Be Equal As Strings    ${Error_2_MS_101}    ${json['integrationStatusCode']}    
    Set Test Variable                                ${actual}                        ${response.text}
    ${status} =                                      Run Keyword And Return Status    Should Be Equal As Strings    ${statusCode}                        ${response.status_code}
    Write_Result_Status_To_Excel_Validate_Payment    ${EXCEL_NAME}                    ${SHEET_NAME}                 ${rowNo}                             ${status}                           ${response.status_code}
    Run Keyword If                                   ${status}==False                 Log                           Fail
    ...                                              ELSE IF                          ${status}==True               Log                                  ${actual}

API_Validation_Parameter_Payment_Empty
    [Arguments]                   ${rowNo}                                   ${statusCode}    ${testcaseName}
    Generate_File_Path_Request    ${JSON_Varidate}
    ${data_test}                  Read_Excel_For_Test                        ${EXCEL_NAME}    ${SHEET_NAME}      ${rowNo}
    ${request}                    Prepare_Data_For_API_Payment_Validation    ${data_test}     ${testcaseName}    
    ${data}                       Post_Validation_Parameter_Empty            ${request}       ${statusCode}      ${rowNo}

Post_Validation_Parameter_Empty
    [Arguments]                                      ${request}                       ${statusCode}                 ${rowNo}
    Generate_Token
    Create Session                                   payment                          ${HOST_NAME}                  verify=${True}
    ${HEADER_PAYMENT}=                               create dictionary                Authorization=${token}        Content-Type=application/json        sourceTransID=${sourceTransID}      clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    Log                                              ${request}
    ${response}=                                     POST On Session                  payment                       ${API_PAYMENT_REDIRECT['${ENV}']}    data=${request}                     headers=${HEADER_PAYMENT}         expected_status=${statusCode}
    Log many                                         ${response.text}
    ${json}                                          Convert String To JSON           ${response.text}
    Run Keyword If                                   ${rowNo}==29                     Should Be Equal As Strings    ${Error_2_MS_2C2P101}                ${json['integrationStatusCode']}    ELSE IF                           ${rowNo}>=30                              Should Be Equal As Strings    ${Error_2_MS_VAD100}                        ${json['integrationStatusCode']}            ELSE IF                       ${rowNo}==24 or ${rowNo}==25 or ${rowNo}==28    Should Be Equal As Strings    2_MS_VAD100    ${json['integrationStatusCode']}    ELSE    Should Be Equal As Strings    ${Error_2_MS_101}    ${json['integrationStatusCode']}    
    Set Test Variable                                ${actual}                        ${response.text}
    ${status} =                                      Run Keyword And Return Status    Should Be Equal As Strings    ${statusCode}                        ${response.status_code}
    Write_Result_Status_To_Excel_Validate_Payment    ${EXCEL_NAME}                    ${SHEET_NAME}                 ${rowNo}                             ${status}                           ${response.status_code}
    Run Keyword If                                   ${status}==False                 Log                           Fail
    ...                                              ELSE IF                          ${status}==True               Log                                  ${actual}

API_Validation_Parameter_Payment_Invalid
    [Arguments]                   ${rowNo}                                   ${statusCode}    ${testcaseName}
    Generate_File_Path_Request    ${JSON_Varidate}
    ${data_test}                  Read_Excel_For_Test                        ${EXCEL_NAME}    ${SHEET_NAME}      ${rowNo}
    ${request}                    Prepare_Data_For_API_Payment_Validation    ${data_test}     ${testcaseName}    
    ${data}                       Post_Validation_Parameter_Invalid          ${request}       ${statusCode}      ${rowNo}

Post_Validation_Parameter_Invalid
    [Arguments]                                      ${request}                       ${statusCode}                       ${rowNo}
    Generate_Token
    Create Session                                   payment                          ${HOST_NAME}                        verify=${True}
    ${HEADER_PAYMENT}=                               create dictionary                Authorization=${token}              Content-Type=application/json        sourceTransID=${sourceTransID}    clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    Log                                              ${request}
    ${response}=                                     POST On Session                  payment                             ${API_PAYMENT_REDIRECT['${ENV}']}    data=${request}                   headers=${HEADER_PAYMENT}         expected_status=${statusCode}
    Log many                                         ${response.text}
    ${json}                                          Convert String To JSON           ${response.text}
    Should Be Equal As Strings                       ${Error_2_MS_101}                ${json['integrationStatusCode']}
    Set Test Variable                                ${actual}                        ${response.text}
    ${status} =                                      Run Keyword And Return Status    Should Be Equal As Strings          ${statusCode}                        ${response.status_code}
    Write_Result_Status_To_Excel_Validate_Payment    ${EXCEL_NAME}                    ${SHEET_NAME}                       ${rowNo}                             ${status}                         ${response.status_code}
    Run Keyword If                                   ${status}==False                 Log                                 Fail
    ...                                              ELSE IF                          ${status}==True                     Log                                  ${actual}

API_Validation_Parameter_Inquiry_Missing
    [Arguments]                   ${rowNo}                                     ${statusCode}    ${testcaseName}
    Generate_File_Path_Request    ${JSON_Varidate}
    ${data_test}                  Read_Excel_For_Test                          ${EXCEL_NAME}    ${SHEET_NAME}      ${rowNo}
    ${request}                    Prepare_Data_For_API_Inquiry                 ${data_test}     ${testcaseName}    
    ${data}                       Post_Validation_Parameter_Inquiry_Missing    ${request}       ${statusCode}      ${rowNo}

Post_Validation_Parameter_Inquiry_Missing
    [Arguments]                             ${request}                       ${statusCode}                       ${rowNo}
    Generate_Token
    Create Session                          inquiry                          ${HOST_NAME}                        verify=${True}
    ${HEADER_PAYMENT}=                      create dictionary                Authorization=${token}              Content-Type=application/json    sourceTransID=${sourceTransID}    clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    Log                                     ${request}
    ${response}=                            POST On Session                  inquiry                             ${API_INQUIRY['${ENV}']}         data=${request}                   headers=${HEADER_PAYMENT}         expected_status=${statusCode}
    Log many                                ${response.text}
    ${json}                                 Convert String To JSON           ${response.text}
    Should Be Equal As Strings              ${Error_2_MS_101}                ${json['integrationStatusCode']}
    Set Test Variable                       ${actual}                        ${response.text}
    ${status} =                             Run Keyword And Return Status    Should Be Equal As Strings          ${statusCode}                    ${response.status_code}
    Write_Result_Status_To_Excel_Validate_Payment    ${EXCEL_NAME}                    ${SHEET_NAME}                       ${rowNo}                             ${status}                         ${response.status_code}
    Run Keyword If                          ${status}==False                 Log                                 Fail
    ...                                     ELSE IF                          ${status}==True                     Log                              ${actual}

API_Validation_Parameter_Inquiry_Empty
    [Arguments]                   ${rowNo}                                   ${statusCode}    ${testcaseName}
    Generate_File_Path_Request    ${JSON_Varidate}
    ${data_test}                  Read_Excel_For_Test                        ${EXCEL_NAME}    ${SHEET_NAME}      ${rowNo}
    ${request}                    Prepare_Data_For_API_Inquiry               ${data_test}     ${testcaseName}    
    ${data}                       Post_Validation_Parameter_Inquiry_Empty    ${request}       ${statusCode}      ${rowNo}

Post_Validation_Parameter_Inquiry_Empty
    [Arguments]                             ${request}                       ${statusCode}                       ${rowNo}
    Generate_Token
    Create Session                          inquiry                          ${HOST_NAME}                        verify=${True}
    ${HEADER_PAYMENT}=                      create dictionary                Authorization=${token}              Content-Type=application/json    sourceTransID=${sourceTransID}    clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    Log                                     ${request}
    ${response}=                            POST On Session                  inquiry                             ${API_INQUIRY['${ENV}']}         data=${request}                   headers=${HEADER_PAYMENT}         expected_status=${statusCode}
    Log many                                ${response.text}
    ${json}                                 Convert String To JSON           ${response.text}
    Should Be Equal As Strings              ${Error_2_MS_101}                ${json['integrationStatusCode']}
    Set Test Variable                       ${actual}                        ${response.text}
    ${status} =                             Run Keyword And Return Status    Should Be Equal As Strings          ${statusCode}                    ${response.status_code}
    Write_Result_Status_To_Excel_Validate_Payment    ${EXCEL_NAME}                    ${SHEET_NAME}                       ${rowNo}                             ${status}                         ${response.status_code}
    Run Keyword If                          ${status}==False                 Log                                 Fail
    ...                                     ELSE IF                          ${status}==True                     Log                              ${actual}

API_Validation_Parameter_Inquiry_Invalid
    [Arguments]                   ${rowNo}                                     ${statusCode}    ${testcaseName}
    Generate_File_Path_Request    ${JSON_Varidate}
    ${data_test}                  Read_Excel_For_Test                          ${EXCEL_NAME}    ${SHEET_NAME}      ${rowNo}
    ${request}                    Prepare_Data_For_API_Inquiry                 ${data_test}     ${testcaseName}    
    ${data}                       Post_Validation_Parameter_Inquiry_Invalid    ${request}       ${statusCode}      ${rowNo}

Post_Validation_Parameter_Inquiry_Invalid
    [Arguments]                             ${request}                                                 ${statusCode}                 ${rowNo}
    Generate_Token
    Create Session                          inquiry                                                    ${HOST_NAME}                  verify=${True}
    ${HEADER_PAYMENT}=                      create dictionary                                          Authorization=${token}        Content-Type=application/json    sourceTransID=${sourceTransID}      clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    Log                                     ${request}
    ${response}=                            POST On Session                                            inquiry                       ${API_INQUIRY['${ENV}']}         data=${request}                     headers=${HEADER_PAYMENT}         expected_status=${statusCode}
    Log many                                ${response.text}
    ${json}                                 Convert String To JSON                                     ${response.text}
    Run Keyword If                          "${json['integrationStatusCode']}"=="${Error_2_MS_101}"    Should Be Equal As Strings    ${Error_2_MS_101}                ${json['integrationStatusCode']}    ELSE                              Should Be Equal As Strings                1_MS_100                      ${json['integrationStatusCode']}
    Set Test Variable                       ${actual}                                                  ${response.text}
    ${status} =                             Run Keyword And Return Status                              Should Be Equal As Strings    ${statusCode}                    ${response.status_code}
    Write_Result_Status_To_Excel_Validate_Payment    ${EXCEL_NAME}                    ${SHEET_NAME}                       ${rowNo}                             ${status}                         ${response.status_code}
    Run Keyword If                          ${status}==False                                           Log                           Fail
    ...                                     ELSE IF                                                    ${status}==True               Log                              ${actual}

API_Validation_Parameter_Void_Missing
    [Arguments]                   ${rowNo}                                  ${statusCode}    ${testcaseName}
    Generate_File_Path_Request    ${JSON_Void}
    ${data_test}                  Read_Excel_For_Test                       ${EXCEL_NAME}    ${SHEET_NAME}      ${rowNo}
    ${request}                    Prepare_Data_For_API_Void                 ${data_test}     ${testcaseName}    
    ${data}                       Post_Validation_Parameter_Void_Missing    ${request}       ${statusCode}      ${rowNo}

Post_Validation_Parameter_Void_Missing
    [Arguments]                             ${request}                       ${statusCode}                       ${rowNo}
    Generate_Token
    Create Session                          void                             ${HOST_NAME}                        verify=${True}
    ${HEADER_PAYMENT}=                      create dictionary                Authorization=${token}              Content-Type=application/json    sourceTransID=${sourceTransID}    clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    Log                                     ${request}
    ${response}=                            POST On Session                  void                                ${API_VOID['${ENV}']}            data=${request}                   headers=${HEADER_PAYMENT}         expected_status=${statusCode}
    Log many                                ${response.text}
    ${json}                                 Convert String To JSON           ${response.text}
    Should Be Equal As Strings              ${Error_2_MS_101}                ${json['integrationStatusCode']}
    Set Test Variable                       ${actual}                        ${response.text}
    ${status} =                             Run Keyword And Return Status    Should Be Equal As Strings          ${statusCode}                    ${response.status_code}
    Write_Result_Status_To_Excel_Payment    ${EXCEL_NAME}                    ${SHEET_NAME}                       ${rowNo}                         ${status}
    Run Keyword If                          ${status}==False                 Log                                 Fail
    ...                                     ELSE IF                          ${status}==True                     Log                              ${actual}

API_Validation_Parameter_Void_Empty
    [Arguments]                   ${rowNo}                                ${statusCode}    ${testcaseName}
    Generate_File_Path_Request    ${JSON_Void}
    ${data_test}                  Read_Excel_For_Test                     ${EXCEL_NAME}    ${SHEET_NAME}      ${rowNo}
    ${request}                    Prepare_Data_For_API_Void               ${data_test}     ${testcaseName}    
    ${data}                       Post_Validation_Parameter_Void_Empty    ${request}       ${statusCode}      ${rowNo}

Post_Validation_Parameter_Void_Empty
    [Arguments]                             ${request}                       ${statusCode}                       ${rowNo}
    Generate_Token
    Create Session                          void                             ${HOST_NAME}                        verify=${True}
    ${HEADER_PAYMENT}=                      create dictionary                Authorization=${token}              Content-Type=application/json    sourceTransID=${sourceTransID}    clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    Log                                     ${request}
    ${response}=                            POST On Session                  void                                ${API_VOID['${ENV}']}            data=${request}                   headers=${HEADER_PAYMENT}         expected_status=${statusCode}
    Log many                                ${response.text}
    ${json}                                 Convert String To JSON           ${response.text}
    Should Be Equal As Strings              ${Error_2_MS_101}                ${json['integrationStatusCode']}
    Set Test Variable                       ${actual}                        ${response.text}
    ${status} =                             Run Keyword And Return Status    Should Be Equal As Strings          ${statusCode}                    ${response.status_code}
    Write_Result_Status_To_Excel_Payment    ${EXCEL_NAME}                    ${SHEET_NAME}                       ${rowNo}                         ${status}
    Run Keyword If                          ${status}==False                 Log                                 Fail
    ...                                     ELSE IF                          ${status}==True                     Log                              ${actual}

API_Validation_Parameter_Void_Invalid
    [Arguments]                   ${rowNo}                                  ${statusCode}    ${testcaseName}
    Generate_File_Path_Request    ${JSON_Void}
    ${data_test}                  Read_Excel_For_Test                       ${EXCEL_NAME}    ${SHEET_NAME}      ${rowNo}
    ${request}                    Prepare_Data_For_API_Void                 ${data_test}     ${testcaseName}    
    ${data}                       Post_Validation_Parameter_Void_Invalid    ${request}       ${statusCode}      ${rowNo}

Post_Validation_Parameter_Void_Invalid
    [Arguments]                             ${request}                                                 ${statusCode}                 ${rowNo}
    Generate_Token
    Create Session                          void                                                       ${HOST_NAME}                  verify=${True}
    ${HEADER_PAYMENT}=                      create dictionary                                          Authorization=${token}        Content-Type=application/json    sourceTransID=${sourceTransID}      clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    Log                                     ${request}
    ${response}=                            POST On Session                                            void                          ${API_VOID['${ENV}']}            data=${request}                     headers=${HEADER_PAYMENT}         expected_status=${statusCode}
    Log many                                ${response.text}
    ${json}                                 Convert String To JSON                                     ${response.text}
    Run Keyword If                          "${json['integrationStatusCode']}"=="${Error_2_MS_101}"    Should Be Equal As Strings    ${Error_2_MS_101}                ${json['integrationStatusCode']}    ELSE                              Should Be Equal As Strings                1_MS_100                      ${json['integrationStatusCode']}
    Set Test Variable                       ${actual}                                                  ${response.text}
    ${status} =                             Run Keyword And Return Status                              Should Be Equal As Strings    ${statusCode}                    ${response.status_code}
    Write_Result_Status_To_Excel_Payment    ${EXCEL_NAME}                                              ${SHEET_NAME}                 ${rowNo}                         ${status}
    Run Keyword If                          ${status}==False                                           Log                           Fail
    ...                                     ELSE IF                                                    ${status}==True               Log                              ${actual}
