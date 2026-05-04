*** Settings ***
Library    SeleniumLibrary
Library    Process
Resource        ../Data/Variables.robot
Resource        ../Resources/Keywords.robot

*** Test Cases ***
CP01: Registro de venta exitosa
    [Documentation]    Verificar que el sistema permite procesar la compra de un cliente, calcular totales y registrar el cobro correctamente.
    Abrir navegador en login
    Iniciar sesion
    Wait Until Element Is Visible     //h1[contains(.,'Gestión de Catálogo')]   5s
    Click Element    //a[@href='/pos']

    Wait Until Element Is Visible    xpath=//div[contains(@class,'overflow-y-auto px-6')]    5s
    Element Should Be Visible    xpath=//*[contains(text(),'Carrito vacío') or contains(text(),'carrito vacío')]

    Agregar producto al carrito    ${PRODUCTO_VENTA_1}
    #modificar esa unidad. ahorita como no se actualiza lo deje asi
    Element Should Contain    xpath=//div[contains(.,'${PRODUCTO_VENTA_1}')]//span[contains(@class,'absolute top-2')]    12 u.
    Sleep    1s

    Element Should Contain    xpath=//*[contains(text(),'IVA (16%)')]/following-sibling::*    $192.00
    Element Should Contain    xpath=//*[contains(text(),'Subtotal')]/following-sibling::*    $1,200.00
    Element Should Contain    xpath=//*[contains(text(),'Total')]/following-sibling::*    $1,392.00

    Click Element    xpath=//button[contains(.,'EFECTIVO')]
    Click Element    xpath=//button[contains(.,'Cobrar')]

    #falta. no hay lógica que al picarle salga un modal y el carrito se limpie.

    Close Browser

CP02: Modificar cantidades y eliminar desde el carrito
    [Documentation]    Verificar que se pueden ajustar las unidades de un producto o removerlo totalmente del carrito.
    Abrir navegador en login
    Iniciar sesion
    Wait Until Element Is Visible     //h1[contains(.,'Gestión de Catálogo')]   5s
    Click Element    //a[@href='/pos']

    Wait Until Element Is Visible    xpath=//div[contains(@class,'overflow-y-auto px-6')]    5s
    Element Should Be Visible    xpath=//*[contains(text(),'Carrito vacío') or contains(text(),'carrito vacío')]

    Agregar producto al carrito    ${PRODUCTO_VENTA_1}
    #modificar esa unidad. ahorita como no se actualiza lo deje asi
    Element Should Contain    xpath=//div[contains(.,'${PRODUCTO_VENTA_1}')]//span[contains(@class,'absolute top-2')]    12 u.
    Sleep    1s

    Element Should Contain    xpath=//*[contains(text(),'IVA (16%)')]/following-sibling::*    $192.00
    Element Should Contain    xpath=//*[contains(text(),'Subtotal')]/following-sibling::*    $1,200.00
    Element Should Contain    xpath=//*[contains(text(),'Total')]/following-sibling::*    $1,392.00

    Click Element    xpath=//button[@class and contains(@class,'w-6 h-6 rounded-md') and normalize-space()='+']
    Sleep    1s

    Element Should Contain    xpath=//*[contains(text(),'IVA (16%)')]/following-sibling::*    $384.00
    Element Should Contain    xpath=//*[contains(text(),'Subtotal')]/following-sibling::*    $2,400.00
    Element Should Contain    xpath=//*[contains(text(),'Total')]/following-sibling::*    $2,784.00

    Click Element    xpath=//button[contains(@class,'w-6 h-6 rounded-md border border-gray-200') and normalize-space()='-']
    Sleep    1s
    Click Element    xpath=//button[contains(@class,'w-6 h-6 rounded-md border border-gray-200') and normalize-space()='-']
    Sleep    1s

    Element Should Be Visible    xpath=//*[contains(text(),'Carrito vacío')]
    Element Should Contain    xpath=//*[contains(text(),'IVA (16%)')]/following-sibling::*    $0.00
    Element Should Contain    xpath=//*[contains(text(),'Subtotal')]/following-sibling::*    $0.00
    Element Should Contain    xpath=//*[contains(text(),'Total')]/following-sibling::*    $0.00
    Close Browser

CP03: Limpiar carrito de compras
    [Documentation]    Verificar que se pueden quitar todos los elementos del carrito simultáneamente.
    Abrir navegador en login
    Iniciar sesion
    Wait Until Element Is Visible     //h1[contains(.,'Gestión de Catálogo')]   5s
    Click Element    //a[@href='/pos']

    Wait Until Element Is Visible    xpath=//div[contains(@class,'overflow-y-auto px-6')]    5s
    Element Should Be Visible    xpath=//*[contains(text(),'Carrito vacío') or contains(text(),'carrito vacío')]

    Agregar producto al carrito    ${PRODUCTO_VENTA_1}
    Agregar producto al carrito    ${PRODUCTO_VENTA_2}

    Click Element    xpath=//button[text()='Limpiar']
    Element Should Be Visible    xpath=//*[contains(text(),'Carrito vacío')]

    Close Browser

CP04: Producto sin stock disponible
    [Documentation]    Verificar que el sistema bloquea la venta de productos agotados.
    Abrir navegador en login
    Iniciar sesion
    Wait Until Element Is Visible     //h1[contains(.,'Gestión de Catálogo')]   5s
    Click Element    //a[@href='/pos']

    Wait Until Element Is Visible    xpath=//div[contains(@class,'overflow-y-auto px-6')]    5s
    Element Should Be Visible    xpath=//*[contains(text(),'Carrito vacío') or contains(text(),'carrito vacío')]

    #falta. todavia no se ven los productos de la base de datos (son mock)

    Close Browser

CP05: Producto no encontrado
    [Documentation]    Verificar la respuesta del sistema ante búsquedas fallidas.
    Abrir navegador en login
    Iniciar sesion
    Wait Until Element Is Visible     //h1[contains(.,'Gestión de Catálogo')]   5s
    Click Element    //a[@href='/pos']
    Wait Until Element Is Visible    css=input[placeholder*='Buscar']    5s
    Click Element    css=input[placeholder*='Buscar']
    Input Text    css=input[placeholder*='Buscar']    ${PRODUCTO_INEXISTENTE}
    Wait Until Element Is Visible    xpath=//*[contains(text(),'No se encontraron productos')]
    Close Browser

CP06: Venta con carrito vacío
    [Documentation]    Verificar que no se permite cobrar sin productos en el carrito.
    Abrir navegador en login
    Iniciar sesion
    Wait Until Element Is Visible     //h1[contains(.,'Gestión de Catálogo')]   5s
    Click Element    //a[@href='/pos']
    Wait Until Element Is Visible    css=input[placeholder*='Buscar']    5s
    Wait Until Element Is Visible    xpath=//button[contains(.,'Cobrar')]    5s
    Element Should Be Disabled    xpath=//button[contains(.,'Cobrar')]
    Close Browser