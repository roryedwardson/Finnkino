*** Settings ***
Library     SeleniumLibrary

*** Variables ***

*** Keywords ***
Choose language
    Select from list by value   global-lang     ${LANGUAGE_DICT.${LANGUAGE_SET}}

Choose location
    select from list by value   global-area2    ${LOCATION_DICT.${LOCATION_SET}}

Click "Show Results" button
    [Arguments]     ${Language}
    log                     ${Language}
    IF  "${Language}" == "English"
        Click Button        Show Results ››
    ELSE IF     "${Language}" == "Finnish"
        Click Button        Etsi näytökset ››
    ELSE IF     "${Language}" == "Swedish"
        Click Button        Sök visningar ››
    END