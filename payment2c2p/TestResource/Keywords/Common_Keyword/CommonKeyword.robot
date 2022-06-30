*** Settings ***
Resource    ../AllKeywords.txt

*** Keywords ***
Prepare_Date_To_Data_Test
    [Arguments]          ${date_data}
    Set Test Variable    ${date_data}      ${date_data}
    ${date}              Run Keyword If    '${date_data}'=='currentDate'        Get Current Date    result_format=%Y-%m-%d
    ...                  ELSE IF           '${date_data}'=='currentDate-4'      Minus_Date          4
    ...                  ELSE IF           '${date_data}'=='currentDate-3'      Minus_Date          3
    ...                  ELSE IF           '${date_data}'=='currentDate+1'      Add Date            1
    ...                  ELSE IF           '${date_data}'=='currentDate+180'    Add Date            180
    ...                  ELSE IF           '${date_data}'=='currentDate+181'    Add Date            181
    ...                  ELSE IF           '${date_data}'=='currentDate+7'      Add Date            7
    ...                  ELSE IF           '${date_data}'=='currentDate+30'     Add Date            60
    ...                  ELSE IF           '${date_data}'=='currentDate+365'    Add Date            365
    Set Test Variable    ${date}           ${date}

Add_Date
    [Arguments]       ${numberCount}
    ${currentdate}    Get Current Date    result_format=%Y-%m-%d
    ${date}           Add Time To Date    ${currentdate}            ${numberCount} days    date_format=%Y-%m-%d    result_format=%Y-%m-%d
    log               ${date}
    [Return]          ${date}

Minus_Date
    [Arguments]       ${numberCount}
    ${currentdate}    Get Current Date           result_format=%Y-%m-%d
    ${date}           Subtract Time From Date    ${currentdate}            ${numberCount} days    date_format=%Y-%m-%d    result_format=%Y-%m-%d
    log               ${date}
    [Return]          ${date}