*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${"input_search"}     id:input-busca
${"btn_accept_cookies"}     id:onetrust-accept-btn-handler
${"first_cart_element"}     xpath=//article[contains(@class, 'productCard')][1]
${"input_calculate_frete"}   id:inputCalcularFrete
${"btn_calculate_frete"}    xpath=//button[@id='botaoCalcularFrete']
${"btn_close_frete_modal"}      xpath=//div[@role="dialog"]/button[@aria-label="Fechar"]
${"product_name"}       xpath=//div[@id='container-purchase']//h1
${"btn_buy"}        "//button[contains(text(),'COMPRAR')]"
${"warranty_input"}     xpath=//span[contains(text(),"12 Meses de garantia")]/../../../input[@name="garantia"]
${"btn_add_warranty"}   "//span[contains(text(), 'Adicionar serviços')]/../../button"

*** Keywords ***
### Hooks
Open the browser
    Open Browser        ${URL}      ${BROWSER}
    Set Window Size     1200    800

### Steps test scenario
Given I am in the home page
    Execute JavaScript    window.location.href='/home'
    Click Element   ${"btn_accept_cookies"}

When I search for the item "${product}"
    Input Text    ${"input_search"}    ${product}
    Press Keys    ${"input_search"}    ENTER
    
    Wait Until Element Is Visible    ${"first_cart_element"}

And I select the first product from the list
    Scroll Element Into View    ${"first_cart_element"}
    Click Element    ${"first_cart_element"}

And I enter a CEP code and validate the available shipping options
    Input Text    ${"input_calculate_frete"}     ${CEP}
    Click Element       ${"btn_calculate_frete"}

And I close the shipping options window
    Click Element   ${"btn_close_frete_modal"}

And I click on Buy
    ${url}=   Get Location
    ${PRODUCT_CODE}  Set Variable    ${url.split('/')[4]}
    Set Test Variable       ${PRODUCT_CODE}

    ${PRODUCT_NAME}  Get Text   ${"product_name"}
    Set Test Variable       ${PRODUCT_NAME}

    Execute JavaScript    document.evaluate(${"btn_buy"}, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click();                                               
    wait until location contains    /precarrinho/${PRODUCT_CODE}/0

And I select the additional 12-month warranty
    Click Element    ${"warranty_input"}

And I click on "Go to the cart"
    Execute JavaScript    document.evaluate(${"btn_add_warranty"}, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click();

Then I should see the correct product added to the cart
    Element Should Contain    xpath=//div[@data-smarthintproductid="${PRODUCT_CODE}"]    ${PRODUCT_NAME}

Close Browser
    Close Browser
