*** Settings ***
Library    SeleniumLibrary
Library    Process
Resource        ../Data/Variables.robot
Resource        ../Resources/Keywords.robot

*** Test Cases ***
CP01: Inicio de sesión exitoso
    [Documentation]    Verifica acceso con credenciales correctas
    Abrir navegador en login
    Ingresar credenciales    ${USER_VALIDO}    ${PASS_VALIDA}
    Wait Until Page Contains  Gestión de Catálogo
    Close Browser

CP02: Visualizar contraseña
    [Documentation]    Verifica que el icono de ojo muestra el texto plano
    Abrir navegador en login
    Input Text               id=password    ${PASS_VALIDA}
    Element Attribute Value Should Be    id=password    type    password
    Click Element            xpath=//button[@aria-label="Mostrar contraseña"]
    Element Attribute Value Should Be    id=password    type    text
    Close Browser


CP03: Iniciar sesión con campos en blanco
    [Documentation]    Verifica validación de campos obligatorios
    Abrir navegador en login
    Click Element       xpath=//span[contains(text(),"Ingresar")]
    Wait Until Page Contains  Todos los campos deben ser llenados
    Close Browser


CP04: Iniciar sesión con credenciales incorrectas
    [Documentation]    Verifica rechazo de acceso por datos erróneos
    Abrir navegador en login
    Ingresar credenciales    ${USER_INVALIDO}    ${PASS_INVALIDA}
    Wait Until Page Contains  Usuario o contraseña incorrectos
    Close Browser

CP05: Olvido de contraseña
    [Documentation]    Verifica el mensaje de contacto al administrador
    Abrir navegador en login
    Click Element            xpath=//a[contains(text(), "¿Olvidó su contraseña?")]
    Wait Until Page Contains  debe contactar al administrador
    Click Button             xpath=//button[text()='Cerrar']
    Close Browser


