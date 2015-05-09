-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Host: localhost:8889
-- Generation Time: Dec 15, 2014 at 08:00 PM
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
  `iniciada` int(11) DEFAULT NULL,
  `fecha_limite` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_actividad_colaborativa_modelo_idx` (`id_modelo`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `actividades_colaborativas`
--

INSERT INTO `actividades_colaborativas` (`id`, `id_modelo`, `id_tutor`, `nombre`, `descripcion`, `fecha`, `tipo`, `estrategia_instruccional`, `duracion_minima`, `iniciada`, `fecha_limite`) VALUES
(5, 1, 1, 'Estructura WHILE', 'En esta actividad deberan aprender a usar una estructura while anidada cuadratica', '2014-10-09', 'Colaborativa sin tutor', 'ROMPECABEZAS', 50, 1, '2014-12-14 15:54:31'),
(6, 1, 1, 'Estructura For', 'En esta actividad debera aprender a programar una estructura For cubica', '2014-12-03', 'competitiva', 'xxxx', 30, 1, '2014-12-04 00:25:27');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `archivos_adjuntos`
--

INSERT INTO `archivos_adjuntos` (`id`, `id_actividad`, `nombre`, `url`, `fecha`) VALUES
(1, 5, 'Dimitrakopoulou-Kaleidoscope-2004_Indicadores.pdf', '', '2014-12-06'),
(2, 5, 'Dimitrakopoulou-Kaleidoscope-2006_Indicadores.pdf', '', '2014-12-06');

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
  `id_clase` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=57 ;

--
-- Dumping data for table `chat_logs`
--

INSERT INTO `chat_logs` (`id`, `id_grupo`, `id_usuario`, `id_actividad`, `id_indicador`, `fecha`, `message`, `id_clase`) VALUES
(41, 1, 5, 5, 21, '2014-12-14 16:05:41', 'Hola 1 lel', 0),
(42, 1, 5, 5, 22, '2014-12-14 16:08:58', 'Hola 2de', 2),
(43, 1, 5, 5, 22, '2014-12-14 16:09:12', 'Hola 2 dede', 2),
(44, 1, 5, 5, 22, '2014-12-14 16:10:05', 'Hola 2dede', 2),
(45, 1, 5, 5, 24, '2014-12-14 16:10:09', 'Hola 4dede', 2),
(46, 1, 5, 5, 26, '2014-12-14 16:10:59', 'Hola 6 dede', 2),
(47, 1, 5, 5, 23, '2014-12-14 16:13:09', 'Hola 3 dede', 2),
(48, 1, 5, 5, 23, '2014-12-14 16:16:13', 'Hola 3 ggg', 2),
(49, 1, 5, 5, 26, '2014-12-14 16:16:18', 'Hola 6 frfr', 2),
(50, 1, 5, 5, 31, '2014-12-14 16:16:22', 'Hola 5', 3),
(51, 1, 5, 5, 22, '2014-12-14 16:25:11', 'Hola 2 de', 2),
(52, 1, 5, 5, 23, '2014-12-14 16:29:16', 'Hola 3 dede', 2),
(53, 1, 5, 5, 30, '2014-12-14 16:29:21', 'Hola 4 dede', 3),
(54, 1, 5, 5, 23, '2014-12-14 16:40:23', 'Hola 3 hola', 2),
(55, 1, 5, 5, 30, '2014-12-14 16:40:30', 'Hola 4 como te llamas', 3),
(56, 1, 5, 5, 22, '2014-12-14 16:40:37', 'Hola 2 no lo se', 2);

-- --------------------------------------------------------

--
-- Table structure for table `clase`
--

CREATE TABLE `clase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `model_id` int(11) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_model_idx` (`model_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `clase`
--

INSERT INTO `clase` (`id`, `nombre`, `model_id`, `is_default`) VALUES
(2, 'TEST', 1, 0);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `grupos_colaborativos`
--

INSERT INTO `grupos_colaborativos` (`id`, `id_tutor`, `fecha`, `nombre`, `num_integrantes`) VALUES
(1, 1, '2014-12-03', 'TEST_GROUP', 2),
(4, 1, '2014-12-08', 'GRUPO COLABORATIVO PRUEBA 1', 3);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `grupos_colaborativos_usuarios`
--

INSERT INTO `grupos_colaborativos_usuarios` (`id`, `group_id`, `user_id`, `activity_id`) VALUES
(5, 1, 5, 5),
(6, 1, 4, 5),
(11, 4, 6, 5),
(12, 4, 12, 5),
(13, 4, 13, 5);

-- --------------------------------------------------------

--
-- Table structure for table `indicadores`
--

CREATE TABLE `indicadores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class_id` int(11) NOT NULL,
  `nombre` char(20) NOT NULL,
  `frecuencia_individual` tinyint(4) NOT NULL,
  `frecuencia_grupo` tinyint(4) NOT NULL,
  `tolerancia` tinyint(4) NOT NULL,
  `apertura` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_indicadores_clase1_idx` (`class_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Tabla para configurar el modelo de estados CLL' AUTO_INCREMENT=27 ;

--
-- Dumping data for table `indicadores`
--

INSERT INTO `indicadores` (`id`, `class_id`, `nombre`, `frecuencia_individual`, `frecuencia_grupo`, `tolerancia`, `apertura`) VALUES
(21, 2, 'Argumento', 0, 0, 0, 'Hola 1'),
(22, 2, 'Idea', 0, 0, 0, 'Hola 2'),
(23, 2, 'Duda', 0, 0, 0, 'Hola 3'),
(24, 2, 'Pregunta', 0, 0, 0, 'Hola 4'),
(25, 2, 'Pregunta', 0, 0, 0, 'Hola 5'),
(26, 2, 'Pregunta', 0, 0, 0, 'Hola 6');

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
-- Dumping data for table `modelos`
--

INSERT INTO `modelos` (`id`, `nombre`, `is_default`) VALUES
(1, 'Modelo default', 1);

-- --------------------------------------------------------

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1116 ;

--
-- Dumping data for table `moodle_rcd`
--

INSERT INTO `moodle_rcd` (`id`, `id_user`, `username`, `rol`, `id_course`, `course_name`, `email_sesion`, `fecha_inicio`, `fecha_final`, `close_sesion`) VALUES
(1105, 0, '', 1, 0, '', '', '2014-12-08 08:38:01', NULL, 1),
(1106, 0, '', 1, 0, '', '', '2014-12-08 08:38:02', NULL, 1),
(1107, 0, '', 1, 0, '', 'prueba desde moodle+cve', '2014-12-08 08:39:59', NULL, 1),
(1108, 0, '', 1, 0, '', 'prueba desde moodle+cve', '2014-12-08 08:40:00', NULL, 1),
(1109, 0, '', 1, 0, '', 'prueba desde moodle+cve', '2014-12-08 08:41:30', NULL, 1),
(1110, 0, '', 1, 0, '', 'prueba desde moodle+cve', '2014-12-08 08:41:30', NULL, 1),
(1111, 0, '', 1, 0, '', 'prueba desde moodle+cve', '2014-12-08 08:42:54', NULL, 1),
(1112, 0, '', 1, 0, '', 'prueba desde moodle+cve', '2014-12-08 08:42:55', NULL, 1),
(1113, 0, '', 1, 0, '', '', '2014-12-08 08:45:11', NULL, 1),
(1114, 0, '', 1, 0, '', '', '2014-12-08 08:45:12', NULL, 1),
(1115, 0, '', 1, 0, '', 'prueba desde moodle+cve', '2014-12-08 09:00:53', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Usuarios registrados en el Juego CLL' AUTO_INCREMENT=15 ;

--
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `apellido_paterno`, `apellido_materno`, `usuario`, `password`, `sexo`, `ciudad`, `estado`, `email`, `tipo`, `curso_moodle`) VALUES
(1, 'Irving', 'Caro', 'Fierros', 'wirwing', 'password', NULL, NULL, NULL, 'irving@hotmail.com', 1, 'Programacion Ajax'),
(2, 'Mauricio', 'Lara', 'Soberanis', 'mauricio', 'password', NULL, NULL, NULL, 'mauricio@hotmail.com', 1, 'Programacion Ajax'),
(3, 'Jaime', 'Negrete', 'Chinchilla', 'chinchil', 'password', NULL, NULL, NULL, 'chinchilla@hotmail.com', 2, 'Programacion Ajax'),
(4, 'Ricardo', 'Apellido1', 'Apellido2', 'ricardo', 'password', NULL, NULL, NULL, 'ricardo@hotmail.com', 2, 'Estructuras de Programacion'),
(5, 'Arit', 'Apellido', 'Apellido', 'arit', 'password', NULL, NULL, NULL, 'arit@hotmail.com', 2, 'Estructuras de programacion'),
(6, 'alumnox', 'xxx', 'yyy', 'alumnox', 'password', NULL, NULL, NULL, 'alumnox', 2, 'Programacion II'),
(7, 'Sandra', 'Romero', 'Chams', 'sandra', 'password', NULL, NULL, NULL, 'sandra@hotmail.com', 2, 'Moodle'),
(9, 'Lorenzo', 'Matas', 'Espinoza', 'lorenzo', 'password', NULL, NULL, NULL, 'lorenzo@hotmail.com', 2, 'Moodle'),
(11, 'Admin User', 'ap_paterno', 'ap_materno', 'cyntsc10@gmail.com', 'password', NULL, NULL, NULL, 'cyntsc10@gmail.com', 1, 'Programacion I'),
(12, 'Alicia XX', 'ap_paterno', 'ap_materno', 'aliciaxx@hotmail.com', 'password', NULL, NULL, NULL, 'aliciaxx@hotmail.com', 2, 'Programacion I'),
(13, 'Jorge XX', 'ap_paterno', 'ap_materno', 'jorge@hotmail.com', 'password', NULL, NULL, NULL, 'jorge@hotmail.com', 2, 'Programacion I'),
(14, '', 'ap_paterno', 'ap_materno', '', 'password', NULL, NULL, NULL, '', 1, '');

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
-- Constraints for table `clase`
--
ALTER TABLE `clase`
  ADD CONSTRAINT `fk_model` FOREIGN KEY (`model_id`) REFERENCES `modelos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
  ADD CONSTRAINT `fk_class` FOREIGN KEY (`class_id`) REFERENCES `clase` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
