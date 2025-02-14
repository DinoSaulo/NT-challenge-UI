*** Settings ***
Documentation               Helpers

Library                     JSONLibrary

*** Keywords ***
Get Data Fixture
    [Arguments]             ${json_object}

    ${fixture}              Load Json From File
    ...                     ${EXECDIR}/desafio_2/resources/fixtures/cep_data.json
    ...                     encoding=UTF-8

    RETURN                  ${fixture}
