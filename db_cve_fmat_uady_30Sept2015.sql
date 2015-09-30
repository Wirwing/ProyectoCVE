CREATE DATABASE  IF NOT EXISTS `db_cve_fmat_uady` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `db_cve_fmat_uady`;
-- MySQL dump 10.13  Distrib 5.6.17, for Win64 (x86_64)
--
-- Host: localhost    Database: db_cve_fmat_uady
-- ------------------------------------------------------
-- Server version	5.6.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `actividad_colaborativa_archivos`
--

DROP TABLE IF EXISTS `actividad_colaborativa_archivos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actividad_colaborativa_archivos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_actividad` int(11) NOT NULL,
  `id_archivo_adjunto` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actividad_colaborativa_archivos`
--

LOCK TABLES `actividad_colaborativa_archivos` WRITE;
/*!40000 ALTER TABLE `actividad_colaborativa_archivos` DISABLE KEYS */;
/*!40000 ALTER TABLE `actividad_colaborativa_archivos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `actividades_colaborativas`
--

DROP TABLE IF EXISTS `actividades_colaborativas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actividades_colaborativas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_modelo` int(11) NOT NULL,
  `id_tutor` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(200) NOT NULL,
  `fecha` date NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `estrategia_instruccional` varchar(50) NOT NULL,
  `duracion_minima` int(11) NOT NULL,
  `iniciada` int(11) DEFAULT NULL,
  `fecha_limite` datetime NOT NULL,
  `NumKElements` int(11) NOT NULL DEFAULT '1' COMMENT '#Piezas de Conocimiento',
  `K_Element1` varchar(50) NOT NULL DEFAULT 'GENERICO' COMMENT 'Pieza Conocimiento1',
  `K_Element2` varchar(50) DEFAULT NULL COMMENT 'Pieza Conocimiento2',
  `K_Element3` varchar(50) DEFAULT NULL COMMENT 'Pieza Conocimiento3',
  PRIMARY KEY (`id`),
  KEY `fk_actividad_colaborativa_modelo_idx` (`id_modelo`),
  CONSTRAINT `fk_actividad_colaborativa_modelo` FOREIGN KEY (`id_modelo`) REFERENCES `modelos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actividades_colaborativas`
--

