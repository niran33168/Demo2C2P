*** Settings ***
Resource    ../AllKeywords.txt

*** Keywords ***
Generate_Token
    create session                bearer_session         ${endpoint}                         verify=True
    &{headers}=                   create dictionary      Content-Type=application/json       sourceTransID=${sourceTransID}    clientId=${clientId['${ENV}']}    clientSecret=${clientSecret['${ENV}']}    requestTime=${requestTime}    languagePreference=${languagePreference}    grantType=${grantType}    userName=${userName}    passWord=${passWord}    scope=${scope}
    ${resp}=                      POST On Session        bearer_session                      ${request_uri}                    headers=${headers}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${accessToken}=               evaluate               $resp.json().get("access_token")
    Set Test Variable             ${token}               Bearer ${accessToken}
    Log                           ${token}

Generate_File_Path_Request
    [Arguments]              ${path_request}
    [Documentation]          - สร้าง path สำหรับไฟล์ request เพื่อให้ใช้ได้ทุกๆเครื่อง
    ${NEWDIR}=               Remove String                                                ${CURDIR}         ${/}Keywords${/}API_Keyword
    ${file_path_request}=    Catenate                                                     SEPARATOR=${/}    ${NEWDIR}${/}DataTest${/}${path_request}
    Set Suite Variable       ${path_request}
    Set Suite Variable       ${file_path_request}

Verify_Expected
    ${status} =   Run Keyword And Return Status         Should Contain     ${actual}     ${expected}
    Set Test Variable    ${status}     ${status}