*** Settings ***
Library    SeleniumLibrary
Resource        ../Data/Variables.robot
Resource        ../Resources/Keywords.robot

*** Test Cases ***
CP01 Alta De Producto Exitosa
    [Documentation]    Verifica el registro exitoso de un producto
    Abrir navegador en login
    Iniciar sesion
    Click Button       xpath=//button[contains(text(), 'Nuevo Producto')]
    Wait Until Element Is Visible    xpath=//h2[contains(text(),"Agregar Nuevo Producto")]
    Llenar formulario nuevo producto 1    ${NOMBRE_PRODUCTO}    ${SKU}    ${CODIGO_BARRAS}    ${MARCA}    ${CATEGORIA}    ${SUBCATEGORIA}    ${PRECIO}    ${STOCK}    ${STOCK_MIN}    ${DESCRIPCION}    ${ATRIBUTO_1}    ${VALOR_1}    ${ATRIBUTO_2}    ${VALOR_2}    ${ATRIBUTO_3}    ${VALOR_3}    ${URL_FOTO}
    Click Button    xpath=//button[text()="Guardar Producto"]
    Wait Until Page Contains    ¡Producto Agregado!
    Click Button    xpath=//button[contains(text(),"Ir al Catálogo")]
    Page Should Contain    ${NOMBRE_PRODUCTO}
    Page Should Contain    ${PRECIO}
    Page Should Contain    ${MARCA}
    Page Should Contain    ${CATEGORIA}
    Page Should Contain    ${SUBCATEGORIA}
    Page Should Contain    ${STOCK}
    Page Should Contain    ${SKU}
    
CP02 Editar Producto Exitoso
    [Documentation]    Verifica la edición de marca, categoría o precio
    Abrir navegador en login
    Iniciar sesion
    Wait Until Page Contains    ${NOMBRE_PRODUCTO}
    Click Element    xpath=//tr[contains(., '${NOMBRE_PRODUCTO}')]//button[@title="Editar"]
    Wait Until Element Is Visible    xpath=//h2[contains(text(),"Editar Producto")]
    Page Should Contain        ${NOMBRE_PRODUCTO}
    Page Should Contain       ${SKU}
    Page Should Contain      ${CODIGO_BARRAS}
    Page Should Contain      ${MARCA}
    Page Should Contain      ${CATEGORIA}
    Page Should Contain      ${SUBCATEGORIA}
    Page Should Contain      ${PRECIO}
    Page Should Contain      ${STOCK}
    Page Should Contain      ${STOCK_MIN}
    Page Should Contain      ${DESCRIPCION}
    Page Should Contain      ${ATRIBUTO_1}
    Page Should Contain      ${ATRIBUTO_2}
    Page Should Contain      ${ATRIBUTO_3}
    Click Button    id=marca
    Wait Until Page Contains    Agregar Marca
    Input Text    id=marca-input    Shimano
    Click Button    xpath=//button[text()="Guardar"]
    Click Button    id=categoria
    Wait Until Page Contains    Agregar Categoría
    Input Text    id=categoría-input    ${categoria}
    Click Button    xpath=//button[text()="Guardar"]
    Click Button    id=subcategoria
    Wait Until Page Contains    Agregar Subcategoría
    Select From List By Value    id=categoriaPadre     ${categoria}
    Input Text    id=subcategoría-input    Híbrida
    Click Button    xpath=//button[text()="Guardar"]
    Input Text    id=precio    27600
    Click Button    xpath=//button[text()="Guardar Cambios"]
    Wait Until Page Contains    Cambios Guardados
    Click Button    xpath=//button[contains(text(),"Entendido")]

CP03 Buscar Producto Exitosa
    [Documentation]    Filtra la lista tecleando en la barra de búsqueda
    Abrir navegador en login
    Iniciar sesion
    Wait Until Page Contains    ${NOMBRE_PRODUCTO}
    Input Text      id=searchBar    xt
    Wait Until Element Is Visible    xpath=//tr[contains(., '${NOMBRE_PRODUCTO}')]
    Element Should Be Visible        xpath=//tr[contains(., '${NOMBRE_PRODUCTO}')]

CP04 Filtrar Producto Exitosa
    [Documentation]    Usa botones de filtro rápido (Stock bajo, Categoría)
    Abrir navegador en login
    Iniciar sesion
    Wait Until Page Contains    ${NOMBRE_PRODUCTO}
    Click Button    xpath=//button[contains(text(),"Stock crítico")]
    Wait Until Page Contains    CRÍTICO
    Page Should Not Contain    NORMAL

CP06 Desactivar Producto Exitosa
    [Documentation]    Cambia el estado de un producto activo a inactivo
    Abrir navegador en login
    Iniciar sesion
    Wait Until Page Contains    ${NOMBRE_PRODUCTO}
    Click Element    xpath=//tr[contains(., '${NOMBRE_PRODUCTO}')]//div[@id="estadoProducto"]//div[@role='switch']
    ${estado}=    Get Element Attribute    xpath=//div[@id='estadoProducto']//div[@role='switch']    aria-checked
    Should Be Equal As Strings    ${estado}    false

