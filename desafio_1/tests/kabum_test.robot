*** Settings ***
Documentation   Comprar notebook no site da kabum
...     1. Acesse o site www.kabum.com.br.
...     2. Realize uma busca pelo termo "notebook".
...     3. Selecione o primeiro produto da lista.
...     4. Digite um CEP e valide os valores dos fretes disponíveis.
...     5. Feche a tela de opções de frete.
...     6. Clique em "Comprar".
...     7. Selecione a garantia de +12 meses.
...     8. Clique em "Ir para o carrinho".
...     9. Valide que o produto está corretamente adicionado ao carrinho.

Library    SeleniumLibrary
Resource   ../resources/kabum_keywords.robot
Resource   ../resources/kabum_variables.robot

Test Setup      Open the browser

*** Test Cases ***
Feature: Purchase a notebook on Kabum website
    Given I am in the home page
    When I search for the item "Notebook"
    And I select the first product from the list
    #And I enter a CEP code and validate the available shipping options
    #And I close the shipping options window
    And I click on Buy
    And I select the additional 12-month warranty
    And I click on "Go to the cart"
    Then I should see the correct product added to the cart