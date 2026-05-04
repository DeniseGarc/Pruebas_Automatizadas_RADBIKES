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
    Wait Until Page Contains    Gestión de Catálogo

Llenar formulario nuevo producto 1
    [Arguments]     ${nombre_producto}  ${sku}  ${codigo_barras}    ${marca}    ${categoria}    ${subcategoria}     ${precio}   ${stock_inicial}    ${stock_min}    ${descripcion}   ${atributo1}     ${valor1}   ${atributo2}     ${valor2}     ${atributo3}     ${valor3}       ${imagen}
    Input Text    id=nombreProducto    ${nombre_producto}
    Input Text    id=sku    ${sku}
    Input Text    id=codigoBarras    ${codigo_barras}

    Click Button    id=marca
    Wait Until Page Contains    Agregar Marca
    Input Text    id=marca-input    ${marca}
    Click Button    xpath=//button[text()="Guardar"]


    Click Button    id=categoria
    Wait Until Page Contains    Agregar Categoría
    Input Text    id=categoría-input    ${categoria}
    Click Button    xpath=//button[text()="Guardar"]


    Click Button    id=subcategoria
    Wait Until Page Contains    Agregar Subcategoría
    Select From List By Value    id=categoriaPadre     ${categoria}
    Input Text    id=subcategoría-input    ${subcategoria}
    Click Button    xpath=//button[text()="Guardar"]

    Input Text    id=precio    ${precio}
    Input Text    id=stock    ${stock_inicial}
    Input Text    id=stockMin    ${stock_min}
    Input Text    id=descripcion    ${descripcion}

    Agregar atributo producto     ${atributo1}   ${valor1}
    Agregar atributo producto     ${atributo2}   ${valor2}
    Agregar atributo producto     ${atributo3}   ${valor3}

    Click Element    id=subirImagen
    Choose File     id=image    ${URL_FOTO}

Agregar atributo producto
    [Arguments]     ${atributo}     ${valor}
    Input Text    id=atributo    ${atributo}
    Input Text    id=valor     ${valor}
    Click Button    id=agregar

Agregar producto al carrito
    [Arguments]    ${producto}
    Input Text    css=input[placeholder*='Buscar']    ${producto}
    Wait Until Element Is Visible    xpath=//div[contains(.,'${producto}')]    2s
    Click Element    xpath=(//div[contains(.,'${producto}')]//button[contains(@class,'w-7 h-7')])[last()]
    Wait Until Element Is Not Visible    xpath=//*[contains(text(),'Carrito vacío')]    5s
