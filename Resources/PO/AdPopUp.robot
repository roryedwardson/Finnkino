*** Settings ***
Library     SeleniumLibrary

*** Variables ***

*** Keywords ***
Close Frame
    [Documentation]    Using iframe default width to navigate into iframe and click the "X" button.
    wait until page contains element    //iframe[@width="980"]
    select frame                        //iframe[@width="980"]
    wait until page contains element    //*[@id="i28"]
    click element                       //*[@id="i28"]
    unselect frame