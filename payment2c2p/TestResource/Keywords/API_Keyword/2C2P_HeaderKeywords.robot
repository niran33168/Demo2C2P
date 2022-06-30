*** Settings ***
Resource    ../AllKeywords.txt

*** Keywords ***
Verify_Header_Post
    [Arguments]                     ${rowNo}                                                         ${testcaseName}                   ${parameter}                     ${missing_empty_invalid}          ${statusCode}                     ${invalid}=default
    ${Test_Data}                    Read_Excel_For_Test                                              ${EXCEL_NAME}                     ${SHEET_NAME}                    ${rowNo}
    Set Test Variable               ${expected}                                                      ${Test_Data['ExpectedApi']}
    Set Test Variable               ${testcaseNo}                                                    ${Test_Data['TestCaseNumber']}
    Generate_Token
    Create Session                  header                                                           ${HOST_NAME}                      verify=${True}
    ${HEADER_AH}=                   create dictionary                                                Authorization=${token}            Content-Type=a${Content_Type}    sourceTransID=${sourceTransID}    clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagepreference=${languagepreference}    partnerCode=${partnerCode}    transactionChannel=${transactionChannel}
    Run Keyword If                  '${missing_empty_invalid}'=='missing'                            Remove From Dictionary            ${HEADER_AH}                     ${parameter}
    Run Keyword If                  '${missing_empty_invalid}'=='empty'                              set to dictionary                 ${HEADER_AH}                     ${parameter}=
    Run Keyword If                  '${missing_empty_invalid}'=='invalid'                            set to dictionary                 ${HEADER_AH}                     ${parameter}=${invalid}
    ${json_request}                 Get Binary File                                                  ${file_path_request}.json
    ${response}=                    POST On Session                                                  header                            url=${URL_API}                   data=${json_request}              headers=${HEADER_AH}              expected_status=${statusCode}
    Log many                        ${response.text}
    Set Test Variable               ${actual}                                                        ${response.text}
    ${status} =                     Run Keyword And Return Status                                    Should Be Equal As Strings        ${statusCode}                    ${response.status_code}
    Run Keyword If                  ${status}==True and ${response.status_code}!=200                 Verify_Expected
    Write_Result_Status_To_Excel    ${EXCEL_NAME}                                                    ${SHEET_NAME}                     ${rowNo}                         ${status}
    Run Keyword If                  ${status}==False                                                 fail                              ${expected} != ${actual}
    ...                             ELSE IF                                                          ${status}==True                   Log                              ${actual}