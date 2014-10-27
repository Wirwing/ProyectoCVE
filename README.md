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

## How to Contribute

### Pull Requests

### Style Guide

