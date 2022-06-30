*** Settings ***
Resource    ../AllKeywords.txt

*** Keywords ***
Generate_InvoiceNo
    ${invoice}    Generate Random String    10                0123456789
    ${invoice}    Set Variable              QA-${invoice}	
    [Return]      ${invoice}

Generate_DateExpiry
    ${datetime}      Get Current Date    UTC
    ${datetime}      Add Time To Date    ${datetime}               1 days
    ${year}          Get Substring       ${datetime}               0         4
    ${month}         Get Substring       ${datetime}               5         7
    ${date}          Get Substring       ${datetime}               8         10
    ${dateexpiry}    Set Variable        ${date}${month}${year}
    [Return]         ${dateexpiry}

compare_date
    [Arguments]      ${date}
    Log              ${date}
    ${year}          Get Substring       ${date}                    4                      8
    ${month}         Get Substring       ${date}                    2                      4
    ${date}          Get Substring       ${date}                    0                      2
    ${datetest}      Set Variable        ${year}${month}${date} 
    ${datetime}      Get Current Date    UTC
    ${datetime}      Add Time To Date    ${datetime}                1 days
    ${date1}         Convert Date        ${datetest}                epoch
    ${date2}         Convert Date        ${datetime}                epoch
    ${dateexpiry}    Run Keyword If      ${date1} <= ${date2}       Generate_DateExpiry    ELSE    set to dictionary    ${json}    expiry=${Test_Data['expiry']}    
    [Return]         ${dateexpiry}

Prepare_Data_For_API_Payment_Redirect
    [Arguments]       ${Test_Data}
    ${json_string}    Get Binary File    ${file_path_request}.json
    Log               ${json_string}
    ${json}=          evaluate           json.loads('''${json_string}''')    json

    Run Keyword If    '${Test_Data['paymentScene']}'!='empty'      set to dictionary          ${json}    paymentScene=${Test_Data['paymentScene']}
    Run Keyword If    '${Test_Data['paymentScene']}'=='missing'    Delete Object From Json    ${json}    $..paymentScene

    ## paymentToken ##
    Run Keyword If    '${Test_Data['paymentToken.merchantID']}'!='empty' and '${Test_Data['paymentToken.merchantID']}'!='None'    set to dictionary          ${json['paymentToken']}    merchantID=${Test_Data['paymentToken.merchantID']}
    Run Keyword If    '${Test_Data['paymentToken.merchantID']}'=='missing'                                                        Delete Object From Json    ${json}                    $..paymentToken.merchantID

    ${invoice}        Run Keyword If                                                                                            '${Test_Data['paymentToken.invoiceNo']}'=='invoiceNo'    Generate_InvoiceNo         ELSE                         Set Variable    ${Test_Data['paymentToken.invoiceNo']}
    Run Keyword If    '${Test_Data['paymentToken.invoiceNo']}'!='empty' and '${Test_Data['paymentToken.invoiceNo']}'!='None'    set to dictionary                                        ${json['paymentToken']}    invoiceNo=${invoice}
    Run Keyword If    '${Test_Data['paymentToken.invoiceNo']}'=='missing'                                                       Delete Object From Json                                  ${json}                    $..paymentToken.invoiceNo

    Run Keyword If    '${Test_Data['paymentToken.description']}'!='empty' and '${Test_Data['paymentToken.description']}'!='None'    set to dictionary          ${json['paymentToken']}    description=${Test_Data['paymentToken.description']}
    Run Keyword If    '${Test_Data['paymentToken.description']}'=='missing'                                                         Delete Object From Json    ${json}                    $..paymentToken.description

    Run Keyword If    '${Test_Data['paymentToken.amount']}'!='empty' and '${Test_Data['paymentToken.amount']}'!='None'    set to dictionary          ${json['paymentToken']}    amount=${Test_Data['paymentToken.amount']}
    Run Keyword If    '${Test_Data['paymentToken.amount']}'=='missing'                                                    Delete Object From Json    ${json}                    $..paymentToken.amount

    Run Keyword If    '${Test_Data['paymentToken.currencyCode']}'!='empty' and '${Test_Data['paymentToken.currencyCode']}'!='None'    set to dictionary          ${json['paymentToken']}    currencyCode=${Test_Data['paymentToken.currencyCode']}
    Run Keyword If    '${Test_Data['paymentToken.currencyCode']}'=='missing'                                                          Delete Object From Json    ${json}                    $..paymentToken.currencyCode

    ${paymentChannel}    Create List          
    Insert Into List     ${paymentChannel}    0    ${Test_Data['paymentToken.paymentChannel']}

    Run Keyword If    '${Test_Data['paymentToken.paymentChannel']}'!='empty' and '${Test_Data['paymentToken.paymentChannel']}'!='None'    set to dictionary          ${json['paymentToken']}    paymentChannel=${paymentChannel}
    Run Keyword If    '${Test_Data['paymentToken.paymentChannel']}'=='missing'                                                            Delete Object From Json    ${json}                    $..paymentToken.paymentChannel

    Run Keyword If    '${Test_Data['paymentToken.backendReturnUrl']}'!='empty' and '${Test_Data['paymentToken.backendReturnUrl']}'!='None'    set to dictionary          ${json['paymentToken']}    backendReturnUrl=${Test_Data['paymentToken.backendReturnUrl']}
    Run Keyword If    '${Test_Data['paymentToken.backendReturnUrl']}'=='missing'                                                              Delete Object From Json    ${json}                    $..paymentToken.backendReturnUrl

    Run Keyword If    '${Test_Data['paymentToken.userDefined1']}'!='empty' and '${Test_Data['paymentToken.userDefined1']}'!='None'    set to dictionary          ${json['paymentToken']}    userDefined1=${Test_Data['paymentToken.userDefined1']}
    Run Keyword If    '${Test_Data['paymentToken.userDefined1']}'=='missing'                                                          Delete Object From Json    ${json}                    $..paymentToken.userDefined1

    Run Keyword If    '${Test_Data['paymentToken.userDefined2']}'!='empty' and '${Test_Data['paymentToken.userDefined2']}'!='None'    set to dictionary          ${json['paymentToken']}    userDefined2=${Test_Data['paymentToken.userDefined2']}
    Run Keyword If    '${Test_Data['paymentToken.userDefined2']}'=='missing'                                                          Delete Object From Json    ${json}                    $..paymentToken.userDefined2

    Run Keyword If    '${Test_Data['paymentToken.userDefined3']}'!='empty' and '${Test_Data['paymentToken.userDefined3']}'!='None'    set to dictionary          ${json['paymentToken']}    userDefined3=${Test_Data['paymentToken.userDefined3']}
    Run Keyword If    '${Test_Data['paymentToken.userDefined3']}'=='missing'                                                          Delete Object From Json    ${json}                    $..paymentToken.userDefined3

    Run Keyword If    '${Test_Data['paymentToken.userDefined4']}'!='empty' and '${Test_Data['paymentToken.userDefined4']}'!='None'    set to dictionary          ${json['paymentToken']}    userDefined4=${Test_Data['paymentToken.userDefined4']}
    Run Keyword If    '${Test_Data['paymentToken.userDefined4']}'=='missing'                                                          Delete Object From Json    ${json}                    $..paymentToken.userDefined4

    Run Keyword If    '${Test_Data['paymentToken.userDefined5']}'!='empty' and '${Test_Data['paymentToken.userDefined5']}'!='None'    set to dictionary          ${json['paymentToken']}    userDefined5=${Test_Data['paymentToken.userDefined5']}
    Run Keyword If    '${Test_Data['paymentToken.userDefined5']}'=='missing'                                                          Delete Object From Json    ${json}                    $..paymentToken.userDefined5

    Run Keyword If    '${Test_Data['paymentToken.cardTokens']}'!='empty' and '${Test_Data['paymentToken.cardTokens']}'!='None'    set to dictionary          ${json['paymentToken']}    cardTokens=${Test_Data['paymentToken.cardTokens']}
    Run Keyword If    '${Test_Data['paymentToken.cardTokens']}'=='missing'                                                        Delete Object From Json    ${json}                    $..paymentToken.cardTokens

    Run Keyword If    '${Test_Data['version']}'!='empty' and '${Test_Data['version']}'!='None'    set to dictionary          ${json}    version=${Test_Data['version']}
    Run Keyword If    '${Test_Data['version']}'=='missing'                                        Delete Object From Json    ${json}    $..version

    Run Keyword If    '${Test_Data['processType']}'!='empty' and '${Test_Data['processType']}'!='None'    set to dictionary          ${json}    processType=${Test_Data['processType']}
    Run Keyword If    '${Test_Data['processType']}'=='missing'                                            Delete Object From Json    ${json}    $..processType

    Run Keyword If    '${Test_Data['invoiceNo']}'!='empty' and '${Test_Data['invoiceNo']}'!='None'    set to dictionary          ${json}    invoiceNo=${Test_Data['invoiceNo']}
    Run Keyword If    '${Test_Data['invoiceNo']}'=='missing'                                          Delete Object From Json    ${json}    $..invoiceNo

    Run Keyword If    '${Test_Data['merchantID']}'!='empty' and '${Test_Data['merchantID']}'!='None'    set to dictionary          ${json}    merchantID=${Test_Data['merchantID']}
    Run Keyword If    '${Test_Data['merchantID']}'=='missing'                                           Delete Object From Json    ${json}    $..merchantID

    Run Keyword If    '${Test_Data['actionAmount']}'!='empty' and '${Test_Data['actionAmount']}'!='None'    set to dictionary          ${json}    actionAmount=${Test_Data['actionAmount']}
    Run Keyword If    '${Test_Data['actionAmount']}'=='missing'                                             Delete Object From Json    ${json}    $..actionAmount

    Run Keyword If    '${Test_Data['timeStamp']}'!='empty' and '${Test_Data['timeStamp']}'!='None'    set to dictionary          ${json}    timeStamp=${Test_Data['timeStamp']}
    Run Keyword If    '${Test_Data['timeStamp']}'=='missing'                                          Delete Object From Json    ${json}    $..timeStamp

    Log Dictionary     ${json}
    ${json_string}=    evaluate          json.dumps(${json})    json
    log many           ${json_string}
    log                ${json_string}
    [Return]           ${json_string}

