SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Host: localhost:8889
-- Generation Time: Nov 27, 2014 at 06:30 PM
-- Server version: 5.5.34
-- PHP Version: 5.5.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `db_cve_fmat_uady`
--

-- --------------------------------------------------------

--
-- Table structure for table `actividades_colaborativas`
--

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
  PRIMARY KEY (`id`),
  KEY `fk_actividad_colaborativa_modelo_idx` (`id_modelo`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;



-- --------------------------------------------------------

--
-- Table structure for table `actividad_colaborativa_archivos`
--

CREATE TABLE `actividad_colaborativa_archivos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_actividad` int(11) NOT NULL,
  `id_archivo_adjunto` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `archivos_adjuntos`
--

CREATE TABLE `archivos_adjuntos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_actividad` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `url` varchar(100) NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`id`,`id_actividad`),
  KEY `fk_archivos_adjuntos_actividad_colaborativa1_idx` (`id_actividad`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `chat_extendido`
--

CREATE TABLE `chat_extendido` (
  `id` int(11) NOT NULL,
  `acuerdo` int(11) NOT NULL,
  `no_acuerdo` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `chat_logs`
--

CREATE TABLE `chat_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_grupo` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_actividad` int(11) NOT NULL,
  `id_indicador` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `message` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=27 ;



-- --------------------------------------------------------

--
-- Table structure for table `grupos_colaborativos`
--

CREATE TABLE `grupos_colaborativos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_tutor` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `num_integrantes` int(11) NOT NULL DEFAULT '3',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;



-- --------------------------------------------------------

--
-- Table structure for table `grupos_colaborativos_usuarios`
--

CREATE TABLE `grupos_colaborativos_usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `activity_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_grupos_colaborativos_usuarios_grupos_colaborativos1_idx` (`group_id`),
  KEY `fk_grupos_colaborativos_usuarios_usuarios1_idx` (`user_id`),
  KEY `fk_grupos_colaborativos_usuarios_actividad_colaborativa1_idx` (`activity_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;



-- --------------------------------------------------------

--
-- Table structure for table `indicadores`
--

CREATE TABLE `indicadores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_modelo` int(11) NOT NULL,
  `nombre` char(20) NOT NULL,
  `frecuencia_individual` tinyint(4) NOT NULL,
  `frecuencia_grupo` tinyint(4) NOT NULL,
  `tolerancia` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`,`id_modelo`),
  KEY `fk_indicadores_modelo1_idx` (`id_modelo`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Tabla para configurar el modelo de estados CLL' AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- Table structure for table `modelos`
--

CREATE TABLE `modelos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Tabla intermedia para relacional actividad colaborativa con el modelo de estados' AUTO_INCREMENT=2 ;


--
-- Table structure for table `moodle_rcd`
--

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------
--
-- Table structure for table `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  `apellido_paterno` varchar(30) NOT NULL,
  `apellido_materno` varchar(30) NOT NULL,
  `usuario` varchar(8) NOT NULL,
  `password` varchar(8) NOT NULL,
  `sexo` tinyint(1) DEFAULT NULL,
  `ciudad` varchar(30) DEFAULT NULL,
  `estado` varchar(30) DEFAULT NULL,
  `email` varchar(80) DEFAULT NULL,
  `tipo` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Usuarios registrados en el Juego CLL' AUTO_INCREMENT=6 ;


--
-- Constraints for dumped tables
--

--
-- Constraints for table `actividades_colaborativas`
--
ALTER TABLE `actividades_colaborativas`
ADD CONSTRAINT `fk_actividad_colaborativa_modelo` FOREIGN KEY (`id_modelo`) REFERENCES `modelos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `archivos_adjuntos`
--
ALTER TABLE `archivos_adjuntos`
ADD CONSTRAINT `fk_archivos_adjuntos_actividad_colaborativa1` FOREIGN KEY (`id_actividad`) REFERENCES `actividades_colaborativas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `grupos_colaborativos_usuarios`
--
ALTER TABLE `grupos_colaborativos_usuarios`
ADD CONSTRAINT `fk_grupos_colaborativos_usuarios_grupos_colaborativos1` FOREIGN KEY (`group_id`) REFERENCES `grupos_colaborativos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_grupos_colaborativos_usuarios_usuarios1` FOREIGN KEY (`user_id`) REFERENCES `usuarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `indicadores`
--
ALTER TABLE `indicadores`
ADD CONSTRAINT `fk_indicadores_modelo1` FOREIGN KEY (`id_modelo`) REFERENCES `modelos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
