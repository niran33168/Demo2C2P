*** Settings ***
Resource    ../AllKeywords.txt

*** Keywords ***
Open WebPayment 2C2P
    [Arguments]                ${URL}                          ${CARD_TYPE}     ${invoice}
    Open Browser               ${URL}                          ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed         0.2s
    InputCardInfo              ${CARD_TYPE}
    Run Keyword If             '${CARD_TYPE}' == 'unionpay'    ProcessUnion     ${invoice}    
    ...                        ELSE                            ProcessNormal    ${invoice}

Open WebPayment 2C2P Quickpay
    [Arguments]                ${URL}                             ${CARD_TYPE}                       ${invoice}
    Open Browser               ${URL}                             ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed         0.2s
    Run Keyword If             '${CARD_TYPE}' != 'Installment'    InputCardInfo                      ${CARD_TYPE}    ELSE    InputCardInfoInstallment    visa
    Run Keyword If             '${CARD_TYPE}' == 'unionpay'       ProcessUnion                       ${invoice} 
    ...                        ELSE IF                            '${CARD_TYPE}' == 'Installment'    Log             true    
    ...                        ELSE                               ProcessNormalQuickpay              ${invoice}

Open WebPayment 2C2P Installment
    [Arguments]                 ${URL}          ${CARD_TYPE}    ${invoice}
    Open Browser                ${URL}          ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed          0.2s
    InputCardInfoInstallment    ${CARD_TYPE}

Open WebPayment 2C2P Direct
    [Arguments]                ${URL}    ${invoice}
    Open Browser               ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed         0.2s
    InputOTP
    Close Browser

InputCardInfoInstallment
    [Arguments]           ${CARD_TYPE}
    ${CARD_TYPE}          Convert To Lower Case                                                                                                                                                                                                                     ${CARD_TYPE}
    Run Keyword If        '${CARD_TYPE}' == 'visa'                                                                                                                                                                                                                  InputTextField                    ${TXT_CARD_NUMBER_LOCATOR}        ${CARD_NUMBER_NO_VISA}
    ...                   ELSE IF                                                                                                                                                                                                                                   '${CARD_TYPE}' == 'mastercard'    InputTextField                    ${TXT_CARD_NUMBER_LOCATOR}        ${CARD_NUMBER_NO_MASTERCARD}
    ...                   ELSE IF                                                                                                                                                                                                                                   '${CARD_TYPE}' == 'jcb'           InputTextField                    ${TXT_CARD_NUMBER_LOCATOR}        ${CARD_NUMBER_NO_JCB}
    ...                   ELSE IF                                                                                                                                                                                                                                   '${CARD_TYPE}' == 'unionpay'      InputTextField                    ${TXT_CARD_NUMBER_LOCATOR}        ${CARD_NUMBER_NO_UNIONPAY}
    InputTextField        ${TXT_EXPIRY_DATE_LOCATOR}                                                                                                                                                                                                                ${EXPIRY_DATE}
    InputTextField        ${TXT_CVV_LOCATOR}                                                                                                                                                                                                                        ${CVV}
    Run Keyword If        '${CARD_TYPE}' == 'visa'                                                                                                                                                                                                                  InputTextField                    ${TXT_CARD_HOLDERNAME_LOCATOR}    ${CARD_HOLDERNAME_VISA}
    ...                   ELSE IF                                                                                                                                                                                                                                   '${CARD_TYPE}' == 'mastercard'    InputTextField                    ${TXT_CARD_HOLDERNAME_LOCATOR}    ${CARD_HOLDERNAME_MASTERCARD}
    ...                   ELSE IF                                                                                                                                                                                                                                   '${CARD_TYPE}' == 'jcb'           InputTextField                    ${TXT_CARD_HOLDERNAME_LOCATOR}    ${CARD_HOLDERNAME_JCB}
    ...                   ELSE IF                                                                                                                                                                                                                                   '${CARD_TYPE}' == 'unionpay'      InputTextField                    ${TXT_CARD_HOLDERNAME_LOCATOR}    ${CARD_HOLDERNAME_UNIONPAY}
    InputTextField        ${TXT_EMAIL_ADDRESS_LOCATOR}                                                                                                                                                                                                              ${EMAIL_ADDRESS}                  
    Execute JavaScript    document.querySelector("#app > div > div.sidebar > div.main-control > div > div > div.accordion__content > div > div > div > div > form:nth-child(2) > div:nth-child(3) > div > div > div.checkbox-container > label > input").click()
    Execute JavaScript    document.querySelector("#app > div > div.sidebar > div.main-control > div > div > div.accordion__content > div > div > div > div > form:nth-child(2) > div:nth-child(10) > button.btn.btn-primary").click()                               #Click Button Continue payment

