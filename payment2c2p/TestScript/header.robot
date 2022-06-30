*** Settings ***
Resource    ../TestResource/Keywords/AllKeywords.txt

*** Test Cases ***
Validate parameter header Mandatory : Payment
    [Tags]        format
    [Setup]       Run Keywords          Generate_File_Path_Request    ${JSON_HEADER}
    ...           AND                   Set Test Variable             ${SHEET_NAME}      ${SHEET_HEADER}
    ...           AND                   Set Test Variable             ${EXCEL_NAME}      ${EXCEL_2C2P_PAYMENT}
    ...           AND                   Set Test Variable             ${URL_API}         ${API_PAYMENT_REDIRECT['${ENV}']}
    ...           AND                   Set Test Variable             ${json_request}    ${file_path_request}
    [Template]    Verify_Header_Post
   #rowNo        testcaseNo            parameter                     missing_empty_invalid    statusCode                           invalidValue
    2             HD1001_400            Content-Type                  missing            415
    3             HD1001_401            clientId                      missing            401
    4             HD1001_402            clientSecret                  missing            401
    5             HD1001_403            sourceTransID                 missing            400
    6             HD1001_404            requestTime                   missing            400
    7             HD1001_405            partnerCode                   missing            400
    8             HD1001_406            transactionChannel            missing            400
    9             HD1001_407            languagepreference            missing            415
    10            HD1001_600            Content-Type                  empty              415
    11            HD1001_601            clientId                      empty              401
    12            HD1001_602            clientSecret                  empty              401
    13            HD1001_603            sourceTransID                 empty              400
    14            HD1001_604            requestTime                   empty              400
    15            HD1001_605            partnerCode                   empty              400
    16            HD1001_606            transactionChannel            empty              400
    17            HD1001_607            languagepreference            empty              400
    18            HD1001_600            Content-Type                  invalid            415                                  @3124
    19            HD1001_601            clientId                      invalid            401                                  @3124
    20            HD1001_602            clientSecret                  invalid            401                                  @3124
    21            HD1001_603            sourceTransID                 invalid            415                                  @3124
    22            HD1001_604            requestTime                   invalid            400                                  2021/09/02
    23            HD1001_605            languagePreference            invalid            400                                  thai

Validate parameter header Mandatory : Status Inquiry
    [Tags]        format
    [Setup]       Run Keywords          Generate_File_Path_Request    ${JSON_HEADER}
    ...           AND                   Set Test Variable             ${SHEET_NAME}      ${SHEET_HEADER}
    ...           AND                   Set Test Variable             ${EXCEL_NAME}      ${EXCEL_2C2P_PAYMENT}
    ...           AND                   Set Test Variable             ${URL_API}         ${API_INQUIRY['${ENV}']}
    ...           AND                   Set Test Variable             ${json_request}    ${file_path_request}
    [Template]    Verify_Header_Post
   #rowNo        testcaseNo            parameter                     missing_empty_invalid    statusCode                  invalidValue
    25            HD1001_400            Content-Type                  missing            415
    26            HD1001_401            clientId                      missing            401
    27            HD1001_402            clientSecret                  missing            401
    28            HD1001_403            sourceTransID                 missing            400
    29            HD1001_404            requestTime                   missing            400
    30            HD1001_405            partnerCode                   missing            400
    31            HD1001_406            transactionChannel            missing            400
    32            HD1001_407            languagepreference            missing            415
    33            HD1001_600            Content-Type                  empty              415
    34            HD1001_601            clientId                      empty              401
    35            HD1001_602            clientSecret                  empty              401
    36            HD1001_603            sourceTransID                 empty              400
    37            HD1001_604            requestTime                   empty              400
    38            HD1001_605            partnerCode                   empty              400
    39            HD1001_606            transactionChannel            empty              400
    40            HD1001_607            languagepreference            empty              400
    41            HD1001_600            Content-Type                  invalid            415                         @3124
    42            HD1001_601            clientId                      invalid            401                         @3124
    43            HD1001_602            clientSecret                  invalid            401                         @3124
    44            HD1001_603            sourceTransID                 invalid            415                         @3124
    45            HD1001_604            requestTime                   invalid            400                         2021/09/02
    46            HD1001_605            languagePreference            invalid            400                         thai

