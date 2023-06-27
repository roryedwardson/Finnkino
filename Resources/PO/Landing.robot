*** Settings ***
Library     SeleniumLibrary
Library     Dialogs

*** Variables ***
${LANDING_NAVIGATION_ELEMENT} =         id=main-header

*** Keywords ***
Navigate to
    go to    ${URL}

Verify page loaded
#    execute manual step     fill in captcha
    wait until page contains element    ${LANDING_NAVIGATION_ELEMENT}