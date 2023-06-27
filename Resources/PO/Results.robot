*** Settings ***
Library     OperatingSystem
Library     DateTime
Library     SeleniumLibrary
Library     Collections
Library     String

*** Variables ***

*** Keywords ***
Verify today is selected
    [Arguments]     ${Date_Language}
    log             ${Date_Language}
    ${todays_date} =    Get Current Date    time_zone=local     result_format=%d.%m.%Y
    log                 ${todays_date}
#    Grab currently selected date from selector
    IF  "${Date_Language}" == "Finnish"
        ${selected_date} =  Get Value           xpath=//*[@id="UpdateTarget-UserControlScheduleGroupShowList_102"]/div[1]/form/div/div[2]/div/div[2]/div/select/option[1]
    ELSE
        ${selected_date} =  Get Value           xpath=//*[@id="UpdateTarget-UserControlScheduleGroupShowList_101"]/div[1]/form/div/div[2]/div/div[2]/div/select/option[1]
    END
    log                 ${selected_date}
#    check whether ${selected_date} == ${todays_date}
    should be equal     ${todays_date}   ${selected_date}

Verify that elements in results list contain today's date
    ${todays_date} =    Get Current Date    time_zone=local     result_format=%d.%m.%Y
    log                 ${todays_date}
#   Ensure at least one result is returned
    wait until page contains element        css=p[class="showDate no-margin text-center"]
    ${results_date} =   Get Text            css=p[class="showDate no-margin text-center"]
    ${converted_results_date} =   Convert Date        ${results_date}     date_format=%d.%m.%Y   result_format=%d.%m.%Y
    log                 ${converted_results_date}
#    check whether ${results_date} == ${todays_date}
    should be equal     ${todays_date}   ${converted_results_date}

Add matching elements to list
# Iterate through all film title headers on the page,
# alter each to title case and append to ScreeningList.
    @{ScreeningList} =  Create List
    ${elements} =       Get WebElements    css=h1[class="eventName one-line no-margin"]
    FOR    ${item}      IN      @{elements}
            ${lowercase} =  convert to lower case    ${item.text}
            ${titlecase} =  convert to title case    ${lowercase}
            Append To List      ${ScreeningList}    ${titlecase}
    END

# Altering each title value to add in screening time
    ${time} =          Get WebElements    css=h2[class="showTime no-margin"]
    FOR     ${title}     IN      @{ScreeningList}
            ${index} =  get index from list    ${ScreeningList}     ${title}
            ${time_value} =     Set Variable    ${time[${index}]}

            set list value  ${ScreeningList}    ${index}    ${title} - ${time_value.text}
    END

#    ${ScreeningList} =    Remove Duplicates   ${ScreeningList}
#    sort list           ${ScreeningList}
    log                 ${ScreeningList}
    set global variable    ${RESULTS}   ${ScreeningList}

Append listings to txt file
# Create a txt file, with the title containing today's date.
# Iterate through the results list,
# and append each title to the txt file.
    ${timestamp} =      Get Current Date    result_format=%Y%m%d-%H%M%S
    ${datestamp} =      Get Current Date    result_format=%d %B %Y
    ${filename} =       Set Variable        Screenings-${LOCATION_SET}-${timestamp}.txt

    append to file    ../Finnkino/Results/Listings/${filename}      Finnkino Film Screenings - ${LOCATION_SET} - ${datestamp}\n\n

    FOR    ${item}      IN      @{RESULTS}
        append to file      ../Finnkino/Results/Listings/${filename}   ${item}\n
    END