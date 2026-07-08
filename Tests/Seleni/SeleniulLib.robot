*** Settings ***
Library    SeleniumLibrary
Documentation    Test basic sur selenium library soud RobotFramework

*** Variables ***
${browser1}    chrome
${browser2}    firefox

${url_google}    https://www.google.fr

*** Test Cases ***
Recherche Google
    #Create Webdriver    chrome  -> pour utiliser chrome après téléchargé
    Open navigatorChrome
    Wait Until Element Is Enabled    xpath=//*[@id="L2AGLb"]  timeout= 10
    Click Element    xpath=//*[@id="L2AGLb"]
    Page Should Contain Element    xpath=//*[@aria-label="Recherche Google"]
    Input Text    xpath=//textarea[@name="qQ"]    Robotframework    
    Click Element    xpath=//*[@aria-label="Recherche Google"]
    
    #Wait Until Element Is Enabled    xpath=//*[@id="L2AGLb"]  timeout= 10

*** Keywords ***
Open navigatorChrome
    open browser    ${url_google}     ${browser1}
    Maximize Browser Window 