CP11 Activar Producto Exitosa
    [Documentation]    Cambia el estado de un producto inactivo a activo
    Abrir navegador en login
    Iniciar sesion
    Wait Until Page Contains    ${NOMBRE_PRODUCTO}
    Click Element    xpath=//tr[contains(., '${NOMBRE_PRODUCTO}')]//div[@id="estadoProducto"]//div[@role='switch']
    ${estado}=    Get Element Attribute    xpath=//div[@id='estadoProducto']//div[@role='switch']    aria-checked
    Should Be Equal As Strings    ${estado}    true

CP08 Agregar Producto Con Campos Vacios
    [Documentation]    Verifica mensajes de error en campos obligatorios
    Abrir navegador en login
    Iniciar sesion
    Click Button       xpath=//button[contains(text(), 'Nuevo Producto')]
    Wait Until Element Is Visible    xpath=//h2[contains(text(),"Agregar Nuevo Producto")]
    Click Button    xpath=//button[text()="Guardar Producto"]
    Page Should Not Contain    ¡Producto Agregado!
    Page Should Contain    El nombre es requerido
    Page Should Contain    El SKU es requerido
    Page Should Contain    El código de barras es requerido

CP09 Editar Producto Con Campos Vacios
    [Documentation]    Verifica error al ingresar valores negativos en precio/stock
    Abrir navegador en login
    Iniciar sesion
    Wait Until Page Contains    ${NOMBRE_PRODUCTO}
    Click Element    xpath=//tr[contains(., '${NOMBRE_PRODUCTO}')]//button[@title="Editar"]
    Wait Until Element Is Visible    xpath=//h2[contains(text(),"Editar Producto")]
    Input Text    id=nombreProducto    "
    Press Keys    id=nombreProducto   BACKSPACE
    Input Text    id=sku    "
    Press Keys    id=sku    BACKSPACE
    Input Text    id=codigoBarras    "
    Press Keys    id=codigoBarras    BACKSPACE
    Click Button    xpath=//button[text()="Guardar Cambios"]
    Page Should Contain    El nombre es requerido
    Page Should Contain    El SKU es requerido
    Page Should Contain    El código de barras es requerido

CP10 Agregar Producto Ya Registrado
    [Documentation]    Verifica que no se repitan SKU, nombres o códigos
    Abrir navegador en login
    Iniciar sesion
    Click Button       xpath=//button[contains(text(), 'Nuevo Producto')]
    Wait Until Element Is Visible    xpath=//h2[contains(text(),"Agregar Nuevo Producto")]
    Llenar formulario nuevo producto 1    ${NOMBRE_PRODUCTO}    ${SKU}    ${CODIGO_BARRAS}    ${MARCA}    ${CATEGORIA}    ${SUBCATEGORIA}    ${PRECIO}    ${STOCK}    ${STOCK_MIN}    ${DESCRIPCION}    ${ATRIBUTO_1}    ${VALOR_1}    ${ATRIBUTO_2}    ${VALOR_2}    ${ATRIBUTO_3}    ${VALOR_3}    ${URL_FOTO}
    Click Button    xpath=//button[text()="Guardar Producto"]
    Page Should Not Contain    ¡Producto Agregado!
    Wait Until Page Contains    nombre ya existe
    Wait Until Page Contains    código de barras ya existe
    Wait Until Page Contains    SKU ya existe

CP07 Eliminar Producto asociado Venta
    [Documentation]    Verifica que el sistema impide borrar productos con historial
    Abrir navegador en login
    Iniciar sesion
    Wait Until Page Contains    ${NOMBRE_PRODUCTO}
    Click Element    xpath=//tr[contains(., '${NOMBRE_PRODUCTO}')]//button[@title="Eliminar"]
    Wait Until Page Contains    ¿Eliminar Producto?
    Click Button    xpath=//button[text()="Eliminar"]
    Wait Until Page Contains    Error de Eliminación

CP05 Eliminar Producto Exitoso
    [Documentation]    Verifica eliminación tras confirmación
    Abrir navegador en login
    Iniciar sesion
    Wait Until Page Contains    ${NOMBRE_PRODUCTO}
    Click Element    xpath=//tr[contains(., '${NOMBRE_PRODUCTO}')]//button[@title="Eliminar"]
    Wait Until Page Contains    ¿Eliminar Producto?
    Click Button    xpath=//button[text()="Eliminar"]
    Wait Until Page Contains    Producto Eliminado
    Click Button    xpath=//button[contains(text(),"Continuar")]
    Page Should Not Contain    ${NOMBRE_PRODUCTO}