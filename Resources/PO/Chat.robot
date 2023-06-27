*** Settings ***
Library     SeleniumLibrary

*** Variables ***

*** Keywords ***
Dismiss
    wait until page contains element    //*[@id="ninchat-customercare"]
    click element                       //*[@id="ninchat-customercare"]/div[1]/button[5]/i