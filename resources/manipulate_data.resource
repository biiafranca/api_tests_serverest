*** Settings ***
Library              Collections


*** Keywords ***
Set Request Body ${BODY} Without ${KEY}
    ${NEW_BODY} =                Copy Dictionary
    ...                          ${BODY}              deepcopy=True
    Remove From Dictionary       ${NEW_BODY}          ${KEY}
    [Return]                     ${NEW_BODY}

Set Request Body ${BODY} Changing Value Of Key ${TARGET_KEY} To ${NEW_VALUE}
    ${NEW_BODY} =                Copy Dictionary
    ...                          ${BODY}              deepcopy=True
    Remove From Dictionary       ${NEW_BODY}          ${TARGET_KEY}
    Set To Dictionary            ${NEW_BODY}
    ...                          ${TARGET_KEY}        ${NEW_VALUE}
    [Return]                     ${NEW_BODY}
