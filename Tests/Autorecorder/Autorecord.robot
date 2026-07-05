*** Settings ***
Library    SeleniumLibrary
Library    AutoRecorder           

*** Variables ***
${Browser}    chrome

*** Test Cases ***
Autorecorder avec selenium
    Open Python
    Sleep    3
    Mouse Over    //li[@id="downloads"]   
    Sleep    2
    Click Element    //li[@id='downloads']//ul/li[@class='tier-2 element-2']
    #Click Element    //li[@id='downloads']//ul/li/a[text()='Source code']
    Sleep    2


*** Keywords ***
Open Python
    Open Browser    https://www.python.org/    ${Browser}
    Maximize Browser Window    
