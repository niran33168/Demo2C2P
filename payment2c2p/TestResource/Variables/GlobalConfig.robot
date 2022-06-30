*** Variables ***
#### AUTHORIZATION ####
${endpoint}              https://uat-api.viriyah.co.th
${request_uri}           /uat/gw/api/authen/token/v1/generate
${Content_Type}          application/json
${sourceTransID}         t101
${requestTime}           2021-07-02T21:00:00
${languagePreference}    TH
${grantType}             password
${userName}              x10-test
${passWord}              1234
${scope}                 profile

#### Payment ####
${transactionChannel}    001
${partnerCode}           Test001

#### Web ####
${URL}            https://demo2.2c2p.com/My2C2P/client/2.0/Login
${URL_MAIL}       https://vmail.viriyah.co.th/owa/auth/logon.aspx    
${URL_KAFDROP}    http://kafdropdev.viriyah.cloud/ 
${BROWSER}        chrome
${timeout}        30 s


#### API ####
${HOST_NAME}                         https://uat-api.viriyah.co.th
&{API_PAYMENT_REDIRECT}              uat=/uat/gw/api/payment/v1/2c2p/payment          sit=/sit/gw/api/payment/v1/2c2p/payment
&{API_QUICKPAY}                      uat=/uat/gw/api/payment/v1/2c2p/quickpay         sit=/sit/gw/api/payment/v1/2c2p/quickpay
&{API_INQUIRY}                       uat=/uat/gw/api/payment/v1/2c2p/inquiry          sit=/sit/gw/api/payment/v1/2c2p/inquiry
&{API_VOID}                          uat=/uat/gw/api/payment/v1/2c2p/void             sit=/sit/gw/api/payment/v1/2c2p/void
&{API_Handling}                      uat=/uat/gw/api/payment/v1/2c2p/paymentH         sit=/sit/gw/api/payment/v1/2c2p/paymentH
&{API_Handling_Quickpay}             uat=/uat/gw/api/payment/v1/2c2p/quickpayH        sit=/sit/gw/api/payment/v1/2c2p/quickpayH
&{API_CardTokenization}              uat=/uat/gw/api/payment/v1/2c2p/tokenization     sit=/sit/gw/api/payment/v1/2c2p/tokenization
&{API_Handling_CardTokenizationy}    uat=/uat/gw/api/payment/v1/2c2p/tokenizationH    sit=/sit/gw/api/payment/v1/2c2p/tokenizationH


#### HEADER AH ####
${sourceTransID}    16736
${requestTime}      2021-07-05T13:00:00                         
&{clientId}         uat=ec81d967-0192-4680-939e-8de81980d336    sit=ec81d967-0192-4680-939e-8de81980d336
&{clientSecret}     uat=02f477ad-39b9-4cc5-a151-f98323dfd60b    sit=02f477ad-39b9-4cc5-a151-f98323dfd60b