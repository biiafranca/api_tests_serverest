*** Settings ***
Library              Collections
Library              RequestsLibrary
Resource             generate_random_data.resource

*** Variables ***
${RESPONSE}

*** Keywords ***

Status Code Should Be "${status_code}"
    Status Should Be                    ${status_code}          ${RESPONSE}
    ...                                 msg=Status code not expected

Body Response Not Should Be Empty
    Should Not Be Empty                 ${RESPONSE.text}
    ...                                 msg=Response should be empty

Body Response Contains "${KEY}"
    Dictionary Should Contain Key       ${RESPONSE.json()}       ${KEY}

Value Of "${QUANTITY_KEY}" Is Equal Of List "${KEY_WITH_LIST}" Size
    ${LIST_SIZE} =                      Get Length               ${RESPONSE.json()}[${KEY_WITH_LIST}]
    Should Be Equal As Integers         ${LIST_SIZE}             ${RESPONSE.json()}[${QUANTITY_KEY}]

All Elements Of List "${KEY_WITH_LIST}" Contains The Required Info
    FOR   ${USER}   IN    @{RESPONSE.json()}[${KEY_WITH_LIST}]
        Dictionary Should Contain Key         ${USER}      ${ID_KEY}
        Dictionary Should Contain Key         ${USER}      ${NAME_KEY}
        Dictionary Should Contain Key         ${USER}      ${EMAIL_KEY}
        Dictionary Should Contain Key         ${USER}      ${PASSWORD_KEY}
        Dictionary Should Contain Key         ${USER}      ${ADM_KEY}
    END

Body Response Contains Message "${EXPECTED_MESSAGE}"
    ${RESPONSE_MESSAGE} =                Set Variable           ${RESPONSE.json()}[message]
    Should Be Equal As Strings           ${EXPECTED_MESSAGE}    ${RESPONSE_MESSAGE}

Identify ID Of Created Resource
    Dictionary Should Contain Key        ${RESPONSE.json()}     ${ID_KEY}
    Set Test Variable                    ${TEST_ID}             ${RESPONSE.json()}[${ID_KEY}]