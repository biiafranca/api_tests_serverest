*** Settings ***
Library                      RequestsLibrary


*** Variables ***
${URL}                       https://serverest.dev
${REQUEST_BODY}


*** Keywords ***
Send GET Request to ${URI}
    ${RESPONSE} =             GET                    ${URL}${URI}
                              ...                    timeout=1
                              ...                    expected_status=anything
    Set Test Variable         ${RESPONSE}

Send POST Request to ${URI}
    ${TOKEN} =                Get Variable Value     $TOKEN        ${EMPTY}
    IF  "${TOKEN}" != "${EMPTY}"
        ${TOKEN} =            Create Dictionary      authorization=${TOKEN}
    END
    ${RESPONSE} =             POST                   ${URL}${URI}
                              ...                    timeout=1
                              ...                    json=${REQUEST_BODY}
                              ...                    expected_status=anything
                              ...                    headers=${TOKEN}
    Set Test Variable         ${RESPONSE}

Send PUT Request to ${URI}
    ${RESPONSE} =             PUT                    ${URL}${URI}
                              ...                    timeout=1
                              ...                    json=${REQUEST_BODY}
                              ...                    expected_status=anything
    Set Test Variable         ${RESPONSE}

Send DELETE Request To ${URI}
    ${TOKEN} =                Get Variable Value     $TOKEN        ${EMPTY}
    IF  "${TOKEN}" != "${EMPTY}"
        ${TOKEN} =            Create Dictionary      authorization=${TOKEN}
    END
    ${RESPONSE} =             DELETE                 ${URL}${URI}
                              ...                    timeout=1
                              ...                    expected_status=anything
                              ...                    headers=${TOKEN}
    Set Test Variable         ${RESPONSE}
