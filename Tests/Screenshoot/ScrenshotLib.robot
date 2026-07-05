*** Settings ***
Library    Screenshot

*** Test Cases ***
Prendre une capture d'écran
    Set Screenshot Directory    ../../Resultats/screenshot
   # Take Screenshot    image    400px
   Take Screenshot Without Embedding    sans_em
