*** Settings ***
Library      FakerLibrary


*** Variables ***
# Generic Keys
${NAME_KEY}              nome

# Users Keys
${ID_KEY}                _id
${EMAIL_KEY}             email
${PASSWORD_KEY}          password
${ADM_KEY}               administrador

# Product Keys
${PRICE_KEY}             preco
${DESCRIPTION_KEY}       descricao
${QUANTITY_KEY}          quantidade
${PRODUCT_ID_KEY}        idProduto
${PRODUCTS_KEY}          produtos

# Login Keys
${AUTH_KEY}              authorization

*** Keywords ***
Generate Random Name
    ${RANDOM_NAME} =                FakerLibrary.User Name
    [Return]                        ${RANDOM_NAME}

Generate Random E-mail
    ${RANDOM_EMAIL} =               FakerLibrary.Email
    [Return]                        ${RANDOM_EMAIL}

Generate Random Password
    ${RANDOM_PASSWORD} =            FakerLibrary.Password
    ...                             special_chars=False
    [Return]                        ${RANDOM_PASSWORD}

Generate Random Administrator
    @{VALID_OPTIONS_LIST} =          Create List           true          false
    ${CHOSEN_OPTION_INDEX} =         FakerLibrary.Pyint    min_value=0   max_value=1
    ${RANDOM_ADM} =                  Set Variable          ${VALID_OPTIONS_LIST}[${CHOSEN_OPTION_INDEX}]
    [Return]                         ${RANDOM_ADM}

Generate Random Description
    ${RANDOM_DESCRIPTION} =          FakerLibrary.Sentence
    [Return]                         ${RANDOM_DESCRIPTION}

Generate Random Integer
    ${RANDOM_QUANTITY} =             FakerLibrary.Pyint
    [Return]                         ${RANDOM_QUANTITY}

Generate A Valid User to Request Body
    ${NAME_VALUE} =                  Generate Random Name
    ${EMAIL_VALUE} =                 Generate Random E-mail
    ${PASSWORD_VALUE} =              Generate Random Password
    ${ADM_VALUE} =                   Generate Random Administrator
    ${REQUEST_BODY} =                Create Dictionary
    ...                              ${NAME_KEY}=${NAME_VALUE}
    ...                              ${EMAIL_KEY}=${EMAIL_VALUE}
    ...                              ${PASSWORD_KEY}=${PASSWORD_VALUE}
    ...                              ${ADM_KEY}=${ADM_VALUE}
    Set Test Variable                ${REQUEST_BODY}

Generate Login Body With ${REQUEST_EMAIL} And ${REQUEST_PASSWORD}
    ${REQUEST_BODY} =                Create Dictionary
    ...                              ${EMAIL_KEY}=${REQUEST_EMAIL}
    ...                              ${PASSWORD_KEY}=${REQUEST_PASSWORD}
    Set Test Variable                ${REQUEST_BODY}

Generate A Valid Product to Request Body
    ${NAME_VALUE} =                  Generate Random Name
    ${PRICE_VALUE} =                 Generate Random Integer
    ${DESCRIPTION_VALUE} =           Generate Random Description
    ${QUANTITY_VALUE} =              Generate Random Integer
    ${REQUEST_BODY} =                Create Dictionary
    ...                              ${NAME_KEY}=${NAME_VALUE}
    ...                              ${PRICE_KEY}=${PRICE_VALUE}
    ...                              ${DESCRIPTION_KEY}=${DESCRIPTION_VALUE}
    ...                              ${QUANTITY_KEY}=${QUANTITY_VALUE}
    Set Test Variable                ${REQUEST_BODY}

Generate A Valid Cart With Items ${FIRST_PRODUCT} And ${SECOND_PRODUCT} To Request Body
    ${PRODUCT_LIST} =                Create List
    FOR    ${PRODUCT}    IN    ${FIRST_PRODUCT}    ${SECOND_PRODUCT}
        ${PRODUCT_DICT} =            Create Dictionary
        ...                          ${PRODUCT_ID_KEY}=${PRODUCT}
        ...                          ${QUANTITY_KEY}=${1}
        Append To List               ${PRODUCT_LIST}          ${PRODUCT_DICT}
    END
    ${REQUEST_BODY} =                Create Dictionary
    ...                              ${PRODUCTS_KEY}=${PRODUCT_LIST}
    Set Test Variable                ${REQUEST_BODY}