Prepare_Data_For_API_Payment_Installment
    [Arguments]       ${Test_Data}
    ${json_string}    Get Binary File    ${file_path_request}.json
    Log               ${json_string}
    ${json}=          evaluate           json.loads('''${json_string}''')    json

    Run Keyword If    '${Test_Data['paymentScene']}'!='empty'      set to dictionary          ${json}    paymentScene=${Test_Data['paymentScene']}
    Run Keyword If    '${Test_Data['paymentScene']}'=='missing'    Delete Object From Json    ${json}    $..paymentScene

    ## paymentToken ##
    Run Keyword If    '${Test_Data['paymentToken.merchantID']}'!='empty' and '${Test_Data['paymentToken.merchantID']}'!='None'    set to dictionary          ${json['paymentToken']}    merchantID=${Test_Data['paymentToken.merchantID']}
    Run Keyword If    '${Test_Data['paymentToken.merchantID']}'=='missing'                                                        Delete Object From Json    ${json}                    $..paymentToken.merchantID

    ${invoice}        Run Keyword If                                                                                            '${Test_Data['paymentToken.invoiceNo']}'=='invoiceNo'    Generate_InvoiceNo         ELSE                         Set Variable    ${Test_Data['paymentToken.invoiceNo']}
    Run Keyword If    '${Test_Data['paymentToken.invoiceNo']}'!='empty' and '${Test_Data['paymentToken.invoiceNo']}'!='None'    set to dictionary                                        ${json['paymentToken']}    invoiceNo=${invoice}
    Run Keyword If    '${Test_Data['paymentToken.invoiceNo']}'=='missing'                                                       Delete Object From Json                                  ${json}                    $..paymentToken.invoiceNo

    Run Keyword If    '${Test_Data['paymentToken.description']}'!='empty' and '${Test_Data['paymentToken.description']}'!='None'    set to dictionary          ${json['paymentToken']}    description=${Test_Data['paymentToken.description']}
    Run Keyword If    '${Test_Data['paymentToken.description']}'=='missing'                                                         Delete Object From Json    ${json}                    $..paymentToken.description

    Run Keyword If    '${Test_Data['paymentToken.amount']}'!='empty' and '${Test_Data['paymentToken.amount']}'!='None'    set to dictionary          ${json['paymentToken']}    amount=${Test_Data['paymentToken.amount']}
    Run Keyword If    '${Test_Data['paymentToken.amount']}'=='missing'                                                    Delete Object From Json    ${json}                    $..paymentToken.amount

    Run Keyword If    '${Test_Data['paymentToken.currencyCode']}'!='empty' and '${Test_Data['paymentToken.currencyCode']}'!='None'    set to dictionary          ${json['paymentToken']}    currencyCode=${Test_Data['paymentToken.currencyCode']}
    Run Keyword If    '${Test_Data['paymentToken.currencyCode']}'=='missing'                                                          Delete Object From Json    ${json}                    $..paymentToken.currencyCode

    ${paymentChannel}    Create List          
    Insert Into List     ${paymentChannel}    0    ${Test_Data['paymentToken.paymentChannel']}

    Run Keyword If    '${Test_Data['paymentToken.paymentChannel']}'!='empty' and '${Test_Data['paymentToken.paymentChannel']}'!='None'    set to dictionary          ${json['paymentToken']}    paymentChannel=${paymentChannel}
    Run Keyword If    '${Test_Data['paymentToken.paymentChannel']}'=='missing'                                                            Delete Object From Json    ${json}                    $..paymentToken.paymentChannel

    Run Keyword If    '${Test_Data['paymentToken.backendReturnUrl']}'!='empty' and '${Test_Data['paymentToken.backendReturnUrl']}'!='None'    set to dictionary          ${json['paymentToken']}    backendReturnUrl=${Test_Data['paymentToken.backendReturnUrl']}
    Run Keyword If    '${Test_Data['paymentToken.backendReturnUrl']}'=='missing'                                                              Delete Object From Json    ${json}                    $..paymentToken.backendReturnUrl

    Run Keyword If    '${Test_Data['paymentToken.userDefined1']}'!='empty' and '${Test_Data['paymentToken.userDefined1']}'!='None'    set to dictionary          ${json['paymentToken']}    userDefined1=${Test_Data['paymentToken.userDefined1']}
    Run Keyword If    '${Test_Data['paymentToken.userDefined1']}'=='missing'                                                          Delete Object From Json    ${json}                    $..paymentToken.userDefined1

    Run Keyword If    '${Test_Data['paymentToken.userDefined2']}'!='empty' and '${Test_Data['paymentToken.userDefined2']}'!='None'    set to dictionary          ${json['paymentToken']}    userDefined2=${Test_Data['paymentToken.userDefined2']}
    Run Keyword If    '${Test_Data['paymentToken.userDefined2']}'=='missing'                                                          Delete Object From Json    ${json}                    $..paymentToken.userDefined2

    Run Keyword If    '${Test_Data['paymentToken.userDefined3']}'!='empty' and '${Test_Data['paymentToken.userDefined3']}'!='None'    set to dictionary          ${json['paymentToken']}    userDefined3=${Test_Data['paymentToken.userDefined3']}
    Run Keyword If    '${Test_Data['paymentToken.userDefined3']}'=='missing'                                                          Delete Object From Json    ${json}                    $..paymentToken.userDefined3

    Run Keyword If    '${Test_Data['paymentToken.userDefined4']}'!='empty' and '${Test_Data['paymentToken.userDefined4']}'!='None'    set to dictionary          ${json['paymentToken']}    userDefined4=${Test_Data['paymentToken.userDefined4']}
    Run Keyword If    '${Test_Data['paymentToken.userDefined4']}'=='missing'                                                          Delete Object From Json    ${json}                    $..paymentToken.userDefined4

    Run Keyword If    '${Test_Data['paymentToken.userDefined5']}'!='empty' and '${Test_Data['paymentToken.userDefined5']}'!='None'    set to dictionary          ${json['paymentToken']}    userDefined5=${Test_Data['paymentToken.userDefined5']}
    Run Keyword If    '${Test_Data['paymentToken.userDefined5']}'=='missing'                                                          Delete Object From Json    ${json}                    $..paymentToken.userDefined5

    Run Keyword If    '${Test_Data['paymentToken.installmentPeriodFilter']}'!='empty' and '${Test_Data['paymentToken.installmentPeriodFilter']}'!='None'    set to dictionary          ${json['paymentToken']}    installmentPeriodFilter=${Test_Data['paymentToken.installmentPeriodFilter']}
    Run Keyword If    '${Test_Data['paymentToken.installmentPeriodFilter']}'=='missing'                                                                     Delete Object From Json    ${json}                    $..paymentToken.installmentPeriodFilter 

    Log Dictionary     ${json}
    ${json_string}=    evaluate          json.dumps(${json})    json
    log many           ${json_string}
    log                ${json_string}
    [Return]           ${json_string}

