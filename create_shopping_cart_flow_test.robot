*** Settings ***
Resource         resources/send_request_to_api.resource
Resource         resources/analyze_api_response.resource
Resource         resources/generate_random_data.resource


*** Test Cases ***
Shopping Cart Flow
    Given New Administrator User Is Created
    And Perform Login As New User
    And Register Two New Products
    When Add Created Products To Cart
    And Finish Cart To Buy Itens
    Then Items Should Have Been Deducted From The Quantity Of Products


*** Keywords ***
New Administrator User Is Created
    Generate A Valid User to Request Body
    Send POST Request to /usuarios With Key ${ADM_KEY} Containing Value "true"
    Status Code Should Be "201"
    Set Suite Variable         ${EMAIL}       ${REQUEST_BODY}[${EMAIL_KEY}]
    Set Suite Variable         ${PASSWORD}    ${REQUEST_BODY}[${PASSWORD_KEY}]

Perform Login As New User
    Generate Login Body With ${EMAIL} And ${PASSWORD}
    Send POST Request To /login With Valid Body
    Status Code Should Be "200"
    Set Suite Variable         ${TOKEN}       ${RESPONSE.json()}[${AUTH_KEY}]

Register Two New Products
    Generate A Valid Product to Request Body
    Send POST Request To /produtos With Valid Body
    Status Code Should Be "201"
    Set Suite Variable         ${FIRST_PRODUCT}                ${RESPONSE.json()}[${ID_KEY}]
    Set Suite Variable         ${FIRST_PRODUCT_QUANTITY}       ${REQUEST_BODY}[${QUANTITY_KEY}]
    Generate A Valid Product to Request Body
    Send POST Request To /produtos With Valid Body
    Status Code Should Be "201"
    Set Suite Variable         ${SECOND_PRODUCT}                ${RESPONSE.json()}[${ID_KEY}]
    Set Suite Variable         ${SECOND_PRODUCT_QUANTITY}       ${REQUEST_BODY}[${QUANTITY_KEY}]

Add Created Products To Cart
    Generate A Valid Cart With Items ${FIRST_PRODUCT} And ${SECOND_PRODUCT} To Request Body
    Send POST Request To /carrinhos With Valid Body
    Status Code Should Be "201"
    Set Suite Variable          ${CART_ID}            ${RESPONSE.json()}[${ID_KEY}]

Finish Cart To Buy Itens
    Send DELETE Request To /carrinhos/concluir-compra
    Status Code Should Be "200"

Items Should Have Been Deducted From The Quantity Of Products
    Send GET Request to /produtos/${FIRST_PRODUCT}
    ${NEW_FIRST_PRODUCT_QUANTITY} =        Evaluate     $FIRST_PRODUCT_QUANTITY-1
    Should Be Equal As Integers            ${RESPONSE.json()}[${QUANTITY_KEY}]
    ...                                    ${NEW_FIRST_PRODUCT_QUANTITY}
    Send GET Request to /produtos/${SECOND_PRODUCT}
    ${NEW_SECOND_PRODUCT_QUANTITY} =       Evaluate     $SECOND_PRODUCT_QUANTITY-1
    Should Be Equal As Integers            ${RESPONSE.json()}[${QUANTITY_KEY}]
    ...                                    ${NEW_SECOND_PRODUCT_QUANTITY}