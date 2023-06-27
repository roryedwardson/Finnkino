*** Settings ***
Library     SeleniumLibrary

*** Variables ***

*** Keywords ***
Accept
    wait until page contains element    xpath=//*[@id="onetrust-policy-title"]
    click button                        xpath=//*[@id="onetrust-accept-btn-handler"]

Reject
    wait until page contains element    xpath=//*[@id="onetrust-policy-title"]
    click button                        xpath=//*[@id="onetrust-reject-all-handler"]