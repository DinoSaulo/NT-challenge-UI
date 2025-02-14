*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
### Hooks
Open the browser
    Open Browser        ${URL}      ${BROWSER}
    #Maximize Browser Window

### Steps test scenario
Given I am in the home page
    Execute JavaScript    window.location.href='/home'

When I search for the term "${product}"
    Input Text    id:input-busca    ${product}
    Press Keys    id:input-busca    ENTER
    
    Wait Until Element Is Visible    xpath=//article[contains(@class, 'productCard')][1]

And I select the first product from the list
    Click Element    xpath=//article[contains(@class, 'productCard')][1]

And I enter a CEP code and validate the available shipping options
    Input Text    id:inputCalcularFrete    ${CEP}
    Click Element    xpath=//button[@id='botaoCalcularFrete'] 

And I close the shipping options window
    Click Element    xpath=//div[@role="dialog"]/button[@aria-label="Fechar"]

And I click on Buy
    Execute JavaScript    window.scrollTo(0,500)
    Click Element    xpath=//button[contains(text(),'COMPRAR')]

And I select the additional 12-month warranty
    Click Element    xpath=//span[contains(text(),"12 Meses de garantia")]/../../../input[@name="garantia"]

And I click on "Go to the cart"
    Click Element    xpath=//span[contains(text(), 'Adicionar serviços')]/../../button

Then I should see the correct product added to the cart
    Element Should Contain    xpath=//div[@data-smarthintproductid="658786"]    MacBook Pro Apple 14", M4 Pro, CPU 14 Núcleos, GPU 20 Núcleos, Neural Engine de 16 Núcleos, 24GB RAM, SSD 1TB, Preto-espacial - MX2J3BZ/A

Close Browser
    Close Browser
