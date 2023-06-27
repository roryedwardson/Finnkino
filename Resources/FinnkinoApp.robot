*** Settings ***
Resource    ../Resources/PO/AdPopUp.robot
Resource    ../Resources/PO/Cookies.robot
Resource    ../Resources/PO/Chat.robot
Resource    ../Resources/PO/Landing.robot
Resource    ../Resources/PO/Results.robot
Resource    ../Resources/PO/TopNav.robot

*** Variables ***

*** Keywords ***
Go to landing page
    Landing.Navigate to
    Landing.Verify page loaded

Accept cookies
    Cookies.Accept

Reject cookies
    Cookies.Reject

Select language
    TopNav.Choose language

Select location
    TopNav.Choose location

Validate date
    [Arguments]     ${Date_Language}
    Results.Verify today is selected        ${Date_Language}

Select "Show Results"
    [Arguments]     ${Language}
    TopNav.Click "Show Results" button      ${Language}

Validate listings
    Results.Verify that elements in results list contain today's date

Return list of today's screenings
    Results.Add matching elements to list

Write listings to txt file
    Results.Append listings to txt file

Close Ad
    AdPopUp.Close Frame

Close Chat
    Chat.Dismiss