LOCK TABLES `actividades_colaborativas` WRITE;
/*!40000 ALTER TABLE `actividades_colaborativas` DISABLE KEYS */;
INSERT INTO `actividades_colaborativas` (`id`, `id_modelo`, `id_tutor`, `nombre`, `descripcion`, `fecha`, `tipo`, `estrategia_instruccional`, `duracion_minima`, `iniciada`, `fecha_limite`, `NumKElements`, `K_Element1`, `K_Element2`, `K_Element3`) VALUES (5,1,1,'Diagrama de dominio UML','Representar las operaciones basicas de una casa de empeÃƒÆ’Ã‚Â±o','2014-10-09','Colaborativa sin tutor','ROMPECABEZAS - Cada estudiante tiene un elemento d',45,1,'2014-12-14 15:54:31',3,'UML1','UML2','UML3'),(7,1,1,'Diagrama de Clases Cajero Automatico','Crear un diagrama de clases para las operaciones comunes de un cajero automatico','2015-03-31','Grupos 3 personas','Colaborativa',40,1,'2015-04-17 17:48:34',3,'GENERICO',NULL,NULL),(8,1,1,'Test','Test','2015-04-28','Frecuencia','Test',45,1,'2015-04-28 17:14:47',1,'GENERICO',NULL,NULL);
/*!40000 ALTER TABLE `actividades_colaborativas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `analisis_alumnos`
--

DROP TABLE IF EXISTS `analisis_alumnos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `analisis_alumnos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_grupo` int(11) NOT NULL,
  `id_sesion` varchar(60) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_clase` int(11) NOT NULL DEFAULT '0' COMMENT '0=No se uso la clase; 1=Se uso la clase (1..+)',
  `id_indicador` int(11) NOT NULL DEFAULT '0' COMMENT 'id de la tabla indicadores',
  `bUso` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Uso=1',
  `ifrecuencia` int(11) NOT NULL DEFAULT '0' COMMENT 'Valor acumulado de las veces que se usa la clase',
  `id_modelo` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_grupo` (`id_grupo`)
) ENGINE=InnoDB AUTO_INCREMENT=377 DEFAULT CHARSET=latin1 COMMENT='analisis_clase_indicadores';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analisis_alumnos`
--

LOCK TABLES `analisis_alumnos` WRITE;
/*!40000 ALTER TABLE `analisis_alumnos` DISABLE KEYS */;
INSERT INTO `analisis_alumnos` (`id`, `id_grupo`, `id_sesion`, `id_usuario`, `id_clase`, `id_indicador`, `bUso`, `ifrecuencia`, `id_modelo`) VALUES (263,1,'gisl3pefXA',5,2,21,0,0,1),(264,1,'gisl3pefXA',5,2,22,0,0,1),(265,1,'gisl3pefXA',5,2,23,0,0,1),(266,1,'gisl3pefXA',5,2,24,1,2,1),(267,1,'gisl3pefXA',5,2,25,0,0,1),(268,1,'gisl3pefXA',5,2,26,1,3,1),(269,1,'gisl3pefXA',5,2,45,0,0,1),(270,1,'gisl3pefXA',5,2,46,0,0,1),(271,1,'gisl3pefXA',5,3,27,0,0,1),(272,1,'gisl3pefXA',5,3,28,0,0,1),(273,1,'gisl3pefXA',5,11,52,0,0,1),(274,1,'gisl3pefXA',5,12,56,0,0,1),(275,1,'gisl3pefXA',5,12,57,0,0,1),(276,1,'gisl3pefXA',5,12,58,0,0,1),(277,1,'gisl3pefXA',5,12,59,0,0,1),(278,1,'gisl3pefXA',5,12,60,1,1,1),(279,1,'gisl3pefXA',5,12,61,1,1,1),(280,1,'gisl3pefXA',5,12,62,0,0,1),(283,1,'gisl3pefXA',5,14,65,0,0,1),(284,1,'gisl3pefXA',5,14,66,1,2,1),(285,1,'gisl3pefXA',5,14,67,1,1,1),(286,1,'gisl3pefXA',5,15,69,1,1,1),(287,1,'gisl3pefXA',5,15,70,0,0,1),(288,1,'gisl3pefXA',5,15,71,0,0,1),(289,1,'gisl3pefXA',5,15,72,0,0,1),(290,1,'gisl3pefXA',5,16,73,0,0,1),(291,1,'gisl3pefXA',5,16,74,0,0,1),(292,1,'gisl3pefXA',5,16,75,0,0,1),(293,1,'gisl3pefXA',5,16,76,0,0,1),(295,1,'gisl3pefXA',5,17,78,0,0,1),(296,1,'gisl3pefXA',5,17,79,0,0,1),(297,1,'gisl3pefXA',5,17,80,0,0,1),(298,1,'gisl3pefXA',5,17,81,0,0,1),(299,1,'t4GSaj3W9A',4,2,21,0,0,1),(300,1,'t4GSaj3W9A',4,2,22,0,0,1),(301,1,'t4GSaj3W9A',4,2,23,0,0,1),(302,1,'t4GSaj3W9A',4,2,24,0,0,1),(303,1,'t4GSaj3W9A',4,2,25,0,0,1),(304,1,'t4GSaj3W9A',4,2,26,0,0,1),(305,1,'t4GSaj3W9A',4,2,45,0,0,1),(306,1,'t4GSaj3W9A',4,2,46,1,1,1),(307,1,'t4GSaj3W9A',4,3,27,0,0,1),(308,1,'t4GSaj3W9A',4,3,28,0,0,1),(309,1,'t4GSaj3W9A',4,11,52,0,0,1),(310,1,'t4GSaj3W9A',4,12,56,0,0,1),(311,1,'t4GSaj3W9A',4,12,57,0,0,1),(312,1,'t4GSaj3W9A',4,12,58,0,0,1),(313,1,'t4GSaj3W9A',4,12,59,0,0,1),(314,1,'t4GSaj3W9A',4,12,60,1,1,1),(315,1,'t4GSaj3W9A',4,12,61,0,0,1),(316,1,'t4GSaj3W9A',4,12,62,0,0,1),(319,1,'t4GSaj3W9A',4,14,65,0,0,1),(320,1,'t4GSaj3W9A',4,14,66,1,3,1),(321,1,'t4GSaj3W9A',4,14,67,0,0,1),(322,1,'t4GSaj3W9A',4,15,69,1,1,1),(323,1,'t4GSaj3W9A',4,15,70,0,0,1),(324,1,'t4GSaj3W9A',4,15,71,0,0,1),(325,1,'t4GSaj3W9A',4,15,72,0,0,1),(326,1,'t4GSaj3W9A',4,16,73,0,0,1),(327,1,'t4GSaj3W9A',4,16,74,0,0,1),(328,1,'t4GSaj3W9A',4,16,75,0,0,1),(329,1,'t4GSaj3W9A',4,16,76,0,0,1),(331,1,'t4GSaj3W9A',4,17,78,1,1,1),(332,1,'t4GSaj3W9A',4,17,79,0,0,1),(333,1,'t4GSaj3W9A',4,17,80,0,0,1),(334,1,'t4GSaj3W9A',4,17,81,0,0,1),(335,1,'39kb1RwSLt',5,2,21,1,1,1),(336,1,'39kb1RwSLt',5,2,22,1,3,1),(337,1,'39kb1RwSLt',5,2,23,0,0,1),(338,1,'39kb1RwSLt',5,2,24,1,1,1),(339,1,'39kb1RwSLt',5,2,25,0,0,1),(340,1,'39kb1RwSLt',5,2,26,0,0,1),(341,1,'39kb1RwSLt',5,2,45,0,0,1),(342,1,'39kb1RwSLt',5,2,46,0,0,1),(343,1,'39kb1RwSLt',5,3,27,0,0,1),(344,1,'39kb1RwSLt',5,3,28,0,0,1),(345,1,'39kb1RwSLt',5,11,52,0,0,1),(346,1,'39kb1RwSLt',5,12,56,0,0,1),(347,1,'39kb1RwSLt',5,12,57,0,0,1),(348,1,'39kb1RwSLt',5,12,58,0,0,1),(349,1,'39kb1RwSLt',5,12,59,0,0,1),(350,1,'39kb1RwSLt',5,12,60,0,0,1),(351,1,'39kb1RwSLt',5,12,61,0,0,1),(352,1,'39kb1RwSLt',5,12,62,0,0,1),(353,1,'39kb1RwSLt',5,14,65,0,0,1),(354,1,'39kb1RwSLt',5,14,66,0,0,1),(355,1,'39kb1RwSLt',5,14,67,0,0,1),(356,1,'39kb1RwSLt',5,15,69,0,0,1),(357,1,'39kb1RwSLt',5,15,70,0,0,1),(358,1,'39kb1RwSLt',5,15,71,0,0,1),(359,1,'39kb1RwSLt',5,15,72,0,0,1),(360,1,'39kb1RwSLt',5,16,73,0,0,1),(361,1,'39kb1RwSLt',5,16,74,0,0,1),(362,1,'39kb1RwSLt',5,16,75,0,0,1),(363,1,'39kb1RwSLt',5,16,76,0,0,1),(364,1,'39kb1RwSLt',5,17,78,0,0,1),(365,1,'39kb1RwSLt',5,17,79,0,0,1),(366,1,'39kb1RwSLt',5,17,80,0,0,1),(367,1,'39kb1RwSLt',5,17,81,0,0,1),(368,1,'39kb1RwSLt',5,17,82,0,0,1),(369,1,'39kb1RwSLt',5,17,83,0,0,1),(370,1,'39kb1RwSLt',5,1001,0,1,3,1),(371,1,'39kb1RwSLt',5,1001,0,1,1,1),(372,1,'39kb1RwSLt',5,1001,0,1,1,1),(373,1,'39kb1RwSLt',5,1001,0,1,1,1),(374,1,'39kb1RwSLt',5,1001,0,1,1,1),(375,1,'39kb1RwSLt',5,1002,0,1,2,1),(376,1,'39kb1RwSLt',5,1003,0,1,1,1);
/*!40000 ALTER TABLE `analisis_alumnos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `archivos_adjuntos`
--

DROP TABLE IF EXISTS `archivos_adjuntos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `archivos_adjuntos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_actividad` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `url` varchar(100) NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`id`,`id_actividad`),
  KEY `fk_archivos_adjuntos_actividad_colaborativa1_idx` (`id_actividad`),
  CONSTRAINT `fk_archivos_adjuntos_actividad_colaborativa1` FOREIGN KEY (`id_actividad`) REFERENCES `actividades_colaborativas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `archivos_adjuntos`
--

LOCK TABLES `archivos_adjuntos` WRITE;
/*!40000 ALTER TABLE `archivos_adjuntos` DISABLE KEYS */;
INSERT INTO `archivos_adjuntos` (`id`, `id_actividad`, `nombre`, `url`, `fecha`) VALUES (1,5,'Dimitrakopoulou-Kaleidoscope-2004_Indicadores.pdf','','2014-12-06'),(2,5,'Dimitrakopoulou-Kaleidoscope-2006_Indicadores.pdf','','2014-12-06');
/*!40000 ALTER TABLE `archivos_adjuntos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_extendido`
--

DROP TABLE IF EXISTS `chat_extendido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chat_extendido` (
  `id` int(11) NOT NULL,
  `acuerdo` int(11) NOT NULL,
  `no_acuerdo` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_extendido`
--

LOCK TABLES `chat_extendido` WRITE;
/*!40000 ALTER TABLE `chat_extendido` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat_extendido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_logs`
--

DROP TABLE IF EXISTS `chat_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chat_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_grupo` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_actividad` int(11) NOT NULL,
  `id_indicador` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `message` varchar(256) DEFAULT NULL,
  `id_clase` int(11) NOT NULL,
  `id_sesion` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=208 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_logs`
--

LOCK TABLES `chat_logs` WRITE;
/*!40000 ALTER TABLE `chat_logs` DISABLE KEYS */;
INSERT INTO `chat_logs` (`id`, `id_grupo`, `id_usuario`, `id_actividad`, `id_indicador`, `fecha`, `message`, `id_clase`, `id_sesion`) VALUES (180,1,4,7,63,'2015-05-22 23:47:20','podemos presentarnos primero para saber que elem tenemos para intercambiar',12,'t4GSaj3W9A'),(181,1,4,7,60,'2015-05-22 23:50:04','Permiteme explicar ... ami me toco el elem1, que trata del tipo de relaciones',12,'t4GSaj3W9A'),(182,1,5,7,60,'2015-05-22 23:51:32','ok, a mi me todo el elem2, acerca del tipo de estereotipos que puedes utilizar',12,'gisl3pefXA'),(183,1,4,7,63,'2015-05-22 23:53:21','Sabes si vamos a utilizar algun tipo de modelo en especial?',12,'t4GSaj3W9A'),(184,1,5,7,67,'2015-05-22 23:54:11','No',14,'gisl3pefXA'),(185,1,5,7,26,'2015-05-22 23:54:56','suponemos que es el modelo de presentacion x el tipo de elementos que nos toco',2,'gisl3pefXA'),(186,1,4,7,66,'2015-05-22 23:55:15','Esta bien, tiene razon',14,'t4GSaj3W9A'),(187,1,4,7,78,'2015-05-22 23:55:54','Puedes decirme mas acerca de tu elemento',17,'t4GSaj3W9A'),(188,1,5,7,63,'2015-05-22 23:57:02','los estereotipos son para clasificar el tipo de metodo que vaz a aplicar ala entidad',12,'gisl3pefXA'),(189,1,4,7,46,'2015-05-22 23:57:47','No estoy seguro, es para definir el tipo de operacion no... chk bien',2,'t4GSaj3W9A'),(190,1,5,7,69,'2015-05-22 23:58:29','Bien, hagamos lo siguiente... vamos a plantearnos un ejemplo para ir viendo que hacer',15,'gisl3pefXA'),(191,1,5,7,66,'2015-05-22 23:59:08','Esta bien',14,'gisl3pefXA'),(192,1,5,7,26,'2015-05-22 23:59:31','Si suponemos el caso de un cajero automatico',2,'gisl3pefXA'),(193,1,4,7,64,'2015-05-23 00:00:25','Puedes explicarme mas que tipo de operacion del cajero... vamos a acotar',12,'t4GSaj3W9A'),(194,1,5,7,24,'2015-05-23 00:01:42','Te parece la trassaaccion de retiro de efectivo',2,'gisl3pefXA'),(195,1,4,7,66,'2015-05-23 00:02:00','Esta bien',14,'t4GSaj3W9A'),(196,1,5,7,26,'2015-05-23 00:02:38','Si suponemos que una persona quiere retirar 1000 pesos, primero debe introducir su tarjeta y tipear su nip',2,'gisl3pefXA'),(197,1,4,7,66,'2015-05-23 00:02:51','Esta bien',14,'t4GSaj3W9A'),(198,1,5,7,61,'2015-05-23 00:18:22','Para justificar hay que... tener un un nip y fondos para el retiro',12,'gisl3pefXA'),(199,1,5,7,24,'2015-05-23 00:19:55','o Podriamos mejor hacer una consulta de efectivo primero',2,'gisl3pefXA'),(200,1,4,7,69,'2015-05-23 00:21:05','Bien, hagamos lo siguiente, vamos a hacer un esquema de verificacion de nip y consulta de efectivo de fondos',15,'t4GSaj3W9A'),(201,1,5,7,66,'2015-05-23 00:21:22','Esta bien',14,'gisl3pefXA'),(203,1,5,7,21,'2015-09-26 14:58:18','Estoy de acuerdo xq',2,'39kb1RwSLt'),(204,1,5,7,22,'2015-09-26 15:10:45','Ambos estan correctos,',2,'39kb1RwSLt'),(205,1,5,7,24,'2015-09-26 15:10:52','Podriamos mejor',2,'39kb1RwSLt'),(206,1,5,7,22,'2015-09-26 15:13:12','Ambos estan correctos,',2,'39kb1RwSLt'),(207,1,5,7,22,'2015-09-26 15:13:37','Ambos estan correctos,',2,'39kb1RwSLt');
/*!40000 ALTER TABLE `chat_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clase`
--

DROP TABLE IF EXISTS `clase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL COMMENT 'habilidad',
  `subnombre` varchar(50) NOT NULL COMMENT 'habilidad',
  `model_id` int(11) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_model_idx` (`model_id`),
  CONSTRAINT `fk_model` FOREIGN KEY (`model_id`) REFERENCES `modelos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clase`
--

LOCK TABLES `clase` WRITE;
/*!40000 ALTER TABLE `clase` DISABLE KEYS */;
INSERT INTO `clase` (`id`, `nombre`, `subnombre`, `model_id`, `is_default`) VALUES (2,'Conflicto creativo','Argumentacion',1,0),(3,'Aprendizaje activo\n','Motivar',1,0),(11,'Conflicto creativo','Mediacion',1,0),(12,'Aprendizaje activo','Informar',1,0),(14,'Conversacion','Reconocimiento',1,0),(15,'Conversacion','Tarea',1,0),(16,'Conversacion','Mantenimiento',1,0),(17,'Aprendizaje activo','Requerir',1,0),(18,'TEST CLASE MODELO 2','TEST DE ATRIBUTO',2,0);
/*!40000 ALTER TABLE `clase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data`
--

DROP TABLE IF EXISTS `data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(30) NOT NULL,
  `fecha` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data`
--

LOCK TABLES `data` WRITE;
/*!40000 ALTER TABLE `data` DISABLE KEYS */;
/*!40000 ALTER TABLE `data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estudiante_tests`
--

DROP TABLE IF EXISTS `estudiante_tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estudiante_tests` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Id_test` int(11) NOT NULL,
  `Id_estudiante` int(11) NOT NULL,
  `Elemento_Conoc1` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Elemento de conocimiento 1',
  `Elemento_Conoc2` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Elemento de conocimiento2',
  `Elemento_Conoc3` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Elemento de conocimiento 3',
  `Id_grupo` int(11) DEFAULT NULL,
  `Id_Sesion_Cll` int(11) DEFAULT NULL,
  `Fecha_Aplicacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estudiante_tests`
--

LOCK TABLES `estudiante_tests` WRITE;
/*!40000 ALTER TABLE `estudiante_tests` DISABLE KEYS */;
/*!40000 ALTER TABLE `estudiante_tests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupos_colaborativos`
--

DROP TABLE IF EXISTS `grupos_colaborativos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grupos_colaborativos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_tutor` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `num_integrantes` int(11) NOT NULL DEFAULT '3',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupos_colaborativos`
--

LOCK TABLES `grupos_colaborativos` WRITE;
/*!40000 ALTER TABLE `grupos_colaborativos` DISABLE KEYS */;
INSERT INTO `grupos_colaborativos` (`id`, `id_tutor`, `fecha`, `nombre`, `num_integrantes`) VALUES (1,1,'2015-04-29','GRUPO A',2),(4,1,'2015-04-17','GRUPO B',3);
/*!40000 ALTER TABLE `grupos_colaborativos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupos_colaborativos_usuarios`
--

DROP TABLE IF EXISTS `grupos_colaborativos_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grupos_colaborativos_usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `activity_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_grupos_colaborativos_usuarios_grupos_colaborativos1_idx` (`group_id`),
  KEY `fk_grupos_colaborativos_usuarios_usuarios1_idx` (`user_id`),
  KEY `fk_grupos_colaborativos_usuarios_actividad_colaborativa1_idx` (`activity_id`),
  CONSTRAINT `fk_grupos_colaborativos_usuarios_grupos_colaborativos1` FOREIGN KEY (`group_id`) REFERENCES `grupos_colaborativos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_grupos_colaborativos_usuarios_usuarios1` FOREIGN KEY (`user_id`) REFERENCES `usuarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupos_colaborativos_usuarios`
--

LOCK TABLES `grupos_colaborativos_usuarios` WRITE;
/*!40000 ALTER TABLE `grupos_colaborativos_usuarios` DISABLE KEYS */;
INSERT INTO `grupos_colaborativos_usuarios` (`id`, `group_id`, `user_id`, `activity_id`) VALUES (16,4,3,5),(17,4,12,5),(18,4,13,5),(21,1,5,7),(22,1,4,7);
/*!40000 ALTER TABLE `grupos_colaborativos_usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indicadores`
--

DROP TABLE IF EXISTS `indicadores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indicadores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class_id` int(11) NOT NULL,
  `nombre` char(20) NOT NULL,
  `frecuencia_individual` tinyint(11) DEFAULT '0',
  `frecuencia_grupo` tinyint(11) DEFAULT '0',
  `tolerancia` tinyint(11) DEFAULT '0',
  `apertura` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_indicadores_clase1_idx` (`class_id`),
  CONSTRAINT `fk_class` FOREIGN KEY (`class_id`) REFERENCES `clase` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=latin1 COMMENT='Tabla para configurar el modelo de estados CLL';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indicadores`
--

LOCK TABLES `indicadores` WRITE;
/*!40000 ALTER TABLE `indicadores` DISABLE KEYS */;
INSERT INTO `indicadores` (`id`, `class_id`, `nombre`, `frecuencia_individual`, `frecuencia_grupo`, `tolerancia`, `apertura`) VALUES (21,2,'Concertar',0,0,0,'Estoy de acuerdo xq'),(22,2,'Conciliar',0,0,0,'Ambos estan correctos,'),(23,2,'Discrepar',0,0,0,'No estoy de acuerdo xq'),(24,2,'Alternativa',0,0,0,'Podriamos mejor'),(25,2,'Inferir',0,0,0,'Entonces'),(26,2,'Suponer',0,0,0,'Si suponemos'),(27,3,'Animar',0,0,0,'Muy bien'),(28,3,'Reforzar',0,0,0,'Es correcto'),(45,2,'Exepcion',0,0,0,'Que tal si sucede que'),(46,2,'Dudar',0,0,0,'No estoy seguro nnn'),(52,11,'Docente',0,0,0,'Preguntemos al maestro'),(56,12,'Parafresear',0,0,0,'Osea que'),(57,12,'Guiar',0,0,0,'Yo pienso que deberiamos'),(58,12,'Sugerir',0,0,0,'Yo creo que'),(59,12,'Elaborar',0,0,0,'Para eso'),(60,12,'Explicar',0,0,0,'Permiteme explicar que'),(61,12,'Justificar',0,0,0,'Para justificar hay que'),(62,12,'Afirmar',0,0,0,'Yo estoy seguro que'),(65,14,'Apreciacion',0,0,0,'Gracias'),(66,14,'Aceptacion',0,0,0,'Esta bien'),(67,14,'Rechazo',0,0,0,'No'),(69,15,'Coordinar',0,0,0,'Bien, hagamos lo siguiente'),(70,15,'Cambio enfoque',0,0,0,'Dejenme mostrarles'),(71,15,'Resumir',0,0,0,'Resumiendo'),(72,15,'Finalizar',0,0,0,'Adios'),(73,16,'Requerir atencion',0,0,0,'Atiendeme'),(74,16,'Requerir confirmacio',0,0,0,'Podrias x favor'),(75,16,'Atender',0,0,0,'Escucha'),(76,16,'Disculparse',0,0,0,'Disculpame'),(78,17,'Clarificacion',0,0,0,'Puedes decirme xq'),(79,17,'Justificacion',0,0,0,'Porque piensas eso?'),(80,17,'Opinion',0,0,0,'Tu que piensas de'),(81,17,'Ilustracion',0,0,0,'Muestrame x favor'),(82,17,'Informacion',0,0,0,'Podrias decirme por favor'),(83,17,'Elaboracion',0,0,0,'Podrias por favor hacer ');
/*!40000 ALTER TABLE `indicadores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modelos`
--

DROP TABLE IF EXISTS `modelos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modelos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COMMENT='Tabla intermedia para relacional actividad colaborativa con el modelo de estados';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modelos`
--

LOCK TABLES `modelos` WRITE;
/*!40000 ALTER TABLE `modelos` DISABLE KEYS */;
INSERT INTO `modelos` (`id`, `nombre`, `is_default`) VALUES (1,'Taxonomia_Soller',1),(2,'Taxonomia_Jhonson',0);
/*!40000 ALTER TABLE `modelos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `moodle_rcd`
--

DROP TABLE IF EXISTS `moodle_rcd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `moodle_rcd` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `rol` tinyint(4) NOT NULL,
  `id_course` int(11) NOT NULL,
  `course_name` varchar(100) NOT NULL,
  `email_sesion` varchar(100) NOT NULL,
  `fecha_inicio` datetime NOT NULL,
  `fecha_final` datetime DEFAULT NULL,
  `close_sesion` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1118 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moodle_rcd`
--

LOCK TABLES `moodle_rcd` WRITE;
/*!40000 ALTER TABLE `moodle_rcd` DISABLE KEYS */;
INSERT INTO `moodle_rcd` (`id`, `id_user`, `username`, `rol`, `id_course`, `course_name`, `email_sesion`, `fecha_inicio`, `fecha_final`, `close_sesion`) VALUES (1105,0,'',1,0,'','','2014-12-08 08:38:01',NULL,1),(1106,0,'',1,0,'','','2014-12-08 08:38:02',NULL,1),(1107,0,'',1,0,'','prueba desde moodle+cve','2014-12-08 08:39:59',NULL,1),(1108,0,'',1,0,'','prueba desde moodle+cve','2014-12-08 08:40:00',NULL,1),(1109,0,'',1,0,'','prueba desde moodle+cve','2014-12-08 08:41:30',NULL,1),(1110,0,'',1,0,'','prueba desde moodle+cve','2014-12-08 08:41:30',NULL,1),(1111,0,'',1,0,'','prueba desde moodle+cve','2014-12-08 08:42:54',NULL,1),(1112,0,'',1,0,'','prueba desde moodle+cve','2014-12-08 08:42:55',NULL,1),(1113,0,'',1,0,'','','2014-12-08 08:45:11',NULL,1),(1114,0,'',1,0,'','','2014-12-08 08:45:12',NULL,1),(1115,0,'',1,0,'','prueba desde moodle+cve','2014-12-08 09:00:53',NULL,1),(1116,0,'',1,0,'','','2015-04-03 12:54:36',NULL,1),(1117,0,'',1,0,'','','2015-04-03 12:55:06',NULL,1);
/*!40000 ALTER TABLE `moodle_rcd` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tests`
--

DROP TABLE IF EXISTS `tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tests` (
  `Id_test` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre_Test` varchar(100) NOT NULL,
  `Descripcion` varchar(200) NOT NULL,
  `Id_Tutor` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`Id_test`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COMMENT='Examenes de evaluacion colaborativos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tests`
--

LOCK TABLES `tests` WRITE;
/*!40000 ALTER TABLE `tests` DISABLE KEYS */;
INSERT INTO `tests` (`Id_test`, `Nombre_Test`, `Descripcion`, `Id_Tutor`) VALUES (3,'Prueba Exploratoria','Prueba para garantizar los supuestos de independencia del experimento, se enfoca en conocer el nivel de conocimiento inicial en base a los elementos de conocimiento. (antes de la colaboracion)',2),(4,'Prueba Post-Colaborativa','Se enfoca en analizar el nivel de conocimiento individual en base a los elementos de conocimiento.',2),(5,'Cuestionario de percepcion','Evalua en escala Likert la persepcion del estudiante con respecto a los elementos, funciones y procesos del CSCL',2);
/*!40000 ALTER TABLE `tests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  `apellido_paterno` varchar(30) NOT NULL,
  `apellido_materno` varchar(30) NOT NULL,
  `usuario` varchar(30) NOT NULL,
  `password` varchar(8) NOT NULL,
  `sexo` tinyint(1) DEFAULT NULL,
  `ciudad` varchar(30) DEFAULT NULL,
  `estado` varchar(30) DEFAULT NULL,
  `email` varchar(80) DEFAULT NULL,
  `tipo` int(11) DEFAULT '1',
  `curso_moodle` varchar(30) DEFAULT NULL,
  `Id_UserMoodle` varchar(100) DEFAULT NULL COMMENT 'Parametro Id_User de Moodle ',
  `lis_resource_linkid` varchar(100) DEFAULT NULL COMMENT 'Parametro Identifica el recurso dentro del curso',
  `lis_outcomes_service_url` varchar(100) DEFAULT NULL COMMENT 'Url unico para la devolucion de valores al libro calif moodle',
  `lis_result_sourceid` varchar(100) DEFAULT NULL COMMENT 'Parametro columna+renglon del libro calificaciones moodle',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='Usuarios registrados en el Juego CLL';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` (`id`, `nombre`, `apellido_paterno`, `apellido_materno`, `usuario`, `password`, `sexo`, `ciudad`, `estado`, `email`, `tipo`, `curso_moodle`, `Id_UserMoodle`, `lis_resource_linkid`, `lis_outcomes_service_url`, `lis_result_sourceid`) VALUES (1,'Irving','Caro','Fierros','wirwing','password',NULL,NULL,NULL,'irving@hotmail.com',1,'Programacion Ajax',NULL,NULL,NULL,NULL),(2,'Mauricio','Lara','Soberanis','mauricio','password',NULL,NULL,NULL,'mauricio@hotmail.com',1,'Programacion Ajax',NULL,NULL,NULL,NULL),(3,'Jaime','Negrete','Chinchilla','chinchil','password',NULL,NULL,NULL,'chinchilla@hotmail.com',2,'Programacion Ajax',NULL,NULL,NULL,NULL),(4,'Ricardo','Apellido1','Apellido2','ricardo','password',NULL,NULL,NULL,'ricardo@hotmail.com',2,'Estructuras de Programacion',NULL,NULL,NULL,NULL),(5,'Arit','Apellido','Apellido','arit','password',NULL,NULL,NULL,'arit@hotmail.com',2,'Estructuras de programacion',NULL,NULL,NULL,NULL),(6,'alumnox','xxx','yyy','alumnox','password',NULL,NULL,NULL,'alumnox',2,'Programacion II',NULL,NULL,NULL,NULL),(7,'Sandra','Romero','Chams','sandra','password',NULL,NULL,NULL,'sandra@hotmail.com',2,'Moodle',NULL,NULL,NULL,NULL),(9,'Lorenzo','Matas','Espinoza','lorenzo','password',NULL,NULL,NULL,'lorenzo@hotmail.com',2,'Moodle',NULL,NULL,NULL,NULL),(11,'Admin User','ap_paterno','ap_materno','cyntsc10@gmail.com','password',NULL,NULL,NULL,'cyntsc10@gmail.com',1,'Programacion I',NULL,NULL,NULL,NULL),(12,'Alicia XX','ap_paterno','ap_materno','aliciaxx@hotmail.com','password',NULL,NULL,NULL,'aliciaxx@hotmail.com',2,'Programacion I',NULL,NULL,NULL,NULL),(13,'Jorge XX','ap_paterno','ap_materno','jorge@hotmail.com','password',NULL,NULL,NULL,'jorge@hotmail.com',2,'Programacion I',NULL,NULL,NULL,NULL),(14,'','ap_paterno','ap_materno','','password',NULL,NULL,NULL,'',1,'',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-09-30 15:27:30
