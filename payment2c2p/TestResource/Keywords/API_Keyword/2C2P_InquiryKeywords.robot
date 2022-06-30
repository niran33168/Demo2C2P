*** Settings ***
Resource    ../AllKeywords.txt

*** Keywords ***
Post_Validation_Inquiry
    [Arguments]                             ${request}                                   ${statusCode}                     ${card_type}                     ${rowNo} 
    Generate_Token
    Create Session                          inquiry                                      ${HOST_NAME}                      verify=${True}
    ${HEADER_INQUIRY}=                      create dictionary                            Authorization=${token}            Content-Type=application/json    sourceTransID=${sourceTransID}       clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagepreference=${languagepreference}    transactionChannel=${transactionChannel}    partnerCode=${partnerCode}
    ${response}=                            POST On Session                              inquiry                           ${API_INQUIRY['${ENV}']}         data=${request}                      headers=${HEADER_INQUIRY}         expected_status=${statusCode}
    Log many                                ${response.text}
    ${request_json}                         Convert String To JSON                       ${request}
    Log many                                ${request_json} 
    ${json}                                 Convert String To JSON                       ${response.text}
    Log many                                ${json}
    Should Be Equal As Strings              ${statusCode}                                ${response.status_code}
    Should Be Equal As Strings              00                                           ${json['respCode']}
    Should Be Equal As Strings              Success                                      ${json['respDesc']}
    Should Be Equal As Strings              ${request_json['version']}                   ${json['version']}
    Should Be Equal As Strings              ${request_json['invoiceNo']}                 ${json['invoiceNo']}
    Should Be Equal As Strings              ${request_json['processType']}               ${json['processType']}
    Should Be Equal As Strings              A                                            ${json['status']}
    Should Be Equal As Strings              ${request_json['paymentToken']['amount']}    ${json['amount']}
    ${CARD_TYPE}                            Convert To Lower Case                        ${card_type}
    Run Keyword If                          '${CARD_TYPE}' == 'unionpay'                 VerifyResponeuserDefinedNone      ${request_json}                  ${json}                              
    ...                                     ELSE IF                                      '${CARD_TYPE}' == 'jcb'           VerifyResponeuserDefinedNone     ${request_json}                      ${json}                           
    ...                                     ELSE                                         VerifyResponeuserDefined          ${request_json}                  ${json} 
    Run Keyword If                          '${CARD_TYPE}' == 'visa'                     Should Be Equal As Strings        ${MASK_CARD_NUMBER_NO_VISA}      ${json['maskedPan']}
    ...                                     ELSE IF                                      '${CARD_TYPE}' == 'mastercard'    Should Be Equal As Strings       ${MASK_CARD_NUMBER_NO_MASTERCARD}    ${json['maskedPan']}
    ...                                     ELSE IF                                      '${CARD_TYPE}' == 'jcb'           Should Be Equal As Strings       ${MASK_CARD_NUMBER_NO_JCB}           ${json['maskedPan']}
    ...                                     ELSE IF                                      '${CARD_TYPE}' == 'unionpay'      Should Be Equal As Strings       ${MASK_CARD_NUMBER_NO_UNIONPAY}      ${json['maskedPan']}
    Set Test Variable                       ${actual}                                    ${response.text}
    ${status} =                             Run Keyword And Return Status                Should Be Equal As Strings        ${statusCode}                    ${response.status_code}
    Write_Result_Status_To_Excel_Inquiry    ${EXCEL_NAME}                                ${SHEET_NAME}                     ${rowNo}                         ${status}
    Run Keyword If                          ${status}==False                             Log                               Fail
    ...                                     ELSE IF                                      ${status}==True                   Log                              ${actual}

VerifyResponeuserDefined
    [Arguments]                   ${request_json}                                    ${json} 
    Should Be Equal As Strings    ${request_json['paymentToken']['userDefined1']}    ${json['userDefined1']}
    Should Be Equal As Strings    ${request_json['paymentToken']['userDefined2']}    ${json['userDefined2']}
    Should Be Equal As Strings    ${request_json['paymentToken']['userDefined3']}    ${json['userDefined3']}
    Should Be Equal As Strings    ${request_json['paymentToken']['userDefined4']}    ${json['userDefined4']}
    Should Be Equal As Strings    ${request_json['paymentToken']['userDefined5']}    ${json['userDefined5']}

VerifyResponeuserDefinedNone
    [Arguments]                   ${request_json}    ${json} 
    Should Be Equal As Strings    None               ${json['userDefined1']}
    Should Be Equal As Strings    None               ${json['userDefined2']}
    Should Be Equal As Strings    None               ${json['userDefined3']}
    Should Be Equal As Strings    None               ${json['userDefined4']}
    Should Be Equal As Strings    None               ${json['userDefined5']}
