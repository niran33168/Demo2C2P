*** Settings ***
Resource    ../TestResource/Keywords/AllKeywords.txt

*** Test Cases ***
Full Payment in case validate parameter body Mandatory / Optional condition Missing
    [Setup]       Run Keywords                                Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                                         Set Test Variable    ${SHEET_NAME}    ${SHEET_Validate_Payment}
    [Teardown]    Close Browser
    [Template]    API_Validation_Parameter_Payment_Missing
   #rowNo        statusCode                          testcaseNo
    3             400                                         APIPay1001_401
    4             400                                         APIPay1001_402
    5             400                                         APIPay1001_403
    6             400                                         APIPay1001_404
    7             400                                         APIPay1001_405
    8             400                                         APIPay1001_406
    9             400                                         APIPay1001_407
    10            400                                         APIPay1001_408
    11            400                                         APIPay1001_409
    12            400                                         APIPay1001_410
    13            400                                         APIPay1001_411
    14            400                                         APIPay1001_412
    15            400                                         APIPay1001_413
    16            400                                         APIPay1001_414
    17            400                                         APIPay1001_415
    18            400                                         APIPay1001_416
    19            400                                         APIPay1001_417
    20            400                                         APIPay1001_418
    21            400                                         APIPay1001_419

Full Payment in case validate parameter body Mandatory / Optional condition Empty Value
    [Setup]       Run Keywords                              Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                                       Set Test Variable    ${SHEET_NAME}    ${SHEET_Validate_Payment}
    [Teardown]    Close Browser
    [Template]    API_Validation_Parameter_Payment_Empty
   #rowNo        statusCode                                testcaseNo
    23            400                                       APIPay1001_601
    24            400                                       APIPay1001_602
    25            400                                       APIPay1001_603
    26            400                                       APIPay1001_604
    27            400                                       APIPay1001_605
    28            400                                       APIPay1001_606
    28            400                                       APIPay1001_607
    29            400                                       APIPay1001_608
    30            400                                       APIPay1001_609
    31            400                                       APIPay1001_610
    32            400                                       APIPay1001_611
    33            400                                       APIPay1001_612
    34            400                                       APIPay1001_613
    35            400                                       APIPay1001_614
    36            400                                       APIPay1001_615
    37            400                                       APIPay1001_616
    38            400                                       APIPay1001_617
    39            400                                       APIPay1001_618
    40            400                                       APIPay1001_619

Full Payment in case validate parameter body Mandatory / Optional condition Invalid
    [Setup]       Run Keywords                                Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
    ...           AND                                         Set Test Variable    ${SHEET_NAME}    ${SHEET_Validate_Payment}
    [Teardown]    Close Browser
    [Template]    API_Validation_Parameter_Payment_Invalid
   #rowNo        statusCode                                  testcaseNo
    41            400                                         APIPay1001_800
    42            400                                         APIPay1001_801
    43            400                                         APIPay1001_802
    44            400                                         APIPay1001_803
    45            400                                         APIPay1001_804
    46            400                                         APIPay1001_805
    47            400                                         APIPay1001_806
    48            400                                         APIPay1001_807
    49            400                                         APIPay1001_808
    50            400                                         APIPay1001_809
    51            400                                         APIPay1001_810
    52            400                                         APIPay1001_811
    53            400                                         APIPay1001_812
    54            400                                         APIPay1001_813
    # 55            400                                         APIPay1001_814
    56            400                                         APIPay1001_815
    57            400                                         APIPay1001_816
    58            400                                         APIPay1001_817
    59            400                                         APIPay1001_818
    60            400                                         APIPay1001_819
    61            400                                         APIPay1001_820
    62            400                                         APIPay1001_821

Full Payment in case validate parameter body Optional Invalid
     [Setup]       Run Keywords                                Set Test Variable    ${EXCEL_NAME}    ${EXCEL_2C2P_PAYMENT}
     ...           AND                                         Set Test Variable    ${SHEET_NAME}    ${SHEET_Validate_Payment}
     [Teardown]    Close Browser
     [Template]    API_Validation_Parameter_Payment_Invalid
   #rowNo        statusCode                                  testcaseNo
     63            400                                         APIPay1002_800
     64            400                                         APIPay1002_801