Prepare_Data_For_API_Payment_Recurring
    [Arguments]       ${Test_Data}
    ${json_string}    Get Binary File    ${file_path_request}.json
    Log               ${json_string}
    ${json}=          evaluate           json.loads('''${json_string}''')    json

    Run Keyword If    '${Test_Data['paymentScene']}'!='empty'      set to dictionary          ${json}    paymentScene=${Test_Data['paymentScene']}
    Run Keyword If    '${Test_Data['paymentScene']}'=='missing'    Delete Object From Json    ${json}    $..paymentScene

    ## paymentToken ##
    Run Keyword If    '${Test_Data['paymentToken.merchantID']}'!='empty' and '${Test_Data['paymentToken.merchantID']}'!='None'    set to dictionary          ${json['paymentToken']}    merchantID=${Test_Data['paymentToken.merchantID']}
    Run Keyword If    '${Test_Data['paymentToken.merchantID']}'=='missing'                                                        Delete Object From Json    ${json}                    $..paymentToken.merchantID

    ${invoice}        Run Keyword If                                                                                            '${Test_Data['paymentToken.invoiceNo']}'=='invoiceNo'    Generate_InvoiceNo         ELSE                         Set Variable    ${Test_Data['paymentToken.invoiceNo']}
    Run Keyword If    '${Test_Data['paymentToken.invoiceNo']}'!='empty' and '${Test_Data['paymentToken.invoiceNo']}'!='None'    set to dictionary                                        ${json['paymentToken']}    invoiceNo=${invoice}
    Run Keyword If    '${Test_Data['paymentToken.invoiceNo']}'=='missing'                                                       Delete Object From Json                                  ${json}                    $..paymentToken.invoiceNo

    Run Keyword If    '${Test_Data['paymentToken.description']}'!='empty' and '${Test_Data['paymentToken.description']}'!='None'    set to dictionary          ${json['paymentToken']}    description=${Test_Data['paymentToken.description']}
    Run Keyword If    '${Test_Data['paymentToken.description']}'=='missing'                                                         Delete Object From Json    ${json}                    $..paymentToken.description

    Run Keyword If    '${Test_Data['paymentToken.amount']}'!='empty' and '${Test_Data['paymentToken.amount']}'!='None'    set to dictionary          ${json['paymentToken']}    amount=${Test_Data['paymentToken.amount']}
    Run Keyword If    '${Test_Data['paymentToken.amount']}'=='missing'                                                    Delete Object From Json    ${json}                    $..paymentToken.amount

    Run Keyword If    '${Test_Data['paymentToken.currencyCode']}'!='empty' and '${Test_Data['paymentToken.currencyCode']}'!='None'    set to dictionary          ${json['paymentToken']}    currencyCode=${Test_Data['paymentToken.currencyCode']}
    Run Keyword If    '${Test_Data['paymentToken.currencyCode']}'=='missing'                                                          Delete Object From Json    ${json}                    $..paymentToken.currencyCode

    ${paymentChannel}    Create List          
    Insert Into List     ${paymentChannel}    0    ${Test_Data['paymentToken.paymentChannel']}

    Run Keyword If    '${Test_Data['paymentToken.paymentChannel']}'!='empty' and '${Test_Data['paymentToken.paymentChannel']}'!='None'    set to dictionary          ${json['paymentToken']}    paymentChannel=${paymentChannel}
    Run Keyword If    '${Test_Data['paymentToken.paymentChannel']}'=='missing'                                                            Delete Object From Json    ${json}                    $..paymentToken.paymentChannel

    Run Keyword If    '${Test_Data['paymentToken.backendReturnUrl']}'!='empty' and '${Test_Data['paymentToken.backendReturnUrl']}'!='None'    set to dictionary          ${json['paymentToken']}    backendReturnUrl=${Test_Data['paymentToken.backendReturnUrl']}
    Run Keyword If    '${Test_Data['paymentToken.backendReturnUrl']}'=='missing'                                                              Delete Object From Json    ${json}                    $..paymentToken.backendReturnUrl

    Run Keyword If    '${Test_Data['paymentToken.userDefined1']}'!='empty' and '${Test_Data['paymentToken.userDefined1']}'!='None'    set to dictionary          ${json['paymentToken']}    userDefined1=${Test_Data['paymentToken.userDefined1']}
    Run Keyword If    '${Test_Data['paymentToken.userDefined1']}'=='missing'                                                          Delete Object From Json    ${json}                    $..paymentToken.userDefined1

    Run Keyword If    '${Test_Data['paymentToken.userDefined2']}'!='empty' and '${Test_Data['paymentToken.userDefined2']}'!='None'    set to dictionary          ${json['paymentToken']}    userDefined2=${Test_Data['paymentToken.userDefined2']}
    Run Keyword If    '${Test_Data['paymentToken.userDefined2']}'=='missing'                                                          Delete Object From Json    ${json}                    $..paymentToken.userDefined2

    Run Keyword If    '${Test_Data['paymentToken.userDefined3']}'!='empty' and '${Test_Data['paymentToken.userDefined3']}'!='None'    set to dictionary          ${json['paymentToken']}    userDefined3=${Test_Data['paymentToken.userDefined3']}
    Run Keyword If    '${Test_Data['paymentToken.userDefined3']}'=='missing'                                                          Delete Object From Json    ${json}                    $..paymentToken.userDefined3

    Run Keyword If    '${Test_Data['paymentToken.userDefined4']}'!='empty' and '${Test_Data['paymentToken.userDefined4']}'!='None'    set to dictionary          ${json['paymentToken']}    userDefined4=${Test_Data['paymentToken.userDefined4']}
    Run Keyword If    '${Test_Data['paymentToken.userDefined4']}'=='missing'                                                          Delete Object From Json    ${json}                    $..paymentToken.userDefined4

    Run Keyword If    '${Test_Data['paymentToken.userDefined5']}'!='empty' and '${Test_Data['paymentToken.userDefined5']}'!='None'    set to dictionary          ${json['paymentToken']}    userDefined5=${Test_Data['paymentToken.userDefined5']}
    Run Keyword If    '${Test_Data['paymentToken.userDefined5']}'=='missing'                                                          Delete Object From Json    ${json}                    $..paymentToken.userDefined5

    Run Keyword If    '${Test_Data['recurring']}'!='empty' and '${Test_Data['recurring']}'!='None'    set to dictionary          ${json}    recurring=${Test_Data['recurring']}
    Run Keyword If    '${Test_Data['recurring']}'=='missing'                                          Delete Object From Json    ${json}    $..recurring                           

    Run Keyword If    '${Test_Data['invoicePrefix']}'!='empty' and '${Test_Data['invoicePrefix']}'!='None'    set to dictionary          ${json}    recurringAmount=${Test_Data['recurringAmount']}
    Run Keyword If    '${Test_Data['invoicePrefix']}'=='missing'                                              Delete Object From Json    ${json}    $..recurringAmount                                 

    Run Keyword If    '${Test_Data['recurringAmount']}'!='empty' and '${Test_Data['recurringAmount']}'!='None'    set to dictionary          ${json}    recurringAmount=${Test_Data['recurringAmount']}
    Run Keyword If    '${Test_Data['recurringAmount']}'=='missing'                                                Delete Object From Json    ${json}    $..recurringAmount                                 

    Run Keyword If    '${Test_Data['allowAccumulate']}'!='empty' and '${Test_Data['allowAccumulate']}'!='None'    set to dictionary          ${json}    allowAccumulate=${Test_Data['allowAccumulate']}
    Run Keyword If    '${Test_Data['allowAccumulate']}'=='missing'                                                Delete Object From Json    ${json}    $..allowAccumulate                                 

    Run Keyword If    '${Test_Data['maxAccumulateAmount']}'!='empty' and '${Test_Data['maxAccumulateAmount']}'!='None'    set to dictionary          ${json}    invoicePrefix=${Test_Data['invoicePrefix']}
    Run Keyword If    '${Test_Data['maxAccumulateAmount']}'=='missing'                                                    Delete Object From Json    ${json}    $..invoicePrefix                               

    Run Keyword If    '${Test_Data['recurringInterval']}'!='empty' and '${Test_Data['recurringInterval']}'!='None'    set to dictionary          ${json}    recurringInterval=${Test_Data['recurringInterval']}
    Run Keyword If    '${Test_Data['recurringInterval']}'=='missing'                                                  Delete Object From Json    ${json}    $..recurringInterval                                   

    Run Keyword If    '${Test_Data['recurringCount']}'!='empty' and '${Test_Data['recurringCount']}'!='None'    set to dictionary          ${json}    recurringCount=${Test_Data['recurringCount']}
    Run Keyword If    '${Test_Data['recurringCount']}'=='missing'                                               Delete Object From Json    ${json}    $..recurringCount                                

    Run Keyword If    '${Test_Data['chargeNextDate']}'!='empty' and '${Test_Data['chargeNextDate']}'!='None'    set to dictionary          ${json}    chargeNextDate=${Test_Data['chargeNextDate']}
    Run Keyword If    '${Test_Data['chargeNextDate']}'=='missing'                                               Delete Object From Json    ${json}    $..chargeNextDate                                

    Run Keyword If    '${Test_Data['chargeOnDate']}'!='empty' and '${Test_Data['chargeOnDate']}'!='None'    set to dictionary          ${json}    chargeOnDate=${Test_Data['chargeOnDate']}
    Run Keyword If    '${Test_Data['chargeOnDate']}'=='missing'                                             Delete Object From Json    ${json}    $..chargeOnDate                              


    Log Dictionary     ${json}
    ${json_string}=    evaluate          json.dumps(${json})    json
    log many           ${json_string}
    log                ${json_string}
    [Return]           ${json_string}