Validate parameter header Mandatory : Status Void
    [Tags]        format
    [Setup]       Run Keywords          Generate_File_Path_Request    ${JSON_HEADER}
    ...           AND                   Set Test Variable             ${SHEET_NAME}      ${SHEET_HEADER}
    ...           AND                   Set Test Variable             ${EXCEL_NAME}      ${EXCEL_2C2P_PAYMENT}
    ...           AND                   Set Test Variable             ${URL_API}         ${API_INQUIRY['${ENV}']}
    ...           AND                   Set Test Variable             ${json_request}    ${file_path_request}
    [Template]    Verify_Header_Post
   #rowNo        testcaseNo            parameter                     missing_empty_invalid    statusCode                  invalidValue
    48            HD1001_400            Content-Type                  missing            415
    49            HD1001_401            clientId                      missing            401
    50            HD1001_402            clientSecret                  missing            401
    51            HD1001_403            sourceTransID                 missing            400
    52            HD1001_404            requestTime                   missing            400
    53            HD1001_405            partnerCode                   missing            400
    54            HD1001_406            transactionChannel            missing            400
    55            HD1001_407            languagepreference            missing            415
    56            HD1001_600            Content-Type                  empty              415
    57            HD1001_601            clientId                      empty              401
    58            HD1001_602            clientSecret                  empty              401
    59            HD1001_603            sourceTransID                 empty              400
    60            HD1001_604            requestTime                   empty              400
    61            HD1001_605            partnerCode                   empty              400
    62            HD1001_606            transactionChannel            empty              400
    63            HD1001_607            languagepreference            empty              400
    64            HD1001_600            Content-Type                  invalid            415                         @3124
    65            HD1001_601            clientId                      invalid            401                         @3124
    66            HD1001_602            clientSecret                  invalid            401                         @3124
    67            HD1001_603            sourceTransID                 invalid            415                         @3124
    68            HD1001_604            requestTime                   invalid            400                         2021/09/02
    69            HD1001_605            languagePreference            invalid            400                         thai

Validate parameter header Mandatory : Quick Pay
    [Tags]        format
    [Setup]       Run Keywords          Generate_File_Path_Request    ${JSON_HEADER}
    ...           AND                   Set Test Variable             ${SHEET_NAME}      ${SHEET_HEADER}
    ...           AND                   Set Test Variable             ${EXCEL_NAME}      ${EXCEL_2C2P_PAYMENT}
    ...           AND                   Set Test Variable             ${URL_API}         ${API_INQUIRY['${ENV}']}
    ...           AND                   Set Test Variable             ${json_request}    ${file_path_request}
    [Template]    Verify_Header_Post
    #rowNo         testcaseNo            parameter                     missing_empty_invalid    statusCode                           invalidValue
    71            HD1001_400            Content-Type                  missing            415
    72            HD1001_401            clientId                      missing            401
    73            HD1001_402            clientSecret                  missing            401
    74            HD1001_403            sourceTransID                 missing            400
    75            HD1001_404            requestTime                   missing            400
    76            HD1001_405            partnerCode                   missing            400
    77            HD1001_406            transactionChannel            missing            400
    78            HD1001_407            languagepreference            missing            415
    79            HD1001_600            Content-Type                  empty              415
    80            HD1001_601            clientId                      empty              401
    81            HD1001_602            clientSecret                  empty              401
    82            HD1001_603            sourceTransID                 empty              400
    83            HD1001_604            requestTime                   empty              400
    84            HD1001_605            partnerCode                   empty              400
    85            HD1001_606            transactionChannel            empty              400
    86            HD1001_607            languagepreference            empty              400
    87            HD1001_600            Content-Type                  invalid            415                         @3124
    88            HD1001_601            clientId                      invalid            401                         @3124
    89            HD1001_602            clientSecret                  invalid            401                         @3124
    90            HD1001_603            sourceTransID                 invalid            415                         @3124
    91            HD1001_604            requestTime                   invalid            400                         2021/09/02
    92            HD1001_605            languagePreference            invalid            400                         thai

Validate parameter header Mandatory : CARD TOKENIZATION
    [Tags]        format
    [Setup]       Run Keywords          Generate_File_Path_Request    ${JSON_HEADER}
    ...           AND                   Set Test Variable             ${SHEET_NAME}      ${SHEET_HEADER}
    ...           AND                   Set Test Variable             ${EXCEL_NAME}      ${EXCEL_2C2P_PAYMENT}
    ...           AND                   Set Test Variable             ${URL_API}         ${API_INQUIRY['${ENV}']}
    ...           AND                   Set Test Variable             ${json_request}    ${file_path_request}
    [Template]    Verify_Header_Post
    #rowNo         testcaseNo            parameter                     missing_empty_invalid    statusCode                           invalidValue
    94            HD1001_400            Content-Type                  missing            415
    95            HD1001_401            clientId                      missing            401
    96            HD1001_402            clientSecret                  missing            401
    97            HD1001_403            sourceTransID                 missing            400
    98            HD1001_404            requestTime                   missing            400
    99            HD1001_405            partnerCode                   missing            400
    100            HD1001_406            transactionChannel            missing            400
    101           HD1001_407            languagepreference            missing            415
    102           HD1001_600            Content-Type                  empty              415
    103           HD1001_601            clientId                      empty              401
    104           HD1001_602            clientSecret                  empty              401
    105           HD1001_603            sourceTransID                 empty              400
    106           HD1001_604            requestTime                   empty              400
    107           HD1001_605            partnerCode                   empty              400
    108           HD1001_606            transactionChannel            empty              400
    109           HD1001_607            languagepreference            empty              400
    110           HD1001_600            Content-Type                  invalid            415                         @3124
    111           HD1001_601            clientId                      invalid            401                         @3124
    112           HD1001_602            clientSecret                  invalid            401                         @3124
    113           HD1001_603            sourceTransID                 invalid            415                         @3124
    114           HD1001_604            requestTime                   invalid            400                         2021/09/02
    115           HD1001_605            languagePreference            invalid            400                         thai          