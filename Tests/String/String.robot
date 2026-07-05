*** Settings ***
Library    String
Documentation    String library standard

*** Variables ***

*** Test Cases ***
Convertir en minuscule
    ${str1} =    Convert To Lower Case    DENIZ
    ${str2} =    Convert To Lower Case    1ABC2os3DeniZ
    Should Be Lower Case    ${str1}
    Should Be Equal    ${str1}    deniz

Convertir en majuscule
    ${str1} =    Convert To Upper Case    deniz
    ${str2} =    Convert To Upper Case    1ABC2os3DeniZ
    Should Be Upper Case    ${str1}
    Should Be Equal    ${str1}    DENIZ

Generation d'une chaine
    ${low}=    Generate Random String    10    [LOWER]
    Log    ${low}
    ${Letr}=    Generate Random String    8    [LETTERS]    
    Log    ${Letr} 
    
Supprimer caracters
    ${StrS}=    Remove String    Robot Framework    work
    Log    ${StrS}
    Should Be Equal    ${StrS}    Robot Frame

    ${StrS}=    Remove String    ${StrS}    o    bt
    Should Be Equal    ${StrS}    R Frame
    Log    ${StrS}

Remplacer une chain
    ${StrR}=    Replace String    Hello, World from de windows    o    9
    Log    ${StrR}










*** Variables ***
