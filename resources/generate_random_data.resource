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
    