*** Settings ***
Library    RequestsLibrary
Library    Collections

Resource                    ../resources/base.resource

*** Test Cases ***
CEP Válido - Deve Retornar Dados Corretos
    [Documentation]    Testa um CEP válido e verifica os dados retornados.
    ${response}     GET    ${BASE_URL}/${VALID_CEP}/json/
    ${fixture_data}     Get Data Fixture   fixture_data
    Status Should Be        200
    Should Be Equal As Strings    ${response.json()}    ${fixture_data['dados_cep_valido']}

CEP Inválido - Deve Retornar CEP Não Encontrado
    [Documentation]     Testa um CEP inexistente e valida a mensagem de erro.
    ${response}    GET    ${BASE_URL}/${INVALID_CEP}/json/
    Status Should Be        200
    Should Be Equal As Strings    ${response.json()['erro']}    true

Formato Incorreto CEP Curto - Deve Retornar Erro
    [Documentation]    Testa um CEP curto inválido.
    ${response}     GET    ${BASE_URL}/${INVALID_FORMAT_CEP_SHORT}/json/
    Status Should Be        400

Formato Incorreto CEP Longo - Deve Retornar Erro
    [Documentation]    Testa um CEP longo inválido.
    ${response}     GET    ${BASE_URL}/${INVALID_FORMAT_CEP_LONG}/json/
    Status Should Be        200
    Should Be Equal As Strings    ${response.json()['erro']}    true

Caracteres Especiais - Deve Retornar Erro
    [Documentation]    Testa um CEP com caracteres especiais.
    ${response}     GET    ${BASE_URL}/${SPECIAL_CHAR_CEP}/json/
    Status Should Be        400

