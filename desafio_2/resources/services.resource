*** Settings ***
Documentation               Serviços

Library                     RequestsLibrary

Resource                    helpers.resource

*** Keywords ***
GET
    [Arguments]    ${url}
    ${session}=    Create Session    ViaCEP    ${url}
    ${response}=    Get Request    ViaCEP    /
    [Return]    ${response}