Prepare_Data_For_API_Payment_Validation
    [Arguments]       ${Test_Data}       ${testcaseName}==none
    ${json_string}    Get Binary File    ${file_path_request}.json
    Log               ${json_string}
    ${json}=          evaluate           json.loads('''${json_string}''')    json

    Run Keyword If    '${Test_Data['paymentScene']}'!='empty'      set to dictionary          ${json}    paymentScene=${Test_Data['paymentScene']}
    Run Keyword If    '${Test_Data['paymentScene']}'=='missing'    Delete Object From Json    ${json}    $..paymentScene

    ## paymentToken ##
    Run Keyword If    '${Test_Data['paymentToken.merchantID']}'!='empty' and '${Test_Data['paymentToken.merchantID']}'!='None'    set to dictionary          ${json['paymentToken']}    merchantID=${Test_Data['paymentToken.merchantID']}
    Run Keyword If    '${Test_Data['paymentToken.merchantID']}'=='missing'                                                        Delete Object From Json    ${json}                    $..paymentToken.merchantID

    Run Keyword If    '${Test_Data['paymentToken.invoiceNo']}'!='empty' and '${Test_Data['paymentToken.invoiceNo']}'!='None'    set to dictionary          ${json['paymentToken']}    invoiceNo=${Test_Data['paymentToken.invoiceNo']}
    Run Keyword If    '${Test_Data['paymentToken.invoiceNo']}'=='missing'                                                       Delete Object From Json    ${json}                    $..paymentToken.invoiceNo

    Run Keyword If    '${Test_Data['paymentToken.description']}'!='empty' and '${Test_Data['paymentToken.description']}'!='None'    set to dictionary          ${json['paymentToken']}    description=${Test_Data['paymentToken.description']}
    Run Keyword If    '${Test_Data['paymentToken.description']}'=='missing'                                                         Delete Object From Json    ${json}                    $..paymentToken.description

    Run Keyword If    '${Test_Data['paymentToken.amount']}'!='empty' and '${Test_Data['paymentToken.amount']}'!='None'    set to dictionary          ${json['paymentToken']}    amount=${Test_Data['paymentToken.amount']}
    Run Keyword If    '${Test_Data['paymentToken.amount']}'=='missing'                                                    Delete Object From Json    ${json}                    $..paymentToken.amount

    Run Keyword If    '${Test_Data['paymentToken.currencyCode']}'!='empty' and '${Test_Data['paymentToken.currencyCode']}'!='None'    set to dictionary          ${json['paymentToken']}    currencyCode=${Test_Data['paymentToken.currencyCode']}
    Run Keyword If    '${Test_Data['paymentToken.currencyCode']}'=='missing'                                                          Delete Object From Json    ${json}                    $..paymentToken.currencyCode

    Run Keyword If    '${Test_Data['paymentToken.paymentChannel']}'!='empty' and '${Test_Data['paymentToken.paymentChannel']}'!='None'    set to dictionary          ${json['paymentToken']}    paymentChannel=${Test_Data['paymentToken.paymentChannel']}
    Run Keyword If    '${Test_Data['paymentToken.paymentChannel']}'=='missing'                                                            Delete Object From Json    ${json}                    $..paymentToken.paymentChannel

    Run Keyword If    '${Test_Data['paymentToken.request3DS']}'!='empty' and '${Test_Data['paymentToken.request3DS']}'!='None'    set to dictionary          ${json['paymentToken']}    request3DS=${Test_Data['paymentToken.request3DS']}
    Run Keyword If    '${Test_Data['paymentToken.request3DS']}'=='missing'                                                        Delete Object From Json    ${json}                    $..paymentToken.request3DS

    Run Keyword If    '${Test_Data['paymentToken.recurring']}'!='empty' and '${Test_Data['paymentToken.recurring']}'!='None'    set to dictionary          ${json['paymentToken']}    recurring=${Test_Data['paymentToken.recurring']}
    Run Keyword If    '${Test_Data['paymentToken.recurring']}'=='missing'                                                       Delete Object From Json    ${json}                    $..paymentToken.recurring

    Run Keyword If    '${Test_Data['paymentToken.invoicePrefix']}'!='empty' and '${Test_Data['paymentToken.invoicePrefix']}'!='None'    set to dictionary          ${json['paymentToken']}    invoicePrefix=${Test_Data['paymentToken.invoicePrefix']}
    Run Keyword If    '${Test_Data['paymentToken.invoicePrefix']}'=='missing'                                                           Delete Object From Json    ${json}                    $..paymentToken.invoicePrefix

    Run Keyword If    '${Test_Data['paymentToken.recurringAmount']}'!='empty' and '${Test_Data['paymentToken.recurringAmount']}'!='None'    set to dictionary          ${json['paymentToken']}    recurringAmount=${Test_Data['paymentToken.recurringAmount']}
    Run Keyword If    '${Test_Data['paymentToken.recurringAmount']}'=='missing'                                                             Delete Object From Json    ${json}                    $..paymentToken.recurringAmount

    Run Keyword If    '${Test_Data['paymentToken.allowAccumulate']}'!='empty' and '${Test_Data['paymentToken.allowAccumulate']}'!='None'    set to dictionary          ${json['paymentToken']}    allowAccumulate=${Test_Data['paymentToken.allowAccumulate']}
    Run Keyword If    '${Test_Data['paymentToken.allowAccumulate']}'=='missing'                                                             Delete Object From Json    ${json}                    $..paymentToken.allowAccumulate

    Run Keyword If    '${Test_Data['paymentToken.maxAccumulateAmount']}'!='empty' and '${Test_Data['paymentToken.maxAccumulateAmount']}'!='None'    set to dictionary          ${json['paymentToken']}    maxAccumulateAmount=${Test_Data['paymentToken.maxAccumulateAmount']}
    Run Keyword If    '${Test_Data['paymentToken.maxAccumulateAmount']}'=='missing'                                                                 Delete Object From Json    ${json}                    $..paymentToken.maxAccumulateAmount

    Run Keyword If    '${Test_Data['paymentToken.recurringCount']}'!='empty' and '${Test_Data['paymentToken.recurringCount']}'!='None'    set to dictionary          ${json['paymentToken']}    recurringCount=${Test_Data['paymentToken.recurringCount']}
    Run Keyword If    '${Test_Data['paymentToken.recurringCount']}'=='missing'                                                            Delete Object From Json    ${json}                    $..paymentToken.recurringCount

    Run Keyword If    '${Test_Data['paymentToken.chargeNextDate']}'!='empty' and '${Test_Data['paymentToken.chargeNextDate']}'!='None'    set to dictionary          ${json['paymentToken']}    chargeNextDate=${Test_Data['paymentToken.chargeNextDate']}
    Run Keyword If    '${Test_Data['paymentToken.chargeNextDate']}'=='missing'                                                            Delete Object From Json    ${json}                    $..paymentToken.chargeNextDate

    Run Keyword If    '${Test_Data['paymentToken.chargeNextDate']}'!='empty' and '${Test_Data['paymentToken.chargeNextDate']}'!='None'    set to dictionary          ${json['paymentToken']}    chargeNextDate=${Test_Data['paymentToken.chargeNextDate']}
    Run Keyword If    '${Test_Data['paymentToken.chargeNextDate']}'=='missing'                                                            Delete Object From Json    ${json}                    $..paymentToken.chargeNextDate

    Run Keyword If    '${Test_Data['paymentOption.locale']}'!='empty' and '${Test_Data['paymentOption.locale']}'!='None'    set to dictionary          ${json['doPayment']['payment']['code']}    locale=${Test_Data['paymentOption.locale']}
    Run Keyword If    '${Test_Data['paymentOption.locale']}'=='missing'                                                     Delete Object From Json    ${json}                                    $..paymentOption.locale

    Run Keyword If    '${Test_Data['doPayment.payment.code.channelCode']}'!='empty' and '${Test_Data['doPayment.payment.code.channelCode']}'!='None'    set to dictionary          ${json['doPayment']['payment']['code']}    channelCode=${Test_Data['doPayment.payment.code.channelCode']}
    Run Keyword If    '${Test_Data['doPayment.payment.code.channelCode']}'=='missing'                                                                   Delete Object From Json    ${json}                                    $..doPayment.payment.code

    Run Keyword If    '${Test_Data['doPayment.payment.data.name']}'!='empty' and '${Test_Data['doPayment.payment.data.name']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    name=${Test_Data['doPayment.payment.data.name']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.name']}'=='missing'                                                            Delete Object From Json    ${json}                                    $..doPayment.payment.data.name

    Run Keyword If    '${Test_Data['doPayment.payment.data.email']}'!='empty' and '${Test_Data['doPayment.payment.data.email']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    email=${Test_Data['doPayment.payment.data.email']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.email']}'=='missing'                                                             Delete Object From Json    ${json}                                    $..doPayment.payment.email

    Run Keyword If    '${Test_Data['doPayment.payment.data.billingAddress1']}'!='empty' and '${Test_Data['doPayment.payment.data.billingAddress1']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    billingAddress1=${Test_Data['doPayment.payment.data.billingAddress1']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.billingAddress1']}'=='missing'                                                                       Delete Object From Json    ${json}                                    $..doPayment.payment.data.billingAddress1

    Run Keyword If    '${Test_Data['doPayment.payment.data.billingAddress2']}'!='empty' and '${Test_Data['doPayment.payment.data.billingAddress2']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    billingAddress2=${Test_Data['doPayment.payment.data.billingAddress2']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.billingAddress2']}'=='missing'                                                                       Delete Object From Json    ${json}                                    $..doPayment.payment.data.billingAddress2

    Run Keyword If    '${Test_Data['doPayment.payment.data.billingAddress3']}'!='empty' and '${Test_Data['doPayment.payment.data.billingAddress3']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    billingAddress3=${Test_Data['doPayment.payment.data.billingAddress3']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.billingAddress3']}'=='missing'                                                                       Delete Object From Json    ${json}                                    $..doPayment.payment.data.billingAddress3

    Run Keyword If    '${Test_Data['doPayment.payment.data.billingCity']}'!='empty' and '${Test_Data['doPayment.payment.data.billingCity']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    billingCity=${Test_Data['doPayment.payment.data.billingCity']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.billingCity']}'=='missing'                                                                   Delete Object From Json    ${json}                                    $..doPayment.payment.data.billingCity

    Run Keyword If    '${Test_Data['doPayment.payment.data.billingState']}'!='empty' and '${Test_Data['doPayment.payment.data.billingState']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    billingState=${Test_Data['doPayment.payment.data.billingState']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.billingState']}'=='missing'                                                                    Delete Object From Json    ${json}                                    $..doPayment.payment.data.billingState

    Run Keyword If    '${Test_Data['doPayment.payment.data.billingPostalCode']}'!='empty' and '${Test_Data['doPayment.payment.data.billingPostalCode']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    billingPostalCode=${Test_Data['doPayment.payment.data.billingPostalCode']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.billingPostalCode']}'=='missing'                                                                         Delete Object From Json    ${json}                                    $..doPayment.payment.data.billingPostalCode

    Run Keyword If    '${Test_Data['doPayment.payment.data.billingCountryCode']}'!='empty' and '${Test_Data['doPayment.payment.data.billingCountryCode']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    billingCountryCode=${Test_Data['doPayment.payment.data.billingCountryCode']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.billingCountryCode']}'=='missing'                                                                          Delete Object From Json    ${json}                                    $..doPayment.payment.data.billingCountryCode

    Run Keyword If    '${Test_Data['doPayment.payment.data.shippingAddress1']}'!='empty' and '${Test_Data['doPayment.payment.data.shippingAddress1']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    shippingAddress1=${Test_Data['doPayment.payment.data.shippingAddress1']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.shippingAddress1']}'=='missing'                                                                        Delete Object From Json    ${json}                                    $..doPayment.payment.data.billingAddress1

    Run Keyword If    '${Test_Data['doPayment.payment.data.shippingAddress2']}'!='empty' and '${Test_Data['doPayment.payment.data.shippingAddress2']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    shippingAddress2=${Test_Data['doPayment.payment.data.shippingAddress2']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.shippingAddress2']}'=='missing'                                                                        Delete Object From Json    ${json}                                    $..doPayment.payment.data.billingAddress2

    Run Keyword If    '${Test_Data['doPayment.payment.data.shippingAddress3']}'!='empty' and '${Test_Data['doPayment.payment.data.shippingAddress3']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    shippingAddress3=${Test_Data['doPayment.payment.data.shippingAddress3']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.shippingAddress3']}'=='missing'                                                                        Delete Object From Json    ${json}                                    $..doPayment.payment.data.billingAddress3

    Run Keyword If    '${Test_Data['doPayment.payment.data.shippingCity']}'!='empty' and '${Test_Data['doPayment.payment.data.shippingCity']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    shippingCity=${Test_Data['doPayment.payment.data.shippingCity']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.shippingCity']}'=='missing'                                                                    Delete Object From Json    ${json}                                    $..doPayment.payment.data.billingCity

    Run Keyword If    '${Test_Data['doPayment.payment.data.shippingState']}'!='empty' and '${Test_Data['doPayment.payment.data.shippingState']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    shippingState=${Test_Data['doPayment.payment.data.shippingState']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.shippingState']}'=='missing'                                                                     Delete Object From Json    ${json}                                    $..doPayment.payment.data.billingState

    Run Keyword If    '${Test_Data['doPayment.payment.data.shippingPostalCode']}'!='empty' and '${Test_Data['doPayment.payment.data.shippingPostalCode']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    shippingPostalCode=${Test_Data['doPayment.payment.data.shippingPostalCode']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.shippingPostalCode']}'=='missing'                                                                          Delete Object From Json    ${json}                                    $..doPayment.payment.data.billingPostalCode

    Run Keyword If    '${Test_Data['doPayment.payment.data.shippingCountryCode']}'!='empty' and '${Test_Data['doPayment.payment.data.shippingCountryCode']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    shippingCountryCode=${Test_Data['doPayment.payment.data.shippingCountryCode']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.shippingCountryCode']}'=='missing'                                                                           Delete Object From Json    ${json}                                    $..doPayment.payment.data.shippingCountryCode

    Run Keyword If    '${testcaseName}'=='APIPay1001_402'                                        Delete Object From Json    ${json}    $..paymentToken
    Run Keyword If    '${testcaseName}'=='APIPay1001_604'                                        Delete Object From Json    ${json}    $..paymentToken.description
    Run Keyword If    '${Test_Data['doPayment.payment.data.shippingCountryCode']}'=='missing'    Delete Object From Json    ${json}    $..doPayment

    Log Dictionary     ${json}
    ${json_string}=    evaluate          json.dumps(${json})    json
    log many           ${json_string}
    [Return]           ${json_string}

Prepare_Data_For_API_Inquiry
    [Arguments]       ${Test_Data}       ${testcaseName}==none
    ${json_string}    Get Binary File    ${file_path_request}.json
    Log               ${json_string}
    ${json}=          evaluate           json.loads('''${json_string}''')    json

    Run Keyword If    '${Test_Data['version']}'!='empty'      set to dictionary          ${json}    version=${Test_Data['version']}
    Run Keyword If    '${Test_Data['version']}'=='missing'    Delete Object From Json    ${json}    $..version

    Run Keyword If    '${Test_Data['processType']}'!='empty'      set to dictionary          ${json}    processType=${Test_Data['processType']}
    Run Keyword If    '${Test_Data['processType']}'=='missing'    Delete Object From Json    ${json}    $..processType

    Run Keyword If    '${Test_Data['invoiceNo']}'!='empty'      set to dictionary          ${json}    invoiceNo=${Test_Data['invoiceNo']}
    Run Keyword If    '${Test_Data['invoiceNo']}'=='missing'    Delete Object From Json    ${json}    $..invoiceNo

    Run Keyword If    '${Test_Data['merchantID']}'!='empty'      set to dictionary          ${json}    merchantID=${Test_Data['merchantID']}
    Run Keyword If    '${Test_Data['merchantID']}'=='missing'    Delete Object From Json    ${json}    $..merchantID

    Run Keyword If    '${Test_Data['actionAmount']}'!='empty'      set to dictionary          ${json}    actionAmount=${Test_Data['actionAmount']}
    Run Keyword If    '${Test_Data['actionAmount']}'=='missing'    Delete Object From Json    ${json}    $..actionAmount

    Log Dictionary     ${json}
    ${json_string}=    evaluate          json.dumps(${json})    json
    log many           ${json_string}
    [Return]           ${json_string}

