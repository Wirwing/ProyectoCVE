# Proyecto CVE

Proyecto Aplicativo AJAX. Tecnologías usadas:

- AngularJS.
- Slim Framework.

## Instalación de herramientas

- Instalar un servidor *AMP.
- Instalar servidor MySQL.
- Instalar git.
- Instalar npm y node (<http://nodejs.org>
- Instalar composer (<http://getcomposer.org/doc/00-intro.md#installation>)
- Instalar Bower (<http://bower.io>)

*Agregar git, npm, composer y bower al PATH del sistema (para poder ejecutarlos desde consola).*

## Instalación de la aplicación

###Configuración *AMP.

- Clonar el proyecto dentro de una carpeta que pueda ser accesible desde el Apache (httpdocs, www). 
- Habilitar el uso de httaccess en el servidor Apache (<https://help.ubuntu.com/community/EnablingUseOfApacheHtaccessFiles>).

###Composer

Ejecutar el comando en la raíz del proyecto (mismo nivel del archivo composer.json)

    composer install

para instalar todas las dependencias PHP necesarias (Slim framework, ORM, etc).

###Bower

Ejecutar el comando en la raíz del proyecto (mismo nivel del archivo bower.json)

    bower install

para instalar todas las dependencias JS (angular, bootstrap, jquery, etc).

###Flyway

Ubicarse dentro de la carpeta flyway del proyecto. Ejecutar el comando

    flyway migrate
    
Para crear y migrar el esquema en la base de datos a ser usada.

## Desarollo de la aplicación

###Composer

Cada vez que se agrega o elimine un elemento del atributo "require" del archivo composer.json ejecutar el comando

    composer update

para actualizar las dependencias PHP.

###Bower

Para agregar una nueva dependencia al archivo bower, así como para hacer disponible para el resto de desarrolladores, ejecutar el comando

    bower install --save <nombre_dependencia>
    
el cual bajará y agregará la dependencia al archivo bower.json.

El resto de desarrolladores del equipo deberá ejecutar posteriormente el comando

    bower install

para instalar las nuevas dependencias agregadas.

###Flyway

Cada nueva migración de la base de datos se deberá realizar mediante archivos *.sql. Colocarlos dentro de la carpeta

    <project_folder>/flyway/sql/

La convención de nombramientos de los archivos de migración será el siguiente 

    V<numero_migracion>__<descripcion_migracion>.sql

Por ejemplo...

    V3__changeDataFromUsers.sql

Para realizar la migración, ejecutar el comando siguiente:

    flyway migrate
    
* Notificar al resto del equipo cuando se haya agregado un archivo de migración, usando los canales de comunicación definidos (Facebook)*

## How to Contribute

### Pull Requests

### Style Guide

