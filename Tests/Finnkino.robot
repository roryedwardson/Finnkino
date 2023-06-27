*** Settings ***
Documentation       This is a test suite to verify whether a user can access Finnkino film listings
...                 for a specific location, and extract today's titles as a txt file.
Resource            ../Resources/Common.robot
Resource            ../Resources/FinnkinoApp.robot
Test Setup          Begin Web Test
Test Teardown       End Web Test

#Run script
#robot -d results tests/Finnkino.robot
#pabot --processes 10 -d results tests/Finnkino.robot

*** Variables ***
${BROWSER} =                chrome
${URL} =                    http://www.finnkino.fi/

${LANGUAGE_SET} =           English
&{LANGUAGE_DICT}            English=/en/        Finnish=/           Swedish=/sv/

${LOCATION_SET} =           Jyväskylä
&{LOCATION_DICT}            Jyväskylä=1015      Helsinki=1031       Tampere=1034    Turku=1022

# A few different ${LOCATION} options for testing:
# Jyväskylä: FANTASIA - 1015
# Helsinki: KINOPALATSI - 1031
# Tampere: CINE Atlas - 1034
# Turku: KINOPALATSI - 1022

*** Test Cases ***
User should be able to access landing page
    [Documentation]     Verify that user can access landing page
    [Tags]              0001    Landing
    FinnkinoApp.Go to landing page

User should be able to accept cookies
    [Documentation]     Verify that user can accept cookies
    [Tags]              0002    Cookies
    FinnkinoApp.Go to landing page
    FinnkinoApp.Accept cookies

User should be able to reject cookies
    [Documentation]     Verify that user can reject cookies
    [Tags]              0003    Cookies
    FinnkinoApp.Go to landing page
    FinnkinoApp.Reject cookies

User should be able to dismiss chat
    [Documentation]     Verify that user can dismiss chat
    [Tags]              0004    Chat
    FinnkinoApp.Go to landing page
    FinnkinoApp.Accept cookies
    FinnkinoApp.Close Chat

User should be able to dismiss ad
    [Documentation]     Verify that user can dismiss ad
    [Tags]              0005    Ads
    FinnkinoApp.Go to landing page
    FinnkinoApp.Accept cookies
    FinnkinoApp.Close Chat
    FinnkinoApp.Close Ad

# Had issues getting a working locator on the ad's iframe overlay.
# Found a solution: able to select frame using the iframe's default width property.

User should be able to select language
   [Documentation]     Verify that user can change site language
   [Tags]              0006    TopNav
   FinnkinoApp.Go to landing page
   FinnkinoApp.Accept cookies
   FinnkinoApp.Close Chat
   FinnkinoApp.Close Ad
   FinnkinoApp.Select language

User should be able to select location
   [Documentation]     Verify that user can change chosen cinema location
   [Tags]              0007    TopNav
   FinnkinoApp.Go to landing page
   FinnkinoApp.Accept cookies
   FinnkinoApp.Close Chat
   FinnkinoApp.Close Ad
   FinnkinoApp.Select language
   FinnkinoApp.Select location

Today's date should be selected by default
   [Documentation]     Verify that today's date is selected by default
   [Tags]              0008    Results
   FinnkinoApp.Go to landing page
   FinnkinoApp.Accept cookies
   FinnkinoApp.Close Chat
   FinnkinoApp.Close Ad
   FinnkinoApp.Select language
   FinnkinoApp.Select location
   FinnkinoApp.Validate date              ${LANGUAGE_SET}

User should be able to select Show Results
    [Documentation]     Verify that "Show Results" button works as expected
    [Tags]              0009    Results
    FinnkinoApp.Go to landing page
    FinnkinoApp.Accept cookies
    FinnkinoApp.Close Chat
    FinnkinoApp.Close Ad
    FinnkinoApp.Select language
    FinnkinoApp.Select location
    FinnkinoApp.Validate date              ${LANGUAGE_SET}
    IF    "${LANGUAGE_SET}" == "Finnish"
        FinnkinoApp.Close Ad
    END
    FinnkinoApp.Select "Show Results"      ${LANGUAGE_SET}

Should be able to view today's listings
   [Documentation]     Verify that viewing today's listings returns results that match today's date
   [Tags]              0010    Results
   FinnkinoApp.Go to landing page
   FinnkinoApp.Accept cookies
   FinnkinoApp.Close Chat
   FinnkinoApp.Close Ad
   FinnkinoApp.Select language
   FinnkinoApp.Select location
   FinnkinoApp.Validate date              ${LANGUAGE_SET}
   IF    "${LANGUAGE_SET}" == "Finnish"
        FinnkinoApp.Close Ad
   END
   FinnkinoApp.Select "Show Results"      ${LANGUAGE_SET}
   FinnkinoApp.Validate listings

Should be able to write today's titles to file
   [Documentation]     Verify that user can write all titles that are screening today to txt file
   [Tags]              0011    Results
   FinnkinoApp.Go to landing page
   FinnkinoApp.Accept cookies
   FinnkinoApp.Close Chat
#   FinnkinoApp.Close Ad
   FinnkinoApp.Select language
   FinnkinoApp.Select location
   FinnkinoApp.Validate date              ${LANGUAGE_SET}
   FinnkinoApp.Select "Show Results"      ${LANGUAGE_SET}
   FinnkinoApp.Validate listings
   FinnkinoApp.Return list of today's screenings
   FinnkinoApp.Write listings to txt file