ProcessNormalQuickpay
    [Arguments]                    ${invoice}    
    InputOTP                       
    VerifyPaymentSucessQuickpay    ${invoice}
    Close Browser

ProcessNormal
    [Arguments]            ${invoice}    
    InputOTP
    VerifyPaymentSucess    ${invoice}
    Close Browser

ProcessUnion
    [Arguments]                      ${invoice}
    ClickButton                      ${BTN_SEND_ANYWAYS}
    Wait Until Element Is Visible    ${TXT_UNION}            ${timeout}
    InputTextField                   ${TXT_EXPIRE_MONTH}     12
    InputTextField                   ${TXT_EXPIRE_YEAR}      33
    InputTextField                   ${TXT_CVN}              ${CVV}
    Click Element                    ${TXT_CHANGE_NUMBER}
    Click Element                    ${DDL_CHANGE_NUMBER}
    Click Element                    ${DDL_CHANGE_THAI}
    InputTextField                   ${TXT_CALL_NUMBER}      ${CALL_NUMBER}
    Click Element                    ${BTN_SEND_MSG}
    InputTextField                   ${TXT_SMS}              ${VERIFY_CODE}
    Select Checkbox                  ${CHK_AGREE}
    Sleep                            5s
    Click Element                    ${BTN_CARD_PAY}
    VerifyPaymentSucess              ${invoice}
    Close Browser

Open WebPayment 2C2P QR
    [Arguments]                ${URL}                ${CARD_TYPE}    ${invoice}
    Open Browser               ${URL}                ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed         0.2s
    SelectPaymentQR            ${CARD_TYPE}
    ClickButton                ${BTN_GENERATE_QR}
    VerifyQRCode
    Close Browser              

Open WebPayment 2C2P Quickpay QR
    [Arguments]                ${URL}                                                                                                                            ${CARD_TYPE}    ${invoice}
    Open Browser               ${URL}                                                                                                                            ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed         0.2s
    Execute JavaScript         document.querySelector("#app > div > div.sidebar > div.main-control > div > div:nth-child(2) > div.accordion__header").click()
    SelectPaymentQR            ${CARD_TYPE}
    ClickButton                ${BTN_GENERATE_QR}
    VerifyQRCode
    Close Browser              

Open Web Mail
    Open Browser               ${URL_MAIL}    ${BROWSER}
    Maximize Browser Window
    LoginMail
    SearchMail
    Close Browser

Open WebPayment Log
    [Arguments]                      ${invoice}              ${rowNo}
    Open Browser                     ${URL}                  ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${HEADER_LOGIN_2C2P}
    Login2C2P
    SearchInvoiceNo                  ${invoice}              ${rowNo}
    Close Browser

InputTextField
    [Arguments]                      ${Locator}    ${Text}
    Wait Until Element Is Visible    ${Locator}    ${timeout}
    Input Text                       ${Locator}    ${Text}

ClickButton
    [Arguments]                      ${Locator}
    Wait Until Element Is Visible    ${Locator}    ${timeout}
    Click Element                    ${Locator}

LoginMail
    InputTextField        ${TXT_USERNAME_MAIL_LOCATOR}                                         ${WEB_MAIL_USERNAME}
    InputTextField        ${TXT_PASSWORD_MAIL_LOCATOR}                                         ${WEB_MAIL_PASSWORD}
    Execute Javascript    document.querySelector("#lgnDiv > div.signInEnter > div").click()    #Click Button Signin

Login2C2P
    InputTextField    ${TXT_USERNAME_LOCATOR}    ${WEB_USERNAME}
    InputTextField    ${TXT_PASSWORD_LOCATOR}    ${WEB_PASSWORD}
    ClickButton       ${BTN_LOGIN_LOCATOR}

InputCardInfo
    [Arguments]           ${CARD_TYPE}
    ${CARD_TYPE}          Convert To Lower Case                                                                                                                                                                             ${CARD_TYPE}
    Run Keyword If        '${CARD_TYPE}' == 'visa'                                                                                                                                                                          InputTextField                    ${TXT_CARD_NUMBER_LOCATOR}        ${CARD_NUMBER_NO_VISA}
    ...                   ELSE IF                                                                                                                                                                                           '${CARD_TYPE}' == 'mastercard'    InputTextField                    ${TXT_CARD_NUMBER_LOCATOR}        ${CARD_NUMBER_NO_MASTERCARD}
    ...                   ELSE IF                                                                                                                                                                                           '${CARD_TYPE}' == 'jcb'           InputTextField                    ${TXT_CARD_NUMBER_LOCATOR}        ${CARD_NUMBER_NO_JCB}
    ...                   ELSE IF                                                                                                                                                                                           '${CARD_TYPE}' == 'unionpay'      InputTextField                    ${TXT_CARD_NUMBER_LOCATOR}        ${CARD_NUMBER_NO_UNIONPAY}
    InputTextField        ${TXT_EXPIRY_DATE_LOCATOR}                                                                                                                                                                        ${EXPIRY_DATE}
    InputTextField        ${TXT_CVV_LOCATOR}                                                                                                                                                                                ${CVV}
    Run Keyword If        '${CARD_TYPE}' == 'visa'                                                                                                                                                                          InputTextField                    ${TXT_CARD_HOLDERNAME_LOCATOR}    ${CARD_HOLDERNAME_VISA}
    ...                   ELSE IF                                                                                                                                                                                           '${CARD_TYPE}' == 'mastercard'    InputTextField                    ${TXT_CARD_HOLDERNAME_LOCATOR}    ${CARD_HOLDERNAME_MASTERCARD}
    ...                   ELSE IF                                                                                                                                                                                           '${CARD_TYPE}' == 'jcb'           InputTextField                    ${TXT_CARD_HOLDERNAME_LOCATOR}    ${CARD_HOLDERNAME_JCB}
    ...                   ELSE IF                                                                                                                                                                                           '${CARD_TYPE}' == 'unionpay'      InputTextField                    ${TXT_CARD_HOLDERNAME_LOCATOR}    ${CARD_HOLDERNAME_UNIONPAY}
    InputTextField        ${TXT_EMAIL_ADDRESS_LOCATOR}                                                                                                                                                                      ${EMAIL_ADDRESS}                  
    Execute JavaScript    document.querySelector("#app > div > div.sidebar > div > div > div > div.accordion__content > div > div > div > div > form:nth-child(2) > div:nth-child(10) > button.btn.btn-primary").click()    #Click Button Continue payment

InputOTP
    Wait Until Element Is Visible    ${BTN_PROCESS}                                 ${timeout}
    InputTextField                   ${TXT_OTP_LOCATOR}                             ${OTP}
    Click Element                    ${TXT_LABEL}
    Execute JavaScript               document.querySelector("#continue").click()    #Click Button Proceed

VerifyPaymentSucess
    [Arguments]                      ${invoice}
    Wait Until Element Is Visible    ${HEADER_TRANSACTION_LOCATOR}    ${timeout}
    ${TRANSACTION}                   Get Text                         ${HEADER_TRANSACTION_LOCATOR}
    ${INVOICE_NUMBER}                Get Text                         ${INVOICE_NUMBER_LOCATOR}
    Should Be Equal                  ${TRANSACTION}                   ${TRANSACTION_SUCCESS}
    Should Be Equal                  ${INVOICE_NUMBER}                ${invoice}                       

VerifyPaymentSucessQuickpay
    [Arguments]                      ${invoice}
    Wait Until Element Is Visible    ${HEADER_TRANSACTION_LOCATOR}    ${timeout}
    ${TRANSACTION}                   Get Text                         ${HEADER_TRANSACTION_LOCATOR}
    ${INVOICE_NUMBER}                Get Text                         ${INVOICE_NUMBER_LOCATOR}
    Should Be Equal                  ${TRANSACTION}                   ${TRANSACTION_SUCCESS}
    Should Be Equal                  ${INVOICE_NUMBER}                ${invoice}                       

SearchMail
    Wait Until Element Is Visible    ${TXT_UNREAD}                                    ${timeout}
    Execute JavaScript               document.querySelector("#_ariaId_42").click()    #Click Tab Unread
    Sleep                            10s
    Wait Until Element Is Visible    ${TXT_2C2P_SERVICE}                              ${timeout}
    Capture Page Screenshot

SearchInvoiceNo
    [Arguments]                         ${invoice}                       ${rowNo}
    Wait Until Element Is Visible       ${TXT_TABLE_INVOICE}             ${timeout}
    Execute JavaScript                  window.scrollTo(0,500)
    ${INVOICE}                          Get Text                         ${TXT_TABLE_INVOICE}
    ${CARD_NO}                          Get Text                         ${TXT_TABLE_CARD_NO}
    ${STATUS}                           Run Keyword If                   '${rowNo}'=='14'                                                Get Text        ${TXT_TABLE_STATUS_VOID4}    ELSE IF    '${rowNo}'=='15'    Get Text      ${TXT_TABLE_STATUS_VOID3}    ELSE IF    '${rowNo}'=='16'    Get Text    ${TXT_TABLE_STATUS_VOID2}    ELSE IF    '${rowNo}'=='17'    Get Text    ${TXT_TABLE_STATUS_VOID1}    ELSE    Get Text    ${TXT_TABLE_STATUS}    
    Should Be Equal As Strings          ${INVOICE}                       ${invoice}
    Set Test Variable                   ${actual}                        ${STATUS}
    ${STATUSSET}                        Run Keyword If                   ${rowNo}==14 or ${rowNo}==15 or ${rowNo}==16 or ${rowNo}==17    Set Variable    VOIDED                       ELSE       Set Variable        ${APPROVE}    
    ${status} =                         Run Keyword And Return Status    Should Be Equal As Strings                                      ${actual}       ${STATUSSET}
    Write_Result_Status_To_Excel_Log    ${EXCEL_NAME}                    ${SHEET_NAME}                                                   ${rowNo}        ${status}
    Run Keyword If                      ${status}==False                 Log                                                             Fail
    ...                                 ELSE IF                          ${status}==True                                                 Log             ${actual}
    [Return]                            ${CARD_NO}                       

