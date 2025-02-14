*** Settings ***
Documentation               Arquivo base do projeto

Resource                    services.resource

*** Variables ***
${BASE_URL}    https://viacep.com.br/ws
${VALID_CEP}    50030240
${INVALID_CEP}    50000000
${INVALID_FORMAT_CEP_SHORT}    123
${INVALID_FORMAT_CEP_LONG}    12345678
${SPECIAL_CHAR_CEP}    12@#000
