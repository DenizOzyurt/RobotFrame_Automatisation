*** Comments ***

*** Settings ***
Documentation    Test case pour expliquer les sections 
...    sous RobotFramework

Library    SeleniumLibrary

*** Variables ***
${MSG}=    Message Hello tout le monde

*** Keywords ***
Afficher un message
    Log    ${MSG}

*** Test Cases ***
afficher text1
    [Tags]    1
    Log    text1 hello world
    Afficher un message

afficher text2
    [Tags]    2
    Log    text2 hello world