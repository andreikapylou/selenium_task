*** Settings ***
Library    Selenium2Library
Test Setup    Open browser    ${URL}   Chrome
Test Teardown    Close All Browsers


*** Variables ***
${URL}    https://practice.expandtesting.com/form-validation/
${CONTRACT_NAME_LOCATOR}    xpath://input[@name='ContactName']
${CONTRACT_NAME_INVALID_FEEDBACK_LOCATOR}    xpath://input[@name='ContactName']/following-sibling::div[@class='invalid-feedback']
${CONTRACT_ID_LOCATOR}    xpath://input[@name='contactnumber']
${CONTRACT_ID_INVALID_FEEDBACK_LOCATOR}    xpath://input[@name='contactnumber']/following-sibling::div[@class='invalid-feedback']
${PICKUP_DATE_LOCATOR}    xpath://input[@name='pickupdate']
${PICKUP_DATE_INVALID_FEEDBACK_LOCATOR}    xpath://input[@name='pickupdate']/following-sibling::div[@class='invalid-feedback']
${PAYMENT_METHOD_LOCATOR}    xpath://select[@name='payment']
${PAYMENT_METHOD_INVALID_FEEDBACK_LOCATOR}    xpath://select[@name='payment']/following-sibling::div[@class='invalid-feedback']
${SUBMIT_BUTTON_LOCATOR}    css:button[type='submit']
${SUCCESSFUL_MESSAGE_LOCATOR}    xpath://div[@role='alert']/p
${VALID_CONTRACT_NAME}    contract_name
${INVALID_CONTRACT_NAME}    ${EMPTY}
${VALID_CONTRACT_ID}    111-3264324
${INVALID_CONTRACT_ID}    ${EMPTY}
${VALID_PICKUP_DATE}    05/31/2024
${INVALID_PICKUP_DATE}    ${EMPTY}
${VALID_PAYMENT_METHOD}    card
${INVALID_PAYMENT_METHOD}    ${EMPTY}


*** Test Cases ***
Positive case
    [Tags]	    positive
    Input text    ${CONTRACT_NAME_LOCATOR}    ${VALID_CONTRACT_NAME}
    Input text    ${CONTRACT_ID_LOCATOR}    ${VALID_CONTRACT_ID}
    Input text    ${PICKUP_DATE_LOCATOR}    ${VALID_PICKUP_DATE}
    Select From List By Value   ${PAYMENT_METHOD_LOCATOR}    ${VALID_PAYMENT_METHOD}
    Click Button    ${SUBMIT_BUTTON_LOCATOR}
    ${actual_message}=  Get Text   ${SUCCESSFUL_MESSAGE_LOCATOR}
    ${expected_message}=    Set Variable    Thank you for validating your ticket
    Should be equal as strings    ${actual_message}     ${expected_message}

Negative case
    [Tags]	    negative
    Input text    ${CONTRACT_NAME_LOCATOR}    ${INVALID_CONTRACT_NAME}
    Input text    ${CONTRACT_ID_LOCATOR}    ${INVALID_CONTRACT_ID}
    Input text    ${PICKUP_DATE_LOCATOR}    ${INVALID_PICKUP_DATE}
    Select From List By Value   ${PAYMENT_METHOD_LOCATOR}    ${INVALID_PAYMENT_METHOD}
    Click Button    ${SUBMIT_BUTTON_LOCATOR}

    ${actual_contract_name_message}=  Get Text   ${CONTRACT_NAME_INVALID_FEEDBACK_LOCATOR}
    ${expected_contract_name_message}=    Set Variable    Please enter your Contact name.
    Should be equal as strings    ${actual_contract_name_message}     ${expected_contract_name_message}

    ${actual_contract_id_message}=  Get Text   ${CONTRACT_ID_INVALID_FEEDBACK_LOCATOR}
    ${expected_contract_id_message}=    Set Variable    Please provide your Contact number.
    Should be equal as strings    ${actual_contract_id_message}     ${expected_contract_id_message}

    ${actual_pickup_date_message}=  Get Text   ${PICKUP_DATE_INVALID_FEEDBACK_LOCATOR}
    ${expected_pickup_date_message}=    Set Variable    Please provide valid Date.
    Should be equal as strings    ${actual_pickup_date_message}     ${expected_pickup_date_message}

    ${actual_payment_method_message}=  Get Text   ${PAYMENT_METHOD_INVALID_FEEDBACK_LOCATOR}
    ${expected_payment_method_message}=    Set Variable    Please select the Paymeny Method.
    Should be equal as strings    ${actual_payment_method_message}     ${expected_payment_method_message}