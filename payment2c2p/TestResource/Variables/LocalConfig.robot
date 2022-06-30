*** Variables ***
#### PATH FILE ####

#### EXCEL ####
${EXCEL_2C2P_PAYMENT}                 ./TestResource/DataTest/Excel_Script/2c2p_Fullredirect_Script.xlsx
${SHEET_Redirect}                     Redirect
${SHEET_Direct}                       Direct
${SHEET_Quickpay}                     Quickpay
${SHEET_Validate_Payment}             Validate_Payment
${SHEET_Validate_Inquiry}             Validate_Inquiry
${SHEET_Validate_Void}                Validate_Void
${SHEET_Validate_CardTokenization}    Validate_CardTokenization
${SHEET_HEADER}                       Header

#### JSON REQUEST ####
${JSON_DIRECT}                     /API_Direct/Direct
${JSON_REDIRECT}                   /API_Redirect/Redirect
${JSON_REDIRECTRECURRING}          /API_Redirect/RedirectRecurring
${JSON_REDIRECTINSTALLMENT}        /API_Redirect/RedirectInstallment 
${JSON_Varidate}                   /API_Validate/Validate
${JSON_QuickPay}                   /API_QuickPay/QuickPay
${JSON_Void}                       /API_Void/Void
${JSON_CardTokenization}           /API_CardTokenization/CardTokenization
${JSON_CardTokenization_Direct}    /API_CardTokenization/CardTokenizationDirect
${JSON_HEADER}                     /API_Redirect/Header

#### Web Locator ####
${HEADER_LOGIN_2C2P}               xpath=//h1[@class="card-title"]
${TXT_USERNAME_LOCATOR}            xpath=//input[@id="UserName"]
${TXT_PASSWORD_LOCATOR}            xpath=//input[@id="Password"]
${BTN_LOGIN_LOCATOR}               xpath=//button[@type="submit"]
${TXT_CARD_NUMBER_LOCATOR}         xpath=//input[@id="tel-cardNumber"]
${TXT_CARD_HOLDERNAME_LOCATOR}     xpath=//input[@id="name"]
${TXT_EXPIRY_DATE_LOCATOR}         xpath=//input[@id="expyear"]
${TXT_CVV_LOCATOR}                 xpath=//input[@id="tel-cvv"]
${TXT_EMAIL_ADDRESS_LOCATOR}       xpath=//input[@id="email-email"]
${BTN_CONTINUE_PAYMENT_LOCATOR}    xpath=//button[@type="submit"]
${TXT_OTP_LOCATOR}                 xpath=//input[@id="otp"]
${BTN_PROCESS}                     xpath=//input[@class="btn col-xs-12 btn-proceed"]
${TXT_LABEL}                       xpath=//div[@id="dvLoaderOverlay"]//div[@class="card-inform-section"]/span/span
${TXT_USERNAME_MAIL_LOCATOR}       xpath=//input[@id="username"]
${TXT_PASSWORD_MAIL_LOCATOR}       xpath=//input[@id="password"]
${BTN_SIGNIN_MAIL}                 xpath=//div[@class="signinbutton"]
${TXT_ERROR}                       xpath=//div[11]/div/span

${TXT_QR_PAYMENT}    xpath=//div[@class="accordion"]//div[@class="accordion__item accordion__item--collapse-out"][1]

${HEADER_TRANSACTION_LOCATOR}    xpath=//div[@class="payment-result-modal__title"]
${INVOICE_NUMBER_LOCATOR}        xpath=//div[@class="payment-result-modal__body"]//b

${TXT_UNREAD}          xpath=//span[@data-pi="1"][contains(text(),'Unread')]
${TXT_2C2P_SERVICE}    xpath=//span[contains(text(),'2C2P SERVICE')][1]

### UnionPay ###
${BTN_SEND_ANYWAYS}     xpath=//button[@id="proceed-button"]
${TXT_UNION}            xpath=//div[@id="get-mobile-id"]
${TXT_EXPIRE_MONTH}     xpath=//input[@id="expireMonth"]
${TXT_EXPIRE_YEAR}      xpath=//input[@id="expireYear"]
${TXT_CVN}              xpath=//input[@id="cvn2"]
${TXT_CHANGE_NUMBER}    xpath=//div[@id="get-mobile-id"]/a
${DDL_CHANGE_NUMBER}    xpath=//a[@id="areaCode-choice-id"]
${DDL_CHANGE_THAI}      xpath=//div[@id="areaCode-list"]//li[@title="Thailand"]
${TXT_CALL_NUMBER}      xpath=//input[@id="cellPhoneNumber"] 
${BTN_SEND_MSG}         xpath=//input[@id="btnGetCode"]
${BTN_CARD_PAY}         xpath=//input[@id="btnCardPay"]
${TXT_SMS}              xpath=//input[@id="smsCode"]
${CHK_AGREE}            xpath=//input[@id="isCheckAgreement"]

${TXT_TABLE_INVOICE}         xpath=//tbody//tr[1]//td[3]
${TXT_TABLE_CARD_NO}         xpath=//tbody//tr[1]//td[4]
${TXT_TABLE_STATUS}          xpath=//tbody//tr[1]//td[6]//span
${TXT_TABLE_STATUS_VOID1}    xpath=//tbody//tr[2]//td[6]//span
${TXT_TABLE_STATUS_VOID2}    xpath=//tbody//tr[3]//td[6]//span
${TXT_TABLE_STATUS_VOID3}    xpath=//tbody//tr[4]//td[6]//span
${TXT_TABLE_STATUS_VOID4}    xpath=//tbody//tr[5]//td[6]//span

${TXT_WELCOME}    xpath=//h4/text()

${CHK_ACCEPT}    xpath=//input[@type="checkbox"]

### QR ###
${TXT_PAY_NAME}       xpath=//input[@id="text-name"]
${BTN_GENERATE_QR}    xpath=//button[@type="submit"]
${IMG_QR}             xpath=//div[@class="qr-container qr-container--active"]
${BTN_SAVE_QR}        xpath=//button[@class="btn btn-primary"]

### KAFDROP ###
${TXT_FILTER_TOPIC}        xpath=//input[@id="filter"]
${TXT_TOPIC_SELECT_SIT}    xpath=//table//a[contains(text(),'payment-status-sit')]
${BTN_VIEW_MESSAGE}        xpath=//a[@id="topic-messages"]
${TXT_LAST_OFFSET}         xpath=//span[@id="lastOffset"]
${TXT_OFFSET_MESSAGE}      xpath=//input[@id="offset"]
${BTN_VIEW_LOG_MESSAGE}    xpath=//button[@id="viewMessagesBtn"]
${TXT_LOG_MESSAGE}         xpath=//pre[@class="message-body"]

#### Web Variables ####
${WEB_MAIL_USERNAME}                 niranl@viriyah.co.th
${WEB_MAIL_PASSWORD}                 Qwerty2534
${WEB_USERNAME}                      pakornk-9563@viriyah.co.th
${WEB_PASSWORD}                      Itx1@2022
${CARD_NUMBER_NO_VISA}               4111111111111111
${CARD_NUMBER_NO_MASTERCARD}         5555555555554444
${CARD_NUMBER_NO_JCB}                3566111111111113
${CARD_NUMBER_NO_UNIONPAY}           6250947000000014
${EXPIRY_DATE}                       1024
${CVV}                               123
${CARD_HOLDERNAME_VISA}              Visa
${CARD_HOLDERNAME_MASTERCARD}        Mastercard
${CARD_HOLDERNAME_JCB}               Jcb
${CARD_HOLDERNAME_UNIONPAY}          Unionpay
${EMAIL_ADDRESS}                     Niranl@viriyah.co.th
${OTP}                               123456
${TRANSACTION_SUCCESS}               Transaction is successful.
${APPROVE}                           APPROVED
${MASK_CARD_NUMBER_NO_VISA}          411111XXXXXX1111
${MASK_CARD_NUMBER_NO_MASTERCARD}    555555XXXXXX4444
${MASK_CARD_NUMBER_NO_JCB}           356611XXXXXX1113
${MASK_CARD_NUMBER_NO_UNIONPAY}      625094XXXXXX0014
${CALL_NUMBER}                       11112222
${VERIFY_CODE}                       111111
${SHOPEE}                            shopee
${MASTERCARD}                        mastercard
${UPI}                               upi
${PROMPTPAY}                         promptpay
${GRABPAY}                           grabpay

### Error ###
${Error_2_MS_101}        2_MS_101
${Error_2_MS_VAD100}     2_MS_VAD100
${Error_2_MS_2C2P101}    2_MS_2C2P101