SelectPaymentQR
    [Arguments]                      ${CARD_TYPE}
    Wait Until Element Is Visible    ${TXT_PAY_NAME}                                                                                                                           ${timeout}
    ${CARD_TYPE}                     Convert To Lower Case                                                                                                                     ${CARD_TYPE}
    Execute JavaScript               document.getElementsByClassName("react-select__indicator")[0].children[0].dispatchEvent(new MouseEvent('mousedown', {"bubbles":true}))
    Run Keyword If                   '${CARD_TYPE}' == 'shopee'                                                                                                                Execute JavaScript                document.getElementById('react-select-3-option-4').children[0].click()
    ...                              ELSE IF                                                                                                                                   '${CARD_TYPE}' == 'visa'          Execute JavaScript                                                        document.getElementById('react-select-3-option-0').children[0].click()
    ...                              ELSE IF                                                                                                                                   '${CARD_TYPE}' == 'upi'           Execute JavaScript                                                        document.getElementById('react-select-3-option-1').children[0].click()
    ...                              ELSE IF                                                                                                                                   '${CARD_TYPE}' == 'mastercard'    Execute JavaScript                                                        document.getElementById('react-select-3-option-2').children[0].click()
    ...                              ELSE IF                                                                                                                                   '${CARD_TYPE}' == 'promptpay'     Execute JavaScript                                                        document.getElementById('react-select-3-option-3').children[0].click()
    ...                              ELSE IF                                                                                                                                   '${CARD_TYPE}' == 'grabpay'       Execute JavaScript                                                        document.getElementById('react-select-3-option-5').children[0].click()
    Run Keyword If                   '${CARD_TYPE}' == 'shopee'                                                                                                                InputTextField                    ${TXT_PAY_NAME}                                                           ${SHOPEE}
    ...                              ELSE IF                                                                                                                                   '${CARD_TYPE}' == 'visa'          InputTextField                                                            ${TXT_PAY_NAME}                                                           ${SHOPEE}
    ...                              ELSE IF                                                                                                                                   '${CARD_TYPE}' == 'mastercard'    InputTextField                                                            ${TXT_PAY_NAME}                                                           ${MASTERCARD}
    ...                              ELSE IF                                                                                                                                   '${CARD_TYPE}' == 'upi'           InputTextField                                                            ${TXT_PAY_NAME}                                                           ${UPI}
    ...                              ELSE IF                                                                                                                                   '${CARD_TYPE}' == 'promptpay'     InputTextField                                                            ${TXT_PAY_NAME}                                                           ${PROMPTPAY}
    ...                              ELSE IF                                                                                                                                   '${CARD_TYPE}' == 'grabpay'       InputTextField                                                            ${TXT_PAY_NAME}                                                           ${GRABPAY} 
    InputTextField                   ${TXT_EMAIL_ADDRESS_LOCATOR}                                                                                                              ${EMAIL_ADDRESS}

VerifyQRCode
    Wait Until Element Is Visible    ${IMG_QR}         ${timeout}
    Wait Until Element Is Visible    ${BTN_SAVE_QR}    ${timeout}
    Capture Page Screenshot

Open Web kafdropdev
    Open Browser                     ${URL_KAFDROP}             ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${TXT_FILTER_TOPIC}        ${timeout}            
    InputTextField                   ${TXT_FILTER_TOPIC}        pay
    Click Element                    ${TXT_TOPIC_SELECT_SIT}
    Wait Until Element Is Visible    ${BTN_VIEW_MESSAGE}        ${timeout}
    Click Element                    ${BTN_VIEW_MESSAGE}
    Clear Element Text               ${TXT_OFFSET_MESSAGE}
    ${LAST_OFFSET}                   Get Text                   ${TXT_LAST_OFFSET}
    ${OFFSET}                        Evaluate                   ${LAST_OFFSET}-1
    InputTextField                   ${TXT_OFFSET_MESSAGE}      ${OFFSET}
    Click Element                    ${BTN_VIEW_LOG_MESSAGE}
    ${LOG_MESSAGE}                   Get Text                   ${TXT_LOG_MESSAGE}
    Log                              ${LOG_MESSAGE}