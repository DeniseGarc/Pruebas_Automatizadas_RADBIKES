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

    Click Button       id=guardar_producto
    Element Should Contain    id=mensaje-exito    producto ha sido dado de alta correctamente

CP02 Editar Producto Exitoso
    [Documentation]    Verifica la edición de marca, categoría o precio
    Click Element      xpath=//table/tbody/tr[1]//button[@class='btn-edit']
    Input Text         id=precio_venta    1800.00
    Click Button       id=guardar_cambios
    Page Should Contain    1800.00

CP03 Buscar Producto Exitosa
    [Documentation]    Filtra la lista tecleando en la barra de búsqueda
    Input Text      id=search_bar    MTB Pro
    Wait Until Element Is Visible    xpath=//td[contains(text(), 'MTB Pro')]
    Element Should Be Visible        xpath=//td[contains(text(), 'MTB Pro')]

CP04 Filtrar Producto Exitosa
    [Documentation]    Usa botones de filtro rápido (Stock bajo, Categoría)
    Click Button    id=filter_stock_bajo
    Wait Until Page Contains    Estado: STOCK BAJO
    Element Should Not Contain    id=lista_productos    NORMAL

CP05 Eliminar Producto Exitoso
    [Documentation]    Verifica eliminación tras confirmación
    Click Element      xpath=//table/tbody/tr[1]//button[@class='btn-delete']
    Wait Until Page Contains    ¿Desea eliminar este producto?
    Click Button       id=confirmar_eliminacion
    Page Should Not Contain    Bicicleta Pro

CP06 Eliminar Producto Exitosa
    [Documentation]    Cambia el estado de un producto activo a inactivo

    Wait Until Element Is Visible    xpath=//span[contains(text(), 'INACTIVO')]

CP07 Eliminar Producto asociado Venta
    [Documentation]    Verifica que el sistema impide borrar productos con historial
    Seleccionar Accion Eliminar En Producto    "Bicicleta Vendida"
    Confirmar Dialogo De Eliminacion
    Wait Until Page Contains    no es posible eliminar el producto

CP08 Agregar Producto Con Campos Vacios
    [Documentation]    Verifica mensajes de error en campos obligatorios
    Click Button       xpath=//button[contains(text(), 'Nuevo Producto')]
    Click Button       id=guardar_producto
    Element Should Be Visible    xpath=//span[contains(text(), 'campo obligatorio')]

CP09 Editar Producto Con Campos Vacios
    [Documentation]    Verifica error al ingresar valores negativos en precio/stock
    Seleccionar Accion Editar En Producto    ${PRODUCTO_EXISTENTE}
    Input Text      id=precio_venta    -500
    Click Button    id=guardar_cambios
    Wait Until Page Contains    mensaje informativo en el campo

CP10 Agregar Producto Ya Registrado
    [Documentation]    Verifica que no se repitan SKU, nombres o códigos
    Seleccionar Nuevo Producto

    Click Button    id=guardar_producto
    Wait Until Page Contains    SKU ya existe
