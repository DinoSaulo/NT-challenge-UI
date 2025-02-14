*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
### Hooks
Open the browser
    Open Browser        ${URL}      ${BROWSER}
    Set Window Size     1200    800

### Steps test scenario
Given I am in the home page
    Execute JavaScript    window.location.href='/home'
    Click Element 	 id:onetrust-accept-btn-handler

When I search for the item "${product}"
    Input Text    id:input-busca    ${product}
    Press Keys    id:input-busca    ENTER
    
    Wait Until Element Is Visible    xpath=//article[contains(@class, 'productCard')][1]

And I select the first product from the list
    Scroll Element Into View    xpath=//article[contains(@class, 'productCard')][1]
    Click Element    xpath=//article[contains(@class, 'productCard')][1]

And I enter a CEP code and validate the available shipping options
    Input Text    id:inputCalcularFrete    ${CEP}
    Click Element    xpath=//button[@id='botaoCalcularFrete'] 

And I close the shipping options window
    Click Element    xpath=//div[@role="dialog"]/button[@aria-label="Fechar"]

And I click on Buy
    ${url}=   Get Location
    ${PRODUCT_CODE}  Set Variable    ${url.split('/')[4]}
    Set Test Variable       ${PRODUCT_CODE}

    ${PRODUCT_NAME}  Get Text  xpath=//div[@id='container-purchase']//h1
    Set Test Variable       ${PRODUCT_NAME}

    Execute JavaScript    document.evaluate("//button[contains(text(),'COMPRAR')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click();
    wait until location is    ${URL[:24]}/precarrinho/${PRODUCT_CODE}/0

And I select the additional 12-month warranty
    Click Element    xpath=//span[contains(text(),"12 Meses de garantia")]/../../../input[@name="garantia"]

And I click on "Go to the cart"
    Execute JavaScript    document.evaluate("//span[contains(text(), 'Adicionar serviços')]/../../button", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click();

Then I should see the correct product added to the cart
    Element Should Contain    xpath=//div[@data-smarthintproductid="${PRODUCT_CODE}"]    ${PRODUCT_NAME}

Close Browser
    Close Browser
