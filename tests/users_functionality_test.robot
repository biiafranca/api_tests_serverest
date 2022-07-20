*** Settings ***
Resource         ../resources/send_request_to_api.resource
Resource         ../resources/analyze_api_response.resource

Force Tags       robot:continue-on-failure


*** Test Cases ***
GET Request Contains Return
    When Send GET Request To /usuarios
    Then Status Code Should Be "200"
    And Body Response Not Should Be Empty

GET Request Contains Required Keys In Response Body
    When Send GET Request To /usuarios
    Then Body Response Contains "quantidade"
    And Body Response Contains "usuarios"

GET Request Informs Correct Quantity
    When Send GET Request To /usuarios
    Then Value Of "quantidade" Is Equal Of List "usuarios" Size

GET Request Contains All Users With Required Infos
    When Send GET Request To /usuarios
    Then All Elements Of List "usuarios" Contains The Required Info

POST Request Contains Return
    Given Generate A Valid User to Request Body
    When Send POST Request to /usuarios With Valid Body
    Then Status Code Should Be "201"
    And Body Response Not Should Be Empty

POST Request Contains Required Content In Response Body
    Given Generate A Valid User to Request Body
    When Send POST Request to /usuarios With Valid Body
    Then Body Response Contains "message"
    And Body Response Contains "_id"
    And Body Response Contains Message "Cadastro realizado com sucesso"

POST Request Without Required User Name
    Given Generate A Valid User to Request Body
    When Send POST Request to /usuarios Removing Key ${NAME_KEY} From Body
    And Status Code Should Be "400"

POST Request With Invalid E-mail
    Given Generate A Valid User to Request Body
    When Send POST Request to /usuarios With Key ${EMAIL_KEY} Containing Value "ThisIsAnInvalidEmail"
    And Status Code Should Be "400"

GET Request Of Created User
    Given Generate A Valid User to Request Body
    And Send POST Request to /usuarios With Valid Body
    And Identify ID Of Created Resource
    When Send GET Request To /usuarios/${TEST_ID}
    Then Status Code Should Be "200"

DELETE Request Of Created User
    Given Generate A Valid User to Request Body
    And Send POST Request to /usuarios With Valid Body
    And Identify ID Of Created Resource
    When Send DELETE Request To /usuarios/${TEST_ID}
    Then Status Code Should Be "200"
    When Send GET Request To /usuarios/${TEST_ID}
    Then Status Code Should Be "400"

PUT Request Contains Return
    Given Generate A Valid User to Request Body
    And Send POST Request to /usuarios With Valid Body
    And Identify ID Of Created Resource
    When Send PUT Request to /usuarios/${TEST_ID} With Valid Body
    Then Status Code Should Be "200"
    And Body Response Not Should Be Empty

PUT Request Contains Required Content In Response Body
    Given Generate A Valid User to Request Body
    And Send POST Request to /usuarios With Valid Body
    And Identify ID Of Created Resource
    When Send PUT Request to /usuarios/${TEST_ID} With Valid Body
    Then Body Response Contains "message"
    And Body Response Contains Message "Registro alterado com sucesso"
