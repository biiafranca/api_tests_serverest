*** Settings ***
Library                    RequestsLibrary
Resource                   generate_random_data.resource
Resource                   manipulate_data.resource

*** Variables ***
${URL}               https://serverest.dev

*** Keywords ***
Send GET Request to ${URI}
    ${RESPONSE} =             GET                    ${URL}${URI}
                              ...                    timeout=1
                              ...                    expected_status=anything
    Set Test Variable         ${RESPONSE}

Send POST Request to ${URI} With Valid Body
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

Send POST Request to ${URI} Removing Key ${KEY} From Body
    ${REQUEST_BODY} =         Set Request Body ${REQUEST_BODY} Without ${KEY}
    ${RESPONSE} =             POST                   ${URL}${URI}
                              ...                    timeout=1
                              ...                    json=${REQUEST_BODY}
                              ...                    expected_status=anything
    Set Test Variable         ${RESPONSE}

Send POST Request to ${URI} With Key ${KEY} Containing Value "${VALUE}"
    ${REQUEST_BODY} =         Set Request Body ${REQUEST_BODY} Changing Value Of Key ${KEY} To ${VALUE}
    ${RESPONSE} =             POST                   ${URL}${URI}
                              ...                    timeout=1
                              ...                    json=${REQUEST_BODY}
                              ...                    expected_status=anything
    Set Test Variable         ${RESPONSE}

Send PUT Request to ${URI} With Valid Body
    ${RESPONSE} =             PUT                    ${URL}${URI}
                              ...                    timeout=1
                              ...                    json=${REQUEST_BODY}
                              ...                    expected_status=anything
    Set Test Variable         ${RESPONSE}

Send PUT Request to ${URI} Removing Key ${KEY} From Body
    ${REQUEST_BODY} =         Set Request Body ${REQUEST_BODY} Without ${KEY}
    ${RESPONSE} =             PUT                    ${URL}${URI}
                              ...                    timeout=1
                              ...                    json=${REQUEST_BODY}
                              ...                    expected_status=anything
    Set Test Variable         ${RESPONSE}

Send PUT Request to ${URI} With Key ${KEY} Containing Value ${VALUE}
    ${REQUEST_BODY} =         Set Request Body ${REQUEST_BODY} Changing Value Of Key ${KEY} To ${VALUE}
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