Prepare_Data_For_API_Payment_Quickpay
    [Arguments]       ${Test_Data}
    ${json_string}    Get Binary File    ${file_path_request}.json
    Log               ${json_string}
    ${json}=          evaluate           json.loads('''${json_string}''')    json

    Run Keyword If    '${Test_Data['version']}'!='empty' and '${Test_Data['version']}'!='None'    set to dictionary          ${json}    version=${Test_Data['version']}
    Run Keyword If    '${Test_Data['version']}'=='missing'                                        Delete Object From Json    ${json}    $..version                         

    Run Keyword If    '${Test_Data['merchantID']}'!='empty' and '${Test_Data['merchantID']}'!='None'    set to dictionary          ${json}    merchantID=${Test_Data['merchantID']}
    Run Keyword If    '${Test_Data['merchantID']}'=='missing'                                           Delete Object From Json    ${json}    $..merchantID                            

    ${invoice}        Run Keyword If                                                                          '${Test_Data['orderIdPrefix']}'=='invoiceNo'    Generate_InvoiceNo    ELSE                        Set Variable    ${Test_Data['orderIdPrefix']}    
    Run Keyword If    '${Test_Data['orderIdPrefix']}'!='empty' and '${Test_Data['orderIdPrefix']}'!='None'    set to dictionary                               ${json}               orderIdPrefix=${invoice}
    Run Keyword If    '${Test_Data['orderIdPrefix']}'=='missing'                                              Delete Object From Json                         ${json}               $..orderIdPrefix            

    Run Keyword If    '${Test_Data['description']}'!='empty' and '${Test_Data['description']}'!='None'    set to dictionary          ${json}    description=${Test_Data['description']}
    Run Keyword If    '${Test_Data['description']}'=='missing'                                            Delete Object From Json    ${json}    $..description                             

    Run Keyword If    '${Test_Data['amount']}'!='empty' and '${Test_Data['amount']}'!='None'    set to dictionary          ${json}    amount=${Test_Data['amount']}
    Run Keyword If    '${Test_Data['amount']}'=='missing'                                       Delete Object From Json    ${json}    $..amount                        

    Run Keyword If    '${Test_Data['currency']}'!='empty' and '${Test_Data['currency']}'!='None'    set to dictionary          ${json}    currency=${Test_Data['currency']}
    Run Keyword If    '${Test_Data['currency']}'=='missing'                                         Delete Object From Json    ${json}    $..currency                          

    Run Keyword If    '${Test_Data['allowMultiplePayment']}'!='empty' and '${Test_Data['allowMultiplePayment']}'!='None'    set to dictionary          ${json}    allowMultiplePayment=${Test_Data['allowMultiplePayment']}
    Run Keyword If    '${Test_Data['allowMultiplePayment']}'=='missing'                                                     Delete Object From Json    ${json}    $..allowMultiplePayment                                      

    Run Keyword If    '${Test_Data['maxTransaction']}'!='empty' and '${Test_Data['maxTransaction']}'!='None'    set to dictionary          ${json}    maxTransaction=${Test_Data['maxTransaction']}
    Run Keyword If    '${Test_Data['maxTransaction']}'=='missing'                                               Delete Object From Json    ${json}    $..maxTransaction                                

    Run Keyword If    '${Test_Data['expiry']}'=='missing'                                       Delete Object From Json                                                                                           ${json}         $..expiry
    ${dateexpiry}     Run Keyword If                                                            '${Test_Data['expiry']}'!='empty' and '${Test_Data['expiry']}'!='None' and '${Test_Data['expiry']}'!='missing'    compare_date    ${Test_Data['expiry']}
    Run Keyword If    '${Test_Data['expiry']}'!='empty' and '${Test_Data['expiry']}'!='None'    set to dictionary                                                                                                 ${json}         expiry=${dateexpiry}

    Run Keyword If    '${Test_Data['categoryId']}'!='empty' and '${Test_Data['categoryId']}'!='None'    set to dictionary          ${json}    categoryId=${Test_Data['categoryId']}
    Run Keyword If    '${Test_Data['categoryId']}'=='missing'                                           Delete Object From Json    ${json}    $..categoryId                            

    Run Keyword If    '${Test_Data['promotion']}'!='empty' and '${Test_Data['promotion']}'!='None'    set to dictionary          ${json}    promotion=${Test_Data['promotion']}
    Run Keyword If    '${Test_Data['promotion']}'=='missing'                                          Delete Object From Json    ${json}    $..promotion                           

    Run Keyword If    '${Test_Data['paymentOption']}'!='empty' and '${Test_Data['paymentOption']}'!='None'    set to dictionary          ${json}    paymentOption=${Test_Data['paymentOption']}
    Run Keyword If    '${Test_Data['paymentOption']}'=='missing'                                              Delete Object From Json    ${json}    $..paymentOption                               

    Run Keyword If    '${Test_Data['ippInterestType']}'!='empty' and '${Test_Data['ippInterestType']}'!='None'    set to dictionary          ${json}    ippInterestType=${Test_Data['ippInterestType']}
    Run Keyword If    '${Test_Data['ippInterestType']}'=='missing'                                                Delete Object From Json    ${json}    $..ippInterestType                                 

    Run Keyword If    '${Test_Data['paymentExpiry']}'!='empty' and '${Test_Data['paymentExpiry']}'!='None'    set to dictionary          ${json}    paymentExpiry=${Test_Data['paymentExpiry']}
    Run Keyword If    '${Test_Data['paymentExpiry']}'=='missing'                                              Delete Object From Json    ${json}    $..paymentExpiry                               

    Run Keyword If    '${Test_Data['request3DS']}'!='empty' and '${Test_Data['request3DS']}'!='None'    set to dictionary          ${json}    request3DS=${Test_Data['request3DS']}
    Run Keyword If    '${Test_Data['request3DS']}'=='missing'                                           Delete Object From Json    ${json}    $..request3DS                            

    Run Keyword If    '${Test_Data['enableStoreCard']}'!='empty' and '${Test_Data['enableStoreCard']}'!='None'    set to dictionary          ${json}    enableStoreCard=${Test_Data['enableStoreCard']}
    Run Keyword If    '${Test_Data['enableStoreCard']}'=='missing'                                                Delete Object From Json    ${json}    $..enableStoreCard                                 

    Run Keyword If    '${Test_Data['recurring']}'!='empty' and '${Test_Data['recurring']}'!='None'    set to dictionary          ${json}    recurring=${Test_Data['recurring']}
    Run Keyword If    '${Test_Data['recurring']}'=='missing'                                          Delete Object From Json    ${json}    $..recurring                           

    Run Keyword If    '${Test_Data['recurringAmount']}'!='empty' and '${Test_Data['recurringAmount']}'!='None'    set to dictionary          ${json}    recurringAmount=${Test_Data['recurringAmount']}
    Run Keyword If    '${Test_Data['recurringAmount']}'=='missing'                                                Delete Object From Json    ${json}    $..recurringAmount                                 

    Run Keyword If    '${Test_Data['allowAccumulate']}'!='empty' and '${Test_Data['allowAccumulate']}'!='None'    set to dictionary          ${json}    allowAccumulate=${Test_Data['allowAccumulate']}
    Run Keyword If    '${Test_Data['allowAccumulate']}'=='missing'                                                Delete Object From Json    ${json}    $..allowAccumulate                                 

    Run Keyword If    '${Test_Data['maxAccumulateAmount']}'!='empty' and '${Test_Data['maxAccumulateAmount']}'!='None'    set to dictionary          ${json}    maxAccumulateAmount=${Test_Data['maxAccumulateAmount']}
    Run Keyword If    '${Test_Data['maxAccumulateAmount']}'=='missing'                                                    Delete Object From Json    ${json}    $..maxAccumulateAmount                                     

    Run Keyword If    '${Test_Data['recurringInterval']}'!='empty' and '${Test_Data['recurringInterval']}'!='None'    set to dictionary          ${json}    recurringInterval=${Test_Data['recurringInterval']}
    Run Keyword If    '${Test_Data['recurringInterval']}'=='missing'                                                  Delete Object From Json    ${json}    $..recurringInterval                                   

    Run Keyword If    '${Test_Data['recurringCount']}'!='empty' and '${Test_Data['recurringCount']}'!='None'    set to dictionary          ${json}    recurringCount=${Test_Data['recurringCount']}
    Run Keyword If    '${Test_Data['recurringCount']}'=='missing'                                               Delete Object From Json    ${json}    $..recurringCount                                

    Run Keyword If    '${Test_Data['chargeNextDate']}'!='empty' and '${Test_Data['chargeNextDate']}'!='None'    set to dictionary          ${json}    chargeNextDate=${Test_Data['chargeNextDate']}
    Run Keyword If    '${Test_Data['chargeNextDate']}'=='missing'                                               Delete Object From Json    ${json}    $..chargeNextDate                                

    Run Keyword If    '${Test_Data['chargeOnDate']}'!='empty' and '${Test_Data['chargeOnDate']}'!='None'    set to dictionary          ${json}    chargeOnDate=${Test_Data['chargeOnDate']}
    Run Keyword If    '${Test_Data['chargeOnDate']}'=='missing'                                             Delete Object From Json    ${json}    $..chargeOnDate                              

    Run Keyword If    '${Test_Data['userData1']}'!='empty' and '${Test_Data['userData1']}'!='None'    set to dictionary          ${json}    userData1=${Test_Data['userData1']}
    Run Keyword If    '${Test_Data['userData1']}'=='missing'                                          Delete Object From Json    ${json}    $..userData1                           

    Run Keyword If    '${Test_Data['userData2']}'!='empty' and '${Test_Data['userData2']}'!='None'    set to dictionary          ${json}    userData2=${Test_Data['userData2']}
    Run Keyword If    '${Test_Data['userData2']}'=='missing'                                          Delete Object From Json    ${json}    $..userData2                           

    Run Keyword If    '${Test_Data['userData3']}'!='empty' and '${Test_Data['userData3']}'!='None'    set to dictionary          ${json}    userData3=${Test_Data['userData3']}
    Run Keyword If    '${Test_Data['userData3']}'=='missing'                                          Delete Object From Json    ${json}    $..userData3                           

    Run Keyword If    '${Test_Data['userData4']}'!='empty' and '${Test_Data['userData4']}'!='None'    set to dictionary          ${json}    userData4=${Test_Data['userData4']}
    Run Keyword If    '${Test_Data['userData4']}'=='missing'                                          Delete Object From Json    ${json}    $..userData4                           

    Run Keyword If    '${Test_Data['userData5']}'!='empty' and '${Test_Data['userData5']}'!='None'    set to dictionary          ${json}    userData5=${Test_Data['userData5']}
    Run Keyword If    '${Test_Data['userData5']}'=='missing'                                          Delete Object From Json    ${json}    $..userData5                           

    Run Keyword If    '${Test_Data['resultUrl1']}'!='empty' and '${Test_Data['resultUrl1']}'!='None'    set to dictionary          ${json}    resultUrl1=${Test_Data['resultUrl1']}
    Run Keyword If    '${Test_Data['resultUrl1']}'=='missing'                                           Delete Object From Json    ${json}    $..resultUrl1                            

    Run Keyword If    '${Test_Data['resultUrl2']}'!='empty' and '${Test_Data['resultUrl2']}'!='None'    set to dictionary          ${json}    resultUrl2=${Test_Data['resultUrl2']}
    Run Keyword If    '${Test_Data['resultUrl2']}'=='missing'                                           Delete Object From Json    ${json}    $..resultUrl2                            

    Run Keyword If    '${Test_Data['timeStamp']}'!='empty' and '${Test_Data['timeStamp']}'!='None'    set to dictionary          ${json}    timeStamp=${Test_Data['timeStamp']}
    Run Keyword If    '${Test_Data['timeStamp']}'=='missing'                                          Delete Object From Json    ${json}    $..timeStamp                           

    ## Inquiry ##
    Run Keyword If    '${Test_Data['inquiry.version']}'!='empty' and '${Test_Data['inquiry.version']}'!='None'    set to dictionary          ${json}    inquiry.version=${Test_Data['inquiry.version']}
    Run Keyword If    '${Test_Data['inquiry.version']}'=='missing'                                                Delete Object From Json    ${json}    $..inquiry.version

    Run Keyword If    '${Test_Data['inquiry.processType']}'!='empty' and '${Test_Data['inquiry.processType']}'!='None'    set to dictionary          ${json}    inquiry.processType=${Test_Data['inquiry.processType']}
    Run Keyword If    '${Test_Data['inquiry.processType']}'=='missing'                                                    Delete Object From Json    ${json}    $..inquiry.processType

    Run Keyword If    '${Test_Data['inquiry.invoiceNo']}'!='empty' and '${Test_Data['inquiry.invoiceNo']}'!='None'    set to dictionary          ${json}    inquiry.invoiceNo=${Test_Data['inquiry.invoiceNo']}
    Run Keyword If    '${Test_Data['inquiry.invoiceNo']}'=='missing'                                                  Delete Object From Json    ${json}    $..inquiry.invoiceNo

    Run Keyword If    '${Test_Data['inquiry.merchantID']}'!='empty' and '${Test_Data['inquiry.merchantID']}'!='None'    set to dictionary          ${json}    inquiry.merchantID=${Test_Data['inquiry.merchantID']}
    Run Keyword If    '${Test_Data['inquiry.merchantID']}'=='missing'                                                   Delete Object From Json    ${json}    $..inquiry.merchantID

    Run Keyword If    '${Test_Data['inquiry.actionAmount']}'!='empty' and '${Test_Data['inquiry.actionAmount']}'!='None'    set to dictionary          ${json}    inquiry.actionAmount=${Test_Data['inquiry.actionAmount']}
    Run Keyword If    '${Test_Data['inquiry.actionAmount']}'=='missing'                                                     Delete Object From Json    ${json}    $..inquiry.actionAmount

    Log Dictionary     ${json}
    ${json_string}=    evaluate          json.dumps(${json})    json
    log many           ${json_string}
    [Return]           ${json_string}

