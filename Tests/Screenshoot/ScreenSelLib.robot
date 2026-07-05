*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${Browser}    chrome

*** Test Cases ***
Capture and crop page screenshot
    Open Python
    Sleep    5
    #Capture Page Screenshot    filename=ScreenSelenium.png    
    
    Capture Element Screenshot    //li[@id="downloads"]    downloads.png

*** Keywords ***
Open Python
    Open Browser    https://www.python.org/    ${Browser}
    Maximize Browser Window    
