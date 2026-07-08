*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${IMAGE}    ${EXECDIR}/Ressources/Images/open.jpg

${browser1}    chrome
${browser2}    firefox

${url_google}    https://www.google.fr
*** Test Cases ***
Form Operations
    [Tags]    forms
    Open Browser    https://demo-qa-app.azurewebsites.net/    chrome    options=add_argument("--headless=new"); add_argument("--no-sandbox"); add_argument("--disable-dev-shm-usage")
#    Open Browser    https://demo-qa-app.azurewebsites.net/    chrome    options=add_argument("--headless=new"); add_argument("--no-sandbox"); add_argument("--disable-dev-shm-usage"); add_argument("--window-size=1920,1080")
#    Maximize Browser Window
    Set Window Size    1920    1080
    Sleep    2   
    #Click Element    //h5[contains(text(),'Forms')]Scroll Element Into View    xpath=(//div[@class='card mt-4 top-card'])[2]
    #Click Element    xpath=(//div[@class='card mt-4 top-card'])[2]
    ${forms}=    Get WebElement    xpath=(//div[@class='card mt-4 top-card'])[2]
    Execute JavaScript    arguments[0].scrollIntoView({block: "center"});    ARGUMENTS    ${forms}
    Sleep    1
    Execute JavaScript    arguments[0].click();    ARGUMENTS    ${forms}
    Sleep    2
    Click Element    //span[contains(text(),'Practice Form')]
    Sleep    2
    Input Text      //input[@id='firstName']    Saymaz
    Input Text    //input[@id='lastName']    Yanyatmaz
    Input Text    id=userEmail    saymaz@gmail.com
    Sleep    2
    #Click Element    //input[@value='Male']
    #Click Element    xpath=//label[@for='gender-radio-1']
    Scroll Element Into View    css=label[for='gender-radio-1']
    ${male}=    Get WebElement    css=label[for='gender-radio-1']
    Execute JavaScript    arguments[0].click();    ARGUMENTS    ${male}
    
    Input Text    //input[@id='userNumber']    0601040506
    Sleep    3
    Click Element    id=dateOfBirthInput
    Press Keys    id=dateOfBirthInput    CTRL+a
    Sleep    1
    Press Keys    id=dateOfBirthInput    DELETE
    Sleep    1
    Input Text    id=dateOfBirthInput    05 Jun 2001
    Sleep    1
    Press Keys    id=dateOfBirthInput    TAB

    Sleep    3
    Click Element    //div[@class="col-12 mt-4 col-md-3"]
    Sleep    3
    Input Text    id=subjectsInput    Robot framework tutorial
    Sleep    2
    Wait Until Element Is Enabled    //input[@id='hobbies-checkbox-2']    10
    #Click Element    //input[@id='hobbies-checkbox-2']
    ${reading}=    Get WebElement    css=label[for='hobbies-checkbox-2']
    Execute JavaScript    arguments[0].click();    ARGUMENTS    ${reading}
    Sleep    2
#    Choose File    id=uploadPicture    C:/Users/Pc/Desktop/open.JPG
    Choose File    id=uploadPicture    ${IMAGE}
    Sleep    5
    Input Text    id=currentAddress    01 rue de belle vue
    Sleep    2

    Click Element    xpath=//div[@id='state']//div[contains(@class,'control')]
    Input Text       xpath=//input[@id='react-select-3-input']    Uttar Pradesh
    Press Keys       xpath=//input[@id='react-select-3-input']    ENTER

#    Scroll Element Into View    xpath=//div[@id='state']
#    Sleep    1

#    ${state}=    Get WebElement    xpath=//div[@id='state']//div[contains(@class,'control')]
#    Execute JavaScript    arguments[0].click();    ARGUMENTS    ${state}

#    Wait Until Element Is Visible    xpath=//input[@id='react-select-3-input']    10s
#    Input Text    xpath=//input[@id='react-select-3-input']    Uttar Pradesh
#    Press Keys    xpath=//input[@id='react-select-3-input']    ENTER
#    Sleep    2

    Click Element    xpath=//div[@id='city']//div[contains(@class,'control')]
    Input Text       xpath=//input[@id='react-select-4-input']    Merrut
    Press Keys       xpath=//input[@id='react-select-4-input']    ENTER
    Sleep    2
    Click Button    id=submit
    Sleep    3
    Page Should Contain Element    id=example-modal-sizes-title-lg
    ${textVerification} =     Get Text   id=example-modal-sizes-title-lg
    Log    ${textVerification}
    Sleep    2


    Sleep    5
    Capture Page Screenshot    filename=FormSucces.png      
    Sleep    2
    Element Text Should Be    example-modal-sizes-title-lg    Thanks for submitting the form
    Click Button    id=closeLargeModal

    Sleep    3

Recherche Google
    #Create Webdriver    chrome  -> pour utiliser chrome après téléchargé
    Open navigatorChrome
    Wait Until Element Is Enabled    xpath=//*[@id="L2AGLb"]  timeout= 10
    Click Element    xpath=//*[@id="L2AGLb"]
    Page Should Contain Element    xpath=//*[@aria-label="Recherche Google"]
    Input Text    xpath=//textarea[@name="qQ"]    Robotframework    
    Click Element    xpath=//*[@aria-label="Recherche Google"]


Iframe conn
    [Tags]    Iframe
#    Open Browser    https://the-internet.herokuapp.com/frames    chrome
    Open Browser    https://the-internet.herokuapp.com/frames    chrome    options=add_argument("--headless=new"); add_argument("--no-sandbox"); add_argument("--disable-dev-shm-usage")
    Sleep    2
    Click Element    //a[@href="/iframe"]
    Sleep    2
    Click Element    //button[@type='button']/div[@aria-label="Close"]
   # Select Frame    //iframe[@id='mce_0_ifr']
    Click Element    //body[@id="tinymce"]/p
    Element Should Contain    //body[@id="tinymce"]/p    Your content goes here.
  #  Unselect Frame    
    Sleep    2
    Click Element    //a[contains(text(),'Elemental')]       
    Sleep    2

*** Keywords ***
Open navigatorChrome
    open browser    ${url_google}     ${browser1}    options=add_argument("--headless=new")
    Maximize Browser Window     
    