Prepare_Data_For_API_Void
    [Arguments]       ${Test_Data}       ${testcaseName}==none
    ${json_string}    Get Binary File    ${file_path_request}.json
    Log               ${json_string}
    ${json}=          evaluate           json.loads('''${json_string}''')    json

    Run Keyword If    '${Test_Data['version']}'!='empty' and '${Test_Data['version']}'!='None'    set to dictionary          ${json}    version=${Test_Data['version']}
    Run Keyword If    '${Test_Data['version']}'=='missing'                                        Delete Object From Json    ${json}    $..version

    Run Keyword If    '${Test_Data['processType']}'!='empty' and '${Test_Data['processType']}'!='None'    set to dictionary          ${json}    processType=${Test_Data['processType']}
    Run Keyword If    '${Test_Data['processType']}'=='missing'                                            Delete Object From Json    ${json}    $..processType

    Run Keyword If    '${Test_Data['invoiceNo']}'!='empty' and '${Test_Data['invoiceNo']}'!='None'    set to dictionary          ${json}    invoiceNo=${Test_Data['invoiceNo']}
    Run Keyword If    '${Test_Data['invoiceNo']}'=='missing'                                          Delete Object From Json    ${json}    $..invoiceNo

    Run Keyword If    '${Test_Data['merchantID']}'!='empty' and '${Test_Data['merchantID']}'!='None'    set to dictionary          ${json}    merchantID=${Test_Data['merchantID']}
    Run Keyword If    '${Test_Data['merchantID']}'=='missing'                                           Delete Object From Json    ${json}    $..merchantID

    Run Keyword If    '${Test_Data['actionAmount']}'!='empty' and '${Test_Data['actionAmount']}'!='None'    set to dictionary          ${json}    actionAmount=${Test_Data['actionAmount']}
    Run Keyword If    '${Test_Data['actionAmount']}'=='missing'                                             Delete Object From Json    ${json}    $..actionAmount

    Run Keyword If    '${Test_Data['subMerchantList.subMID']}'!='empty' and '${Test_Data['subMerchantList.subMID']}'!='None'    set to dictionary          ${json['subMerchantList'][0]}    subMID=${Test_Data['subMerchantList.subMID']}
    Run Keyword If    '${Test_Data['subMerchantList.subMID']}'=='missing'                                                       Delete Object From Json    ${json['subMerchantList'][0]}    $..subMID

    Run Keyword If    '${Test_Data['subMerchantList.subAmount']}'!='empty' and '${Test_Data['subMerchantList.subAmount']}'!='None'    set to dictionary          ${json['subMerchantList'][0]}    subAmount=${Test_Data['subMerchantList.subAmount']}
    Run Keyword If    '${Test_Data['subMerchantList.subAmount']}'=='missing'                                                          Delete Object From Json    ${json['subMerchantList'][0]}    $..subAmount

    Log Dictionary     ${json}
    ${json_string}=    evaluate          json.dumps(${json})    json
    log many           ${json_string}
    [Return]           ${json_string}

Prepare_Data_For_API_Payment_CardTokenization
    [Arguments]       ${Test_Data}       ${testcaseName}==none
    ${json_string}    Get Binary File    ${file_path_request}.json
    Log               ${json_string}
    ${json}=          evaluate           json.loads('''${json_string}''')    json

    Run Keyword If    '${Test_Data['version']}'!='empty' and '${Test_Data['version']}'!='None'    set to dictionary          ${json}    version=${Test_Data['version']}
    Run Keyword If    '${Test_Data['version']}'=='missing'                                        Delete Object From Json    ${json}    $..version

    Run Keyword If    '${Test_Data['merchantID']}'!='empty' and '${Test_Data['merchantID']}'!='None'    set to dictionary          ${json}    merchantID=${Test_Data['merchantID']}
    Run Keyword If    '${Test_Data['merchantID']}'=='missing'                                           Delete Object From Json    ${json}    $..merchantID

    Run Keyword If    '${Test_Data['action']}'!='empty' and '${Test_Data['action']}'!='None'    set to dictionary          ${json}    action=${Test_Data['action']}
    Run Keyword If    '${Test_Data['action']}'=='missing'                                       Delete Object From Json    ${json}    $..action

    Run Keyword If    '${Test_Data['pan']}'!='empty' and '${Test_Data['pan']}'!='None'    set to dictionary          ${json}    pan=${Test_Data['pan']}
    Run Keyword If    '${Test_Data['pan']}'=='missing'                                    Delete Object From Json    ${json}    $..pan

    Run Keyword If    '${Test_Data['panExpiry']}'!='empty' and '${Test_Data['panExpiry']}'!='None'    set to dictionary          ${json}    panExpiry=${Test_Data['panExpiry']}
    Run Keyword If    '${Test_Data['panExpiry']}'=='missing'                                          Delete Object From Json    ${json}    $..panExpiry

    Run Keyword If    '${Test_Data['panBank']}'!='empty' and '${Test_Data['panBank']}'!='None'    set to dictionary          ${json}    panBank=${Test_Data['panBank']}
    Run Keyword If    '${Test_Data['panBank']}'=='missing'                                        Delete Object From Json    ${json}    $..panBank

    Run Keyword If    '${Test_Data['panCountry']}'!='empty' and '${Test_Data['panCountry']}'!='None'    set to dictionary          ${json}    panCountry=${Test_Data['panCountry']}
    Run Keyword If    '${Test_Data['panCountry']}'=='missing'                                           Delete Object From Json    ${json}    $..panCountry

    Run Keyword If    '${Test_Data['panCurrency']}'!='empty' and '${Test_Data['panCurrency']}'!='None'    set to dictionary          ${json}    panCurrency=${Test_Data['panCurrency']}
    Run Keyword If    '${Test_Data['panCurrency']}'=='missing'                                            Delete Object From Json    ${json}    $..panCurrency

    Run Keyword If    '${Test_Data['cardHolderName']}'!='empty' and '${Test_Data['cardHolderName']}'!='None'    set to dictionary          ${json}    cardHolderName=${Test_Data['cardHolderName']}
    Run Keyword If    '${Test_Data['cardHolderName']}'=='missing'                                               Delete Object From Json    ${json}    $..cardHolderName

    Run Keyword If    '${Test_Data['cardHolderEmail']}'!='empty' and '${Test_Data['cardHolderEmail']}'!='None'    set to dictionary          ${json}    cardHolderEmail=${Test_Data['cardHolderEmail']}
    Run Keyword If    '${Test_Data['cardHolderEmail']}'=='missing'                                                Delete Object From Json    ${json}    $..cardHolderEmail

    Run Keyword If    '${Test_Data['timeStamp']}'!='empty' and '${Test_Data['timeStamp']}'!='None'    set to dictionary          ${json}    timeStamp=${Test_Data['timeStamp']}
    Run Keyword If    '${Test_Data['timeStamp']}'=='missing'                                          Delete Object From Json    ${json}    $..timeStamp

    Run Keyword If    '${Test_Data['storeCardUniqueID']}'!='empty' and '${Test_Data['storeCardUniqueID']}'!='None'    set to dictionary          ${json}    storeCardUniqueID=${Test_Data['storeCardUniqueID']}
    Run Keyword If    '${Test_Data['storeCardUniqueID']}'=='missing'                                                  Delete Object From Json    ${json}    $..storeCardUniqueID

    ## paymentToken ##
    Run Keyword If    '${Test_Data['paymentScene']}'!='empty' and '${Test_Data['paymentScene']}'!='None'    set to dictionary          ${json}    paymentScene=${Test_Data['paymentScene']}
    Run Keyword If    '${Test_Data['paymentScene']}'=='missing'                                             Delete Object From Json    ${json}    $..paymentScene                              

    Run Keyword If    '${Test_Data['paymentToken.merchantID']}'!='empty' and '${Test_Data['paymentToken.merchantID']}'!='None'    set to dictionary          ${json['paymentToken']}    merchantID=${Test_Data['paymentToken.merchantID']}
    Run Keyword If    '${Test_Data['paymentToken.merchantID']}'=='missing'                                                        Delete Object From Json    ${json}                    $..paymentToken.merchantID

    ${invoice}        Run Keyword If                                                                                            '${Test_Data['paymentToken.invoiceNo']}'=='invoiceNo'    Generate_InvoiceNo
    Run Keyword If    '${Test_Data['paymentToken.invoiceNo']}'!='empty' and '${Test_Data['paymentToken.invoiceNo']}'!='None'    set to dictionary                                        ${json['paymentToken']}    invoiceNo=${invoice}
    Run Keyword If    '${Test_Data['paymentToken.invoiceNo']}'=='missing'                                                       Delete Object From Json                                  ${json}                    $..paymentToken.invoiceNo

    Run Keyword If    '${Test_Data['paymentToken.description']}'!='empty' and '${Test_Data['paymentToken.description']}'!='None'    set to dictionary          ${json['paymentToken']}    description=${Test_Data['paymentToken.description']}
    Run Keyword If    '${Test_Data['paymentToken.description']}'=='missing'                                                         Delete Object From Json    ${json}                    $..paymentToken.description

    Run Keyword If    '${Test_Data['paymentToken.amount']}'!='empty' and '${Test_Data['paymentToken.amount']}'!='None'    set to dictionary          ${json['paymentToken']}    amount=${Test_Data['paymentToken.amount']}
    Run Keyword If    '${Test_Data['paymentToken.amount']}'=='missing'                                                    Delete Object From Json    ${json}                    $..paymentToken.amount

    Run Keyword If    '${Test_Data['paymentToken.currencyCode']}'!='empty' and '${Test_Data['paymentToken.currencyCode']}'!='None'    set to dictionary          ${json['paymentToken']}    currencyCode=${Test_Data['paymentToken.currencyCode']}
    Run Keyword If    '${Test_Data['paymentToken.currencyCode']}'=='missing'                                                          Delete Object From Json    ${json}                    $..paymentToken.currencyCode

    Run Keyword If    '${Test_Data['paymentToken.cardTokens']}'!='empty' and '${Test_Data['paymentToken.cardTokens']}'!='None'    set to dictionary          ${json['paymentToken']}    cardTokens=${Test_Data['paymentToken.cardTokens']}
    Run Keyword If    '${Test_Data['paymentToken.cardTokens']}'=='missing'                                                        Delete Object From Json    ${json}                    $..paymentToken.cardTokens

    Log Dictionary     ${json}
    ${json_string}=    evaluate          json.dumps(${json})    json
    log many           ${json_string}
    [Return]           ${json_string}

Prepare_Data_For_API_Payment_Direct
    [Arguments]       ${Test_Data}
    ${json_string}    Get Binary File    ${file_path_request}.json
    Log               ${json_string}
    ${json}=          evaluate           json.loads('''${json_string}''')    json

    Run Keyword If    '${Test_Data['paymentScene']}'!='empty'      set to dictionary          ${json}    paymentScene=${Test_Data['paymentScene']}
    Run Keyword If    '${Test_Data['paymentScene']}'=='missing'    Delete Object From Json    ${json}    $..paymentScene

    ## paymentToken ##
    Run Keyword If    '${Test_Data['paymentToken.merchantID']}'!='empty' and '${Test_Data['paymentToken.merchantID']}'!='None'    set to dictionary          ${json['paymentToken']}    merchantID=${Test_Data['paymentToken.merchantID']}
    Run Keyword If    '${Test_Data['paymentToken.merchantID']}'=='missing'                                                        Delete Object From Json    ${json}                    $..paymentToken.merchantID

    ${invoice}        Run Keyword If                                                                                            '${Test_Data['paymentToken.invoiceNo']}'=='invoiceNo'    Generate_InvoiceNo         ELSE                         Set Variable    ${Test_Data['paymentToken.invoiceNo']}
    Run Keyword If    '${Test_Data['paymentToken.invoiceNo']}'!='empty' and '${Test_Data['paymentToken.invoiceNo']}'!='None'    set to dictionary                                        ${json['paymentToken']}    invoiceNo=${invoice}
    Run Keyword If    '${Test_Data['paymentToken.invoiceNo']}'=='missing'                                                       Delete Object From Json                                  ${json}                    $..paymentToken.invoiceNo

    Run Keyword If    '${Test_Data['paymentToken.description']}'!='empty' and '${Test_Data['paymentToken.description']}'!='None'    set to dictionary          ${json['paymentToken']}    description=${Test_Data['paymentToken.description']}
    Run Keyword If    '${Test_Data['paymentToken.description']}'=='missing'                                                         Delete Object From Json    ${json}                    $..paymentToken.description

    Run Keyword If    '${Test_Data['paymentToken.amount']}'!='empty' and '${Test_Data['paymentToken.amount']}'!='None'    set to dictionary          ${json['paymentToken']}    amount=${Test_Data['paymentToken.amount']}
    Run Keyword If    '${Test_Data['paymentToken.amount']}'=='missing'                                                    Delete Object From Json    ${json}                    $..paymentToken.amount

    Run Keyword If    '${Test_Data['paymentToken.currencyCode']}'!='empty' and '${Test_Data['paymentToken.currencyCode']}'!='None'    set to dictionary          ${json['paymentToken']}    currencyCode=${Test_Data['paymentToken.currencyCode']}
    Run Keyword If    '${Test_Data['paymentToken.currencyCode']}'=='missing'                                                          Delete Object From Json    ${json}                    $..paymentToken.currencyCode

    ${paymentChannel}    Create List          
    Insert Into List     ${paymentChannel}    0    ${Test_Data['paymentToken.paymentChannel']}

    Run Keyword If    '${Test_Data['paymentToken.paymentChannel']}'!='empty' and '${Test_Data['paymentToken.paymentChannel']}'!='None'    set to dictionary          ${json['paymentToken']}    paymentChannel=${paymentChannel}
    Run Keyword If    '${Test_Data['paymentToken.paymentChannel']}'=='missing'                                                            Delete Object From Json    ${json}                    $..paymentToken.paymentChannel

    Run Keyword If    '${Test_Data['paymentToken.backendReturnUrl']}'!='empty' and '${Test_Data['paymentToken.backendReturnUrl']}'!='None'    set to dictionary          ${json['paymentToken']}    backendReturnUrl=${Test_Data['paymentToken.backendReturnUrl']}
    Run Keyword If    '${Test_Data['paymentToken.backendReturnUrl']}'=='missing'                                                              Delete Object From Json    ${json}                    $..paymentToken.backendReturnUrl

    Run Keyword If    '${Test_Data['paymentToken.userDefined1']}'!='empty' and '${Test_Data['paymentToken.userDefined1']}'!='None'    set to dictionary          ${json['paymentToken']}    userDefined1=${Test_Data['paymentToken.userDefined1']}
    Run Keyword If    '${Test_Data['paymentToken.userDefined1']}'=='missing'                                                          Delete Object From Json    ${json}                    $..paymentToken.userDefined1

    Run Keyword If    '${Test_Data['paymentToken.userDefined2']}'!='empty' and '${Test_Data['paymentToken.userDefined2']}'!='None'    set to dictionary          ${json['paymentToken']}    userDefined2=${Test_Data['paymentToken.userDefined2']}
    Run Keyword If    '${Test_Data['paymentToken.userDefined2']}'=='missing'                                                          Delete Object From Json    ${json}                    $..paymentToken.userDefined2

    Run Keyword If    '${Test_Data['paymentToken.userDefined3']}'!='empty' and '${Test_Data['paymentToken.userDefined3']}'!='None'    set to dictionary          ${json['paymentToken']}    userDefined3=${Test_Data['paymentToken.userDefined3']}
    Run Keyword If    '${Test_Data['paymentToken.userDefined3']}'=='missing'                                                          Delete Object From Json    ${json}                    $..paymentToken.userDefined3

    Run Keyword If    '${Test_Data['paymentToken.userDefined4']}'!='empty' and '${Test_Data['paymentToken.userDefined4']}'!='None'    set to dictionary          ${json['paymentToken']}    userDefined4=${Test_Data['paymentToken.userDefined4']}
    Run Keyword If    '${Test_Data['paymentToken.userDefined4']}'=='missing'                                                          Delete Object From Json    ${json}                    $..paymentToken.userDefined4

    Run Keyword If    '${Test_Data['paymentToken.userDefined5']}'!='empty' and '${Test_Data['paymentToken.userDefined5']}'!='None'    set to dictionary          ${json['paymentToken']}    userDefined5=${Test_Data['paymentToken.userDefined5']}
    Run Keyword If    '${Test_Data['paymentToken.userDefined5']}'=='missing'                                                          Delete Object From Json    ${json}                    $..paymentToken.userDefined5

    Run Keyword If    '${Test_Data['paymentToken.cardTokens']}'!='empty' and '${Test_Data['paymentToken.cardTokens']}'!='None'    set to dictionary          ${json['paymentToken']}    cardTokens=${Test_Data['paymentToken.cardTokens']}
    Run Keyword If    '${Test_Data['paymentToken.cardTokens']}'=='missing'                                                        Delete Object From Json    ${json}                    $..paymentToken.cardTokens

    Run Keyword If    '${Test_Data['paymentOption.locale']}'!='empty' and '${Test_Data['paymentOption.locale']}'!='None'    set to dictionary          ${json['paymentOption']}    locale=${Test_Data['paymentOption.locale']}
    Run Keyword If    '${Test_Data['paymentOption.locale']}'=='missing'                                                     Delete Object From Json    ${json}                     $..paymentOption

    Run Keyword If    '${Test_Data['doPayment.responseReturnUrl']}'!='empty' and '${Test_Data['doPayment.responseReturnUrl']}'!='None'    set to dictionary          ${json['doPayment']}    responseReturnUrl=${Test_Data['doPayment.responseReturnUrl']}
    Run Keyword If    '${Test_Data['doPayment.responseReturnUrl']}'=='missing'                                                            Delete Object From Json    ${json}                 $..doPayment.responseReturnUrl

    Run Keyword If    '${Test_Data['doPayment.payment.code.channelCode']}'!='empty' and '${Test_Data['doPayment.payment.code.channelCode']}'!='None'    set to dictionary          ${json['doPayment']['payment']['code']}    channelCode=${Test_Data['doPayment.payment.code.channelCode']}
    Run Keyword If    '${Test_Data['doPayment.payment.code.channelCode']}'=='missing'                                                                   Delete Object From Json    ${json}                                    $..doPayment.payment.code

    Run Keyword If    '${Test_Data['doPayment.payment.data.name']}'!='empty' and '${Test_Data['doPayment.payment.data.name']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    name=${Test_Data['doPayment.payment.data.name']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.name']}'=='missing'                                                            Delete Object From Json    ${json}                                    $..doPayment.payment.data.name

    Run Keyword If    '${Test_Data['doPayment.payment.data.email']}'!='empty' and '${Test_Data['doPayment.payment.data.email']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    email=${Test_Data['doPayment.payment.data.email']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.email']}'=='missing'                                                             Delete Object From Json    ${json}                                    $..doPayment.payment.email

    Run Keyword If    '${Test_Data['doPayment.payment.data.billingAddress1']}'!='empty' and '${Test_Data['doPayment.payment.data.billingAddress1']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    billingAddress1=${Test_Data['doPayment.payment.data.billingAddress1']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.billingAddress1']}'=='missing'                                                                       Delete Object From Json    ${json}                                    $..doPayment.payment.data.billingAddress1

    Run Keyword If    '${Test_Data['doPayment.payment.data.billingAddress2']}'!='empty' and '${Test_Data['doPayment.payment.data.billingAddress2']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    billingAddress2=${Test_Data['doPayment.payment.data.billingAddress2']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.billingAddress2']}'=='missing'                                                                       Delete Object From Json    ${json}                                    $..doPayment.payment.data.billingAddress2

    Run Keyword If    '${Test_Data['doPayment.payment.data.billingAddress3']}'!='empty' and '${Test_Data['doPayment.payment.data.billingAddress3']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    billingAddress3=${Test_Data['doPayment.payment.data.billingAddress3']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.billingAddress3']}'=='missing'                                                                       Delete Object From Json    ${json}                                    $..doPayment.payment.data.billingAddress3

    Run Keyword If    '${Test_Data['doPayment.payment.data.billingCity']}'!='empty' and '${Test_Data['doPayment.payment.data.billingCity']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    billingCity=${Test_Data['doPayment.payment.data.billingCity']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.billingCity']}'=='missing'                                                                   Delete Object From Json    ${json}                                    $..doPayment.payment.data.billingCity

    Run Keyword If    '${Test_Data['doPayment.payment.data.billingState']}'!='empty' and '${Test_Data['doPayment.payment.data.billingState']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    billingState=${Test_Data['doPayment.payment.data.billingState']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.billingState']}'=='missing'                                                                    Delete Object From Json    ${json}                                    $..doPayment.payment.data.billingState

    Run Keyword If    '${Test_Data['doPayment.payment.data.billingPostalCode']}'!='empty' and '${Test_Data['doPayment.payment.data.billingPostalCode']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    billingPostalCode=${Test_Data['doPayment.payment.data.billingPostalCode']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.billingPostalCode']}'=='missing'                                                                         Delete Object From Json    ${json}                                    $..doPayment.payment.data.billingPostalCode

    Run Keyword If    '${Test_Data['doPayment.payment.data.billingCountryCode']}'!='empty' and '${Test_Data['doPayment.payment.data.billingCountryCode']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    billingCountryCode=${Test_Data['doPayment.payment.data.billingCountryCode']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.billingCountryCode']}'=='missing'                                                                          Delete Object From Json    ${json}                                    $..doPayment.payment.data.billingCountryCode

    Run Keyword If    '${Test_Data['doPayment.payment.data.shippingAddress1']}'!='empty' and '${Test_Data['doPayment.payment.data.shippingAddress1']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    shippingAddress1=${Test_Data['doPayment.payment.data.shippingAddress1']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.shippingAddress1']}'=='missing'                                                                        Delete Object From Json    ${json}                                    $..doPayment.payment.data.billingAddress1

    Run Keyword If    '${Test_Data['doPayment.payment.data.shippingAddress2']}'!='empty' and '${Test_Data['doPayment.payment.data.shippingAddress2']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    shippingAddress2=${Test_Data['doPayment.payment.data.shippingAddress2']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.shippingAddress2']}'=='missing'                                                                        Delete Object From Json    ${json}                                    $..doPayment.payment.data.billingAddress2

    Run Keyword If    '${Test_Data['doPayment.payment.data.shippingAddress3']}'!='empty' and '${Test_Data['doPayment.payment.data.shippingAddress3']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    shippingAddress3=${Test_Data['doPayment.payment.data.shippingAddress3']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.shippingAddress3']}'=='missing'                                                                        Delete Object From Json    ${json}                                    $..doPayment.payment.data.billingAddress3

    Run Keyword If    '${Test_Data['doPayment.payment.data.shippingCity']}'!='empty' and '${Test_Data['doPayment.payment.data.shippingCity']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    shippingCity=${Test_Data['doPayment.payment.data.shippingCity']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.shippingCity']}'=='missing'                                                                    Delete Object From Json    ${json}                                    $..doPayment.payment.data.billingCity

    Run Keyword If    '${Test_Data['doPayment.payment.data.shippingState']}'!='empty' and '${Test_Data['doPayment.payment.data.shippingState']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    shippingState=${Test_Data['doPayment.payment.data.shippingState']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.shippingState']}'=='missing'                                                                     Delete Object From Json    ${json}                                    $..doPayment.payment.data.billingState

    Run Keyword If    '${Test_Data['doPayment.payment.data.shippingPostalCode']}'!='empty' and '${Test_Data['doPayment.payment.data.shippingPostalCode']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    shippingPostalCode=${Test_Data['doPayment.payment.data.shippingPostalCode']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.shippingPostalCode']}'=='missing'                                                                          Delete Object From Json    ${json}                                    $..doPayment.payment.data.billingPostalCode

    Run Keyword If    '${Test_Data['doPayment.payment.data.shippingCountryCode']}'!='empty' and '${Test_Data['doPayment.payment.data.shippingCountryCode']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    shippingCountryCode=${Test_Data['doPayment.payment.data.shippingCountryCode']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.shippingCountryCode']}'=='missing'                                                                           Delete Object From Json    ${json}                                    $..doPayment.payment.data.shippingCountryCode

    Run Keyword If    '${Test_Data['doPayment.payment.data.installmentPeriod']}'!='empty' and '${Test_Data['doPayment.payment.data.installmentPeriod']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    installmentPeriod=${Test_Data['doPayment.payment.data.installmentPeriod']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.installmentPeriod']}'=='missing'                                                                         Delete Object From Json    ${json}                                    $..doPayment.payment.data.installmentPeriod

    Run Keyword If    '${Test_Data['doPayment.payment.data.interestType']}'!='empty' and '${Test_Data['doPayment.payment.data.interestType']}'!='None'    set to dictionary          ${json['doPayment']['payment']['data']}    interestType=${Test_Data['doPayment.payment.data.interestType']}
    Run Keyword If    '${Test_Data['doPayment.payment.data.interestType']}'=='missing'                                                                    Delete Object From Json    ${json}                                    $..doPayment.payment.data.interestType

    Run Keyword If    '${Test_Data['paymentToken.recurring']}'!='empty' and '${Test_Data['paymentToken.recurring']}'!='None'    set to dictionary          ${json['paymentToken']}    recurring=${Test_Data['paymentToken.recurring']}
    Run Keyword If    '${Test_Data['paymentToken.recurring']}'=='missing'                                                       Delete Object From Json    ${json}                    $..recurring                                        

    Run Keyword If    '${Test_Data['paymentToken.recurringAmount']}'!='empty' and '${Test_Data['paymentToken.recurringAmount']}'!='None'    set to dictionary          ${json['paymentToken']}    recurringAmount=${Test_Data['paymentToken.recurringAmount']}
    Run Keyword If    '${Test_Data['paymentToken.recurringAmount']}'=='missing'                                                             Delete Object From Json    ${json}                    $..recurringAmount                                              

    Run Keyword If    '${Test_Data['paymentToken.invoicePrefix']}'!='empty' and '${Test_Data['paymentToken.invoicePrefix']}'!='None'    set to dictionary          ${json['paymentToken']}    invoicePrefix=${Test_Data['paymentToken.invoicePrefix']}
    Run Keyword If    '${Test_Data['paymentToken.invoicePrefix']}'=='missing'                                                           Delete Object From Json    ${json}                    $..invoicePrefix                                            

    Run Keyword If    '${Test_Data['paymentToken.allowAccumulate']}'!='empty' and '${Test_Data['paymentToken.allowAccumulate']}'!='None'    set to dictionary          ${json['paymentToken']}    allowAccumulate=${Test_Data['paymentToken.allowAccumulate']}
    Run Keyword If    '${Test_Data['paymentToken.allowAccumulate']}'=='missing'                                                             Delete Object From Json    ${json}                    $..allowAccumulate                                              

    Run Keyword If    '${Test_Data['paymentToken.maxAccumulateAmount']}'!='empty' and '${Test_Data['paymentToken.maxAccumulateAmount']}'!='None'    set to dictionary          ${json['paymentToken']}    maxAccumulateAmount=${Test_Data['paymentToken.maxAccumulateAmount']}
    Run Keyword If    '${Test_Data['paymentToken.maxAccumulateAmount']}'=='missing'                                                                 Delete Object From Json    ${json}                    $..maxAccumulateAmount                                                  

    Run Keyword If    '${Test_Data['paymentToken.recurringInterval']}'!='empty' and '${Test_Data['paymentToken.recurringInterval']}'!='None'    set to dictionary          ${json['paymentToken']}    recurringInterval=${Test_Data['paymentToken.recurringInterval']}
    Run Keyword If    '${Test_Data['paymentToken.recurringInterval']}'=='missing'                                                               Delete Object From Json    ${json}                    $..recurringInterval                                                

    Run Keyword If    '${Test_Data['paymentToken.recurringCount']}'!='empty' and '${Test_Data['paymentToken.recurringCount']}'!='None'    set to dictionary          ${json['paymentToken']}    recurringCount=${Test_Data['paymentToken.recurringCount']}
    Run Keyword If    '${Test_Data['paymentToken.recurringCount']}'=='missing'                                                            Delete Object From Json    ${json}                    $..recurringCount                                             

    Run Keyword If    '${Test_Data['paymentToken.chargeNextDate']}'!='empty' and '${Test_Data['paymentToken.chargeNextDate']}'!='None'    set to dictionary          ${json['paymentToken']}    chargeNextDate=${Test_Data['paymentToken.chargeNextDate']}
    Run Keyword If    '${Test_Data['paymentToken.chargeNextDate']}'=='missing'                                                            Delete Object From Json    ${json}                    $..chargeNextDate                                             

    Run Keyword If    '${Test_Data['paymentToken.chargeOnDate']}'!='empty' and '${Test_Data['paymentToken.chargeOnDate']}'!='None'    set to dictionary          ${json['paymentToken']}    ChargeOnDate=${Test_Data['paymentToken.chargeOnDate']}
    Run Keyword If    '${Test_Data['paymentToken.chargeOnDate']}'=='missing'                                                          Delete Object From Json    ${json}                    $..ChargeOnDate                                           

    Log Dictionary     ${json}
    ${json_string}=    evaluate          json.dumps(${json})    json
    log many           ${json_string}
    [Return]           ${json_string}