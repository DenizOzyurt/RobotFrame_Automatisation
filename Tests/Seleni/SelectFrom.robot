*** Settings ***
Library    SeleniumLibrary

*** Variables ***



*** Test Cases ***
Selectionner une valeur d'une liste
    [Tags]    dropdown
    Open Browser    https://the-internet.herokuapp.com/dropdown    chrome
    Sleep    3
    Select From List By Value    //select[@id="dropdown"]    2
    Sleep    2   
    # index commence par 0 comme list  1
    Select From List By Index    //select[@id="dropdown"]    1
    Sleep    2

Selectionner une checkbox
    [Tags]    checkbox
    Open Browser    https://the-internet.herokuapp.com/checkboxes    chrome
    Sleep    2
    Select Checkbox    //form[@id="checkboxes"]/input[1]
    Sleep    2
    Select Checkbox    //form[@id="checkboxes"]/input[2]
    Sleep    2    
    Unselect Checkbox    //form[@id="checkboxes"]/input[1]
    Sleep    2     
    Unselect Checkbox    //form[@id="checkboxes"]/input[2]
    Sleep    2 

Click sur element
    [Tags]    clickel
    Open Browser    https://the-internet.herokuapp.com/    chrome
    Sleep    2   
    Click Element    //a[@href="/broken_images"]
    Sleep    2
    
Remplir autorisation
    [Tags]    auth
    Open Browser    https://the-internet.herokuapp.com/    chrome
    Maximize Browser Window
    Sleep    2   
    Click Element    xpath=//a[@href="/digest_auth"]
    Sleep    2   
    Go To    https://user:admin@the-internet.herokuapp.com/digest_auth
    Sleep    4   
    Page Should Contain    Congratulations
    Sleep    2   
Remplir alert
    [Tags]    auth1
    Open Browser    https://demo-qa-app.azurewebsites.net/alerts    chrome
    Maximize Browser Window
    Sleep    2   
    #Click Element   //*[@id="item-1"]
    #Sleep    4    
    Click Element    //button[@id="promtButton"]

    Sleep    4
    Input Text Into Alert    robotframework    action=ACCEPT
    Sleep    4

    Click Element    //button[@id="alertButton"]
    Sleep    2
    Handle Alert    action=ACCEPT
    Sleep    2

Nested Iframe conn
    [Tags]    Nes_iframe
    Open Browser    https://the-internet.herokuapp.com/frames    chrome    
    Sleep    2
    Click Element    //a[@href="/nested_frames"]
    Sleep    2
    Select Frame    name=frame-top
    Sleep    2
    Select Frame    //frame[@name='frame-middle']
    Sleep    2
    Element Should Contain   //div[@id='content']    MIDDLE
    Sleep    2
    Unselect Frame
    Close window 

Iframe conn
    [Tags]    Iframe
    Open Browser    https://the-internet.herokuapp.com/frames    chrome
    Sleep    2
    Click Element    //a[@href="/iframe"]
    Sleep    2
    Click Element    //button[@type='button']/div[@aria-label="Close"]
    Select Frame    //iframe[@id='mce_0_ifr']
    Click Element    //body[@id="tinymce"]/p
    Element Should Contain    //body[@id="tinymce"]/p    Your content goes here.
    Unselect Frame    
    Sleep    2
    Click Element    //a[contains(text(),'Elemental')]       
    Sleep    2

Windows handle
    [Tags]    windows
    Open Browser    https://the-internet.herokuapp.com/frames    chrome
    Sleep    2    
    Click Element    //a[contains(text(),'Elemental')]       
    Sleep    2
    Wait Until Keyword Succeeds    5    1    Switch Window    NEW
    Click Element    //a[@href="/tips"]

    ${handles}=    Get Window Handles
    Log To Console    ${handles}
    
    Switch Window    MAIN

    Sleep    3

    Element Should Contain    //h3    Frames

    


