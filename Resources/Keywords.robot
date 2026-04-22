*** Settings ***
Library    SeleniumLibrary
Resource        ../Data/Variables.robot

*** Keywords ***
Abrir navegador en login
    Open Browser    ${URL}    ${BROWSER}   options=add_argument('--incognito')

Ingresar credenciales
    [Arguments]     ${usuario}       ${contraseña}
    Input Text    id=username    ${usuario}
    Input Text    id=password    ${contraseña}
    Click Element             xpath=//span[contains(text(),"Ingresar")]

Iniciar sesion
    Input Text    id=username    ${USER_VALIDO}
    Input Text    id=password    ${PASS_VALIDA}
    Click Element             xpath=//span[contains(text(),"Ingresar")]

Llenar formulario producto
    [Arguments]     ${nombre_producto}  ${sku}  ${codigo_barras}    ${marca}    ${categoria}    ${subcategoria}     ${precio}   ${stock_inicial}    ${stock_min}    ${descripcion}   ${atributo}     ${valor}
    Input Text    id=nombreProducto    ${nombre_producto}
    Input Text    id=sku    ${sku}
    Input Text    id=precio    ${precio}
    Input Text    id=stockInicial    ${stock_inicial}
    Input Text    id=stockMin    ${stock_min}
    Input Text    id=descripcion    ${descripcion}
    Agregar atributo producto     ${atributo}   ${valor}


Agregar atributo producto
    [Arguments]     ${atributo}     ${valor}
    Input Text    id=atributo    ${atributo}
    Input Text    id=valor     ${valor}

Seleccionar Nuevo Producto
    Click Button    xpath=//button[contains(text(), 'Nuevo Producto')]
    Wait Until Element Is Visible    id=modal-alta

Seleccionar Accion Editar En Producto
    [Arguments]    ${nombre_prod}
    Click Element    xpath=//tr[contains(., ${nombre_prod})]//button[@title='Editar']

Seleccionar Accion Eliminar En Producto
    [Arguments]    ${nombre_prod}
    Click Element    xpath=//tr[contains(., ${nombre_prod})]//button[@title='Editar']

Confirmar Dialogo De Eliminacion
    Wait Until Element Is Visible    id=confirm-dialog
    Click Button    id=btn-confirmar-eliminar
