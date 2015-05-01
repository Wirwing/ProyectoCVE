-- phpMyAdmin SQL Dump
-- version 4.0.9
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 01-05-2015 a las 19:34:16
-- Versión del servidor: 5.6.14
-- Versión de PHP: 5.5.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `db_cve_fmat_uady`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividades_colaborativas`
--

CREATE TABLE IF NOT EXISTS `actividades_colaborativas` (
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
  KEY `fk_actividad_colaborativa_modelo_idx` (`id_modelo`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Volcado de datos para la tabla `actividades_colaborativas`
--

INSERT INTO `actividades_colaborativas` (`id`, `id_modelo`, `id_tutor`, `nombre`, `descripcion`, `fecha`, `tipo`, `estrategia_instruccional`, `duracion_minima`, `iniciada`, `fecha_limite`, `NumKElements`, `K_Element1`, `K_Element2`, `K_Element3`) VALUES
(5, 1, 1, 'Diagrama de dominio UML', 'Representar las operaciones basicas de una casa de empeÃ±o', '2014-10-09', 'Colaborativa sin tutor', 'ROMPECABEZAS - Cada estudiante tiene un elemento d', 45, 1, '2014-12-14 15:54:31', 3, 'UML1', 'UML2', 'UML3'),
(7, 1, 1, 'Diagrama de Clases Cajero Automatico', 'Crear un diagrama de clases para las operaciones comunes de un cajero automatico', '2015-03-31', 'Grupos 3 personas', 'Colaborativa', 40, 1, '2015-04-17 17:48:34', 3, 'GENERICO', NULL, NULL),
(8, 1, 1, 'Test', 'Test', '2015-04-28', 'Frecuencia', 'Test', 45, 1, '2015-04-28 17:14:47', 1, 'GENERICO', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividad_colaborativa_archivos`
--

CREATE TABLE IF NOT EXISTS `actividad_colaborativa_archivos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_actividad` int(11) NOT NULL,
  `id_archivo_adjunto` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `analisis_alumnos`
--

CREATE TABLE IF NOT EXISTS `analisis_alumnos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_grupo` int(11) NOT NULL,
  `id_sesion` int(11) NOT NULL DEFAULT '0',
  `id_usuario` int(11) NOT NULL,
  `id_clase` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0=No se uso la clase; 1=Se uso la clase (1..+)',
  `id_indicador` int(11) NOT NULL DEFAULT '0' COMMENT 'id de la tabla indicadores',
  `bUso` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Uso=1',
  `ifrecuencia` int(11) NOT NULL DEFAULT '0' COMMENT 'Valor acumulado de las veces que se usa la clase',
  PRIMARY KEY (`id`),
  KEY `id_grupo` (`id_grupo`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='analisis_clase_indicadores' AUTO_INCREMENT=11 ;

--
-- Volcado de datos para la tabla `analisis_alumnos`
--

INSERT INTO `analisis_alumnos` (`id`, `id_grupo`, `id_sesion`, `id_usuario`, `id_clase`, `id_indicador`, `bUso`, `ifrecuencia`) VALUES
(1, 1, 0, 4, 12, 0, 1, 1),
(2, 1, 0, 4, 16, 0, 1, 1),
(3, 1, 0, 4, 2, 0, 1, 1),
(4, 1, 0, 5, 2, 0, 1, 1),
(5, 1, 0, 4, 17, 0, 1, 2),
(6, 1, 0, 4, 3, 0, 0, 0),
(7, 1, 0, 4, 11, 0, 0, 0),
(8, 1, 0, 4, 14, 0, 0, 0),
(9, 1, 0, 4, 15, 0, 0, 0),
(10, 1, 0, 4, 18, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `archivos_adjuntos`
--

CREATE TABLE IF NOT EXISTS `archivos_adjuntos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_actividad` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `url` varchar(100) NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`id`,`id_actividad`),
  KEY `fk_archivos_adjuntos_actividad_colaborativa1_idx` (`id_actividad`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `archivos_adjuntos`
--

INSERT INTO `archivos_adjuntos` (`id`, `id_actividad`, `nombre`, `url`, `fecha`) VALUES
(1, 5, 'Dimitrakopoulou-Kaleidoscope-2004_Indicadores.pdf', '', '2014-12-06'),
(2, 5, 'Dimitrakopoulou-Kaleidoscope-2006_Indicadores.pdf', '', '2014-12-06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `chat_extendido`
--

CREATE TABLE IF NOT EXISTS `chat_extendido` (
  `id` int(11) NOT NULL,
  `acuerdo` int(11) NOT NULL,
  `no_acuerdo` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `chat_logs`
--

CREATE TABLE IF NOT EXISTS `chat_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_grupo` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_actividad` int(11) NOT NULL,
  `id_indicador` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `message` varchar(256) DEFAULT NULL,
  `id_clase` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=171 ;

--
-- Volcado de datos para la tabla `chat_logs`
--

INSERT INTO `chat_logs` (`id`, `id_grupo`, `id_usuario`, `id_actividad`, `id_indicador`, `fecha`, `message`, `id_clase`) VALUES
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
(56, 1, 5, 5, 22, '2014-12-14 16:40:37', 'Hola 2 no lo se', 2),
(57, 4, 6, 5, 29, '2014-12-16 17:40:22', 'Hola 33 hdehh', 3),
(58, 4, 6, 5, 41, '2014-12-16 17:51:32', 'Hola 3hhyhhh', 5),
(59, 1, 4, 5, 24, '2015-04-02 20:32:27', 'Podriamos mejor hacer', 2),
(60, 1, 4, 5, 52, '2015-04-02 20:32:42', 'Preguntemos al maestro', 11),
(61, 1, 4, 5, 24, '2015-04-02 20:33:12', 'Podriamos mejor d', 2),
(62, 1, 4, 5, 52, '2015-04-02 20:33:32', 'Preguntemos al maestro', 11),
(63, 1, 4, 5, 70, '2015-04-02 20:33:38', 'Dejenme mostrarles', 15),
(64, 1, 5, 5, 45, '2015-04-02 20:36:37', 'Que tal hola si sucede que', 2),
(65, 1, 5, 5, 23, '2015-04-02 20:41:37', 'No estoy de acuerdfffffxq', 2),
(66, 1, 4, 5, 28, '2015-04-02 20:42:17', 'Es correcto', 3),
(67, 1, 5, 5, 75, '2015-04-02 20:42:46', 'Es correctoâ€¦?', 16),
(68, 1, 5, 5, 25, '2015-04-02 22:51:48', 'Entonces podriamos', 2),
(69, 1, 4, 5, 52, '2015-04-02 23:06:02', 'Preguntemos al maddddestro', 11),
(70, 1, 5, 5, 26, '2015-04-02 23:07:43', 'Si suponemos algo', 2),
(71, 1, 5, 5, 23, '2015-04-17 16:51:34', 'No estoy de acuerdo xq cuando vimos lo de las', 2),
(72, 1, 4, 5, 52, '2015-04-17 16:57:15', 'Preguntemos al maestro si ya podemos comenzar la sesion', 11),
(73, 1, 5, 7, 46, '2015-04-17 17:08:19', 'No estoy seguro si ya podemos empezar la sesion', 2),
(74, 1, 4, 7, 24, '2015-04-17 17:08:49', 'Podriamos mejor chk los archivos', 2),
(75, 1, 4, 7, 74, '2015-04-17 17:09:16', 'Podrias x favorjjjjkkk', 16),
(76, 1, 4, 7, 52, '2015-04-17 17:20:21', 'Preguntemos al maestronnn', 11),
(77, 1, 4, 7, 58, '2015-04-17 20:09:44', 'Yo creo que empezemos por identificar que elementos de conocimiento tenemos', 12),
(78, 1, 5, 7, 28, '2015-04-17 20:12:20', 'Es correcto, yo tengo el elemento 1, que habla de los tipos de relaciones entre las clases', 3),
(79, 1, 4, 7, 64, '2015-04-17 20:13:53', 'Puedes explicarme mas acerca de ese elemento', 12),
(80, 1, 5, 7, 66, '2015-04-17 20:14:52', 'Esta bien, existen tipos de relaciones de uno a uno', 14),
(81, 1, 5, 7, 28, '2015-04-17 23:47:25', 'Es correcto', 3),
(82, 1, 5, 7, 81, '2015-04-17 23:47:32', 'Muestrame x favor', 17),
(83, 1, 5, 7, 80, '2015-04-17 23:48:45', 'Tu que piensas de bbbbb', 17),
(84, 1, 5, 7, 77, '2015-04-17 23:49:15', 'Disculpame pero no entendi', 16),
(85, 1, 5, 7, 26, '2015-04-17 23:50:55', 'Si suponemos', 2),
(86, 1, 5, 7, 26, '2015-04-17 23:51:10', 'Si suponemos', 2),
(87, 1, 5, 7, 71, '2015-04-17 23:53:54', 'Resumiendo te digo lo siguiente', 15),
(88, 1, 4, 5, 70, '2015-04-21 00:00:00', 'TEST DESDE CODIGO CYNTHIA', 15),
(89, 1, 4, 5, 70, '2015-04-21 00:00:00', 'TEST DESDE CODIGO CYNTHIA', 15),
(90, 1, 4, 5, 70, '2015-04-21 00:00:00', 'TEST DESDE CODIGO CYNTHIA', 15),
(91, 1, 4, 5, 70, '2015-04-21 00:00:00', 'TEST DESDE CODIGO CYNTHIA', 15),
(92, 1, 4, 5, 70, '2015-04-21 00:00:00', 'TEST DESDE CODIGO CYNTHIA', 15),
(93, 1, 4, 5, 70, '2015-04-21 00:00:00', 'TEST DESDE CODIGO CYNTHIA', 15),
(94, 1, 4, 5, 70, '2015-04-21 00:00:00', 'TEST DESDE CODIGO CYNTHIA', 15),
(95, 1, 4, 5, 70, '2015-04-21 00:00:00', 'TEST DESDE CODIGO CYNTHIA', 15),
(96, 1, 4, 5, 70, '2015-04-21 00:00:00', 'TEST DESDE CODIGO CYNTHIA', 15),
(97, 1, 4, 5, 70, '2015-04-21 00:00:00', 'TEST DESDE CODIGO CYNTHIA', 15),
(98, 1, 4, 5, 70, '2015-04-21 00:00:00', 'TEST DESDE CODIGO CYNTHIA', 15),
(99, 1, 4, 5, 70, '2015-04-21 00:00:00', 'TEST DESDE CODIGO CYNTHIA', 15),
(100, 1, 4, 5, 70, '2015-04-21 00:00:00', 'TEST DESDE CODIGO CYNTHIA', 15),
(101, 1, 4, 5, 70, '2015-04-21 00:00:00', 'TEST DESDE CODIGO CYNTHIA', 15),
(102, 1, 4, 5, 70, '2015-04-21 00:00:00', 'TEST DESDE CODIGO CYNTHIA', 15),
(103, 1, 4, 5, 70, '2015-04-21 00:00:00', 'TEST DESDE CODIGO CYNTHIA', 15),
(104, 1, 4, 5, 70, '2015-04-21 00:00:00', 'TEST DESDE CODIGO CYNTHIA', 15),
(105, 1, 4, 5, 70, '2015-04-21 00:00:00', 'TEST DESDE CODIGO CYNTHIA', 15),
(106, 1, 4, 5, 70, '2015-04-21 00:00:00', 'TEST DESDE CODIGO CYNTHIA', 15),
(107, 1, 4, 5, 70, '2015-04-21 00:00:00', 'TEST DESDE CODIGO CYNTHIA', 15),
(108, 1, 4, 5, 70, '2015-04-21 00:00:00', 'TEST DESDE CODIGO CYNTHIA', 15),
(109, 1, 4, 5, 70, '2015-04-21 00:00:00', 'TEST DESDE CODIGO CYNTHIA', 15),
(110, 1, 4, 5, 70, '2015-04-21 00:00:00', 'TEST DESDE CODIGO CYNTHIA', 15),
(111, 1, 4, 5, 23, '1970-01-01 01:00:00', 'LO LOGRASTE CYNTHIA', 2),
(112, 1, 4, 5, 23, '1970-01-01 01:00:00', 'LO LOGRASTE CYNTHIA', 2),
(113, 1, 4, 5, 23, '1970-01-01 01:00:00', 'LO LOGRASTE CYNTHIA', 2),
(114, 1, 4, 5, 23, '1970-01-01 01:00:00', 'LO LOGRASTE CYNTHIA', 2),
(115, 1, 5, 8, 23, '1970-01-01 01:00:00', 'No estoy de acuerdo xq sss', 2),
(116, 1, 4, 8, 58, '1970-01-01 01:00:00', 'Yo creo que jjj', 12),
(117, 1, 5, 8, 24, '1970-01-01 01:00:00', 'Podriamos mejor hhdhd', 2),
(118, 1, 5, 8, 66, '1970-01-01 01:00:00', 'Esta bien, vamos a hacerlo', 14),
(119, 1, 5, 8, 71, '1970-01-01 01:00:00', 'Resumiendo podriamos decir que es una operacion de compra', 15),
(120, 1, 5, 8, 70, '1970-01-01 01:00:00', 'Dejenme mostrarles que es facil reducir este ejemplo', 15),
(121, 1, 5, 8, 28, '1970-01-01 01:00:00', 'Es correctov', 3),
(122, 1, 5, 8, 76, '1970-01-01 01:00:00', 'Yo te entiendo ese asunto', 16),
(123, 1, 4, 8, 25, '2015-04-29 15:11:59', 'Entonces vamos a empezar este asunto', 2),
(124, 1, 5, 8, 52, '2015-04-29 15:12:20', 'Preguntemos al maestro si es necesario dibujar un diagrama', 11),
(125, 1, 4, 8, 70, '2015-04-29 15:13:52', 'Dejenme mostrarles lo que yo creo', 15),
(126, 1, 4, 8, 66, '2015-04-29 15:17:15', 'Esta bien', 14),
(127, 1, 4, 8, 58, '2015-04-29 15:21:06', 'Yo creo que hhhh', 12),
(128, 1, 4, 8, 71, '2015-04-29 15:23:20', 'Resumiendo digamos que esto es', 15),
(129, 1, 4, 8, 72, '2015-04-29 15:28:56', 'Adios', 15),
(130, 1, 5, 8, 78, '2015-04-29 15:29:35', 'Puedes decirme xq no fue necesario el elem2', 17),
(131, 1, 5, 7, 80, '2015-04-29 15:38:14', 'Tu que piensas de', 17),
(132, 1, 4, 7, 79, '2015-04-29 15:40:08', 'Porque piensas eso?', 17),
(133, 1, 5, 7, 59, '2015-04-29 15:40:27', 'Para eso ghghghghg', 12),
(134, 1, 4, 7, 28, '2015-04-29 15:40:37', 'Es correcto', 3),
(135, 1, 4, 7, 28, '2015-04-29 15:41:10', 'Es correcto', 3),
(136, 1, 5, 7, 61, '2015-04-29 15:42:52', 'Para justificar hay que', 12),
(137, 1, 4, 7, 75, '2015-04-29 15:43:08', 'Es correctoâ€¦?', 16),
(138, 1, 4, 7, 52, '2015-04-29 15:43:24', 'Preguntemos al maestro', 11),
(139, 1, 5, 7, 66, '2015-04-29 15:44:09', 'Esta bien', 14),
(140, 1, 5, 7, 52, '2015-04-29 15:50:24', 'Preguntemos al maestro', 11),
(141, 1, 4, 7, 58, '2015-04-29 15:51:05', 'Yo creo que', 12),
(142, 1, 5, 7, 71, '2015-04-29 15:51:18', 'Resumiendo', 15),
(143, 1, 4, 7, 66, '2015-04-29 15:52:40', 'Esta bien', 14),
(144, 1, 4, 7, 74, '2015-04-29 15:53:22', 'Podrias x favor', 16),
(145, 1, 5, 7, 76, '2015-04-29 15:53:43', 'Yo te entiendo', 16),
(146, 1, 5, 7, 24, '2015-04-29 15:54:08', 'Podriamos mejor usare el metodo dd', 2),
(147, 1, 5, 7, 66, '2015-04-29 15:57:31', 'Esta bien', 14),
(148, 1, 4, 7, 70, '2015-04-29 15:57:50', 'Dejenme mostrarles lo siguiente', 15),
(149, 1, 4, 7, 60, '2015-04-29 16:01:09', 'Permiteme explicar que paso', 12),
(150, 1, 5, 7, 45, '2015-04-29 16:01:35', 'Que tal si sucede que la x no se encuentra', 2),
(151, 1, 5, 7, 60, '2015-04-29 16:02:26', 'Permiteme explicar que paso', 12),
(152, 1, 5, 7, 61, '2015-04-29 16:06:45', 'Para justificar hay que paso con la x', 12),
(153, 1, 5, 7, 74, '2015-04-29 16:07:04', 'Podrias x favor preparar el ide', 16),
(154, 1, 4, 7, 25, '2015-04-29 16:07:32', 'Entonces tu que vaz a hacer', 2),
(155, 1, 5, 7, 27, '2015-04-29 16:10:58', 'Muy bien', 3),
(156, 1, 4, 7, 62, '2015-04-29 16:19:32', 'Yo estoy seguro que', 12),
(157, 1, 5, 7, 78, '2015-04-29 16:20:01', 'Puedes decirme de que hablas', 17),
(158, 1, 4, 7, 70, '2015-04-29 16:23:25', 'Dejenme mostrarles', 15),
(159, 1, 4, 7, 60, '2015-04-29 16:32:24', 'Permiteme explicar que', 12),
(160, 1, 5, 7, 70, '2015-04-29 16:43:24', 'Dejenme mostrarles', 15),
(161, 1, 4, 7, 80, '2015-04-29 16:43:40', 'Tu que piensas de', 17),
(162, 1, 4, 7, 79, '2015-04-29 16:44:00', 'Porque piensas eso?', 17),
(163, 1, 4, 7, 65, '2015-04-29 17:05:55', 'Gracias por la aportacion', 14),
(164, 1, 5, 7, 23, '2015-04-29 17:07:15', 'No estoy de acuerdo xq el lado del cliente no debe validar los parametros', 2),
(165, 1, 5, 7, 57, '2015-04-29 17:11:38', 'Yo pienso que deberiamos revisar todos los elementos', 12),
(166, 1, 4, 7, 26, '2015-04-29 17:12:18', 'Si suponemos que hay un caso de excepcion entonces no se xq no lo manejamos en dos partes', 2),
(167, 1, 4, 7, 74, '2015-04-29 17:19:44', 'Podrias x favor', 16),
(168, 1, 4, 7, 59, '2015-04-29 17:22:45', 'Elaboremos un ejemplo antes de empezar como base para guiarnos', 12),
(169, 1, 5, 7, 70, '2015-04-29 18:40:08', 'Dejenme mostrarles', 15),
(170, 1, 5, 7, 23, '2015-04-29 23:32:12', 'No estoy de acuerdo xq', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clase`
--

CREATE TABLE IF NOT EXISTS `clase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL COMMENT 'habilidad',
  `subnombre` varchar(50) NOT NULL COMMENT 'habilidad',
  `model_id` int(11) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_model_idx` (`model_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=19 ;

--
-- Volcado de datos para la tabla `clase`
--

INSERT INTO `clase` (`id`, `nombre`, `subnombre`, `model_id`, `is_default`) VALUES
(2, 'Conflicto creativo', 'Argumentar', 1, 0),
(3, 'Aprendizaje activo\n', 'Motivar', 1, 0),
(11, 'Conflicto creativo', 'Mediar', 1, 0),
(12, 'Aprendizaje activo', 'Informar', 1, 0),
(14, 'Conversacion', 'Reconocer', 1, 0),
(15, 'Conversacion', 'Tarea', 1, 0),
(16, 'Mantenimiento', 'Mantenimiento', 1, 0),
(17, 'Mantenimiento', 'Requerir', 1, 0),
(18, 'TEST CLASE MODELO 2', 'TEST DE ATRIBUTO', 2, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `data`
--

CREATE TABLE IF NOT EXISTS `data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(30) NOT NULL,
  `fecha` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiante_tests`
--

CREATE TABLE IF NOT EXISTS `estudiante_tests` (
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupos_colaborativos`
--

CREATE TABLE IF NOT EXISTS `grupos_colaborativos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_tutor` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `num_integrantes` int(11) NOT NULL DEFAULT '3',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `grupos_colaborativos`
--

INSERT INTO `grupos_colaborativos` (`id`, `id_tutor`, `fecha`, `nombre`, `num_integrantes`) VALUES
(1, 1, '2015-04-29', 'GRUPO A', 2),
(4, 1, '2015-04-17', 'GRUPO B', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupos_colaborativos_usuarios`
--

CREATE TABLE IF NOT EXISTS `grupos_colaborativos_usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `activity_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_grupos_colaborativos_usuarios_grupos_colaborativos1_idx` (`group_id`),
  KEY `fk_grupos_colaborativos_usuarios_usuarios1_idx` (`user_id`),
  KEY `fk_grupos_colaborativos_usuarios_actividad_colaborativa1_idx` (`activity_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=23 ;

--
-- Volcado de datos para la tabla `grupos_colaborativos_usuarios`
--

INSERT INTO `grupos_colaborativos_usuarios` (`id`, `group_id`, `user_id`, `activity_id`) VALUES
(16, 4, 3, 5),
(17, 4, 12, 5),
(18, 4, 13, 5),
(21, 1, 5, 7),
(22, 1, 4, 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `indicadores`
--

CREATE TABLE IF NOT EXISTS `indicadores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class_id` int(11) NOT NULL,
  `nombre` char(20) NOT NULL,
  `frecuencia_individual` tinyint(11) DEFAULT '0',
  `frecuencia_grupo` tinyint(11) DEFAULT '0',
  `tolerancia` tinyint(11) DEFAULT '0',
  `apertura` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_indicadores_clase1_idx` (`class_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Tabla para configurar el modelo de estados CLL' AUTO_INCREMENT=82 ;

--
-- Volcado de datos para la tabla `indicadores`
--

INSERT INTO `indicadores` (`id`, `class_id`, `nombre`, `frecuencia_individual`, `frecuencia_grupo`, `tolerancia`, `apertura`) VALUES
(21, 2, 'Concertar', 0, 0, 0, 'Estoy de acuerdo xq'),
(22, 2, 'Conciliar', 0, 0, 0, 'Ambos estan correctos,'),
(23, 2, 'Discrepar', 0, 0, 0, 'No estoy de acuerdo xq'),
(24, 2, 'Alternativa', 0, 0, 0, 'Podriamos mejor'),
(25, 2, 'Inferir', 0, 0, 0, 'Entonces'),
(26, 2, 'Suponer', 0, 0, 0, 'Si suponemos'),
(27, 3, 'Animar', 0, 0, 0, 'Muy bien'),
(28, 3, 'Reforzar', 0, 0, 0, 'Es correcto'),
(45, 2, 'Exepcion', 0, 0, 0, 'Que tal si sucede que'),
(46, 2, 'Dudar', 0, 0, 0, 'No estoy seguro nnn'),
(52, 11, 'Docente', 0, 0, 0, 'Preguntemos al maestro'),
(56, 12, 'Parafresear', 0, 0, 0, 'Osea que'),
(57, 12, 'Guiar', 0, 0, 0, 'Yo pienso que deberiamos'),
(58, 12, 'Sugerir', 0, 0, 0, 'Yo creo que'),
(59, 12, 'Elaborar', 0, 0, 0, 'Para eso'),
(60, 12, 'Explicar', 0, 0, 0, 'Permiteme explicar que'),
(61, 12, 'Justificar', 0, 0, 0, 'Para justificar hay que'),
(62, 12, 'Afirmar', 0, 0, 0, 'Yo estoy seguro que'),
(63, 12, 'Informacion', 0, 0, 0, 'Sabes xq'),
(64, 12, 'Elaboracion', 0, 0, 0, 'Puedes explicarme mas acerca de'),
(65, 14, 'Apreciacion', 0, 0, 0, 'Gracias'),
(66, 14, 'Aceptacion', 0, 0, 0, 'Esta bien'),
(67, 14, 'Rechazo', 0, 0, 0, 'No'),
(69, 15, 'Coordinar', 0, 0, 0, 'Bien, hagamos lo siguiente'),
(70, 15, 'Cambio enfoque', 0, 0, 0, 'Dejenme mostrarles'),
(71, 15, 'Resumir', 0, 0, 0, 'Resumiendo'),
(72, 15, 'Finalizar', 0, 0, 0, 'Adios'),
(73, 16, 'Requerir atencion', 0, 0, 0, 'Atiendeme'),
(74, 16, 'Sugerir accion', 0, 0, 0, 'Podrias x favor'),
(75, 16, 'Requerir confirmacio', 0, 0, 0, 'Es correctoâ€¦?'),
(76, 16, 'Atender', 0, 0, 0, 'Yo te entiendo'),
(77, 16, 'Disculparse', 0, 0, 0, 'Disculpame'),
(78, 17, 'Clarificacion', 0, 0, 0, 'Puedes decirme xq'),
(79, 17, 'Justificacion', 0, 0, 0, 'Porque piensas eso?'),
(80, 17, 'Opinion', 0, 0, 0, 'Tu que piensas de'),
(81, 17, 'Ilustracion', 0, 0, 0, 'Muestrame x favor');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modelos`
--

CREATE TABLE IF NOT EXISTS `modelos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Tabla intermedia para relacional actividad colaborativa con el modelo de estados' AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `modelos`
--

INSERT INTO `modelos` (`id`, `nombre`, `is_default`) VALUES
(1, 'Taxonomia_Soller', 1),
(2, 'Taxonomia_Jhonson', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `moodle_rcd`
--

CREATE TABLE IF NOT EXISTS `moodle_rcd` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1118 ;

--
-- Volcado de datos para la tabla `moodle_rcd`
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
(1115, 0, '', 1, 0, '', 'prueba desde moodle+cve', '2014-12-08 09:00:53', NULL, 1),
(1116, 0, '', 1, 0, '', '', '2015-04-03 12:54:36', NULL, 1),
(1117, 0, '', 1, 0, '', '', '2015-04-03 12:55:06', NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tests`
--

CREATE TABLE IF NOT EXISTS `tests` (
  `Id_test` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre_Test` varchar(100) NOT NULL,
  `Descripcion` varchar(200) NOT NULL,
  `Id_Tutor` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`Id_test`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Examenes de evaluacion colaborativos' AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `tests`
--

INSERT INTO `tests` (`Id_test`, `Nombre_Test`, `Descripcion`, `Id_Tutor`) VALUES
(3, 'Prueba Exploratoria', 'Prueba para garantizar los supuestos de independencia del experimento, se enfoca en conocer el nivel de conocimiento inicial en base a los elementos de conocimiento. (antes de la colaboracion)', 2),
(4, 'Prueba Post-Colaborativa', 'Se enfoca en analizar el nivel de conocimiento individual en base a los elementos de conocimiento.', 2),
(5, 'Cuestionario de percepcion', 'Evalua en escala Likert la persepcion del estudiante con respecto a los elementos, funciones y procesos del CSCL', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE IF NOT EXISTS `usuarios` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Usuarios registrados en el Juego CLL' AUTO_INCREMENT=15 ;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `apellido_paterno`, `apellido_materno`, `usuario`, `password`, `sexo`, `ciudad`, `estado`, `email`, `tipo`, `curso_moodle`, `Id_UserMoodle`, `lis_resource_linkid`, `lis_outcomes_service_url`, `lis_result_sourceid`) VALUES
(1, 'Irving', 'Caro', 'Fierros', 'wirwing', 'password', NULL, NULL, NULL, 'irving@hotmail.com', 1, 'Programacion Ajax', NULL, NULL, NULL, NULL),
(2, 'Mauricio', 'Lara', 'Soberanis', 'mauricio', 'password', NULL, NULL, NULL, 'mauricio@hotmail.com', 1, 'Programacion Ajax', NULL, NULL, NULL, NULL),
(3, 'Jaime', 'Negrete', 'Chinchilla', 'chinchil', 'password', NULL, NULL, NULL, 'chinchilla@hotmail.com', 2, 'Programacion Ajax', NULL, NULL, NULL, NULL),
(4, 'Ricardo', 'Apellido1', 'Apellido2', 'ricardo', 'password', NULL, NULL, NULL, 'ricardo@hotmail.com', 2, 'Estructuras de Programacion', NULL, NULL, NULL, NULL),
(5, 'Arit', 'Apellido', 'Apellido', 'arit', 'password', NULL, NULL, NULL, 'arit@hotmail.com', 2, 'Estructuras de programacion', NULL, NULL, NULL, NULL),
(6, 'alumnox', 'xxx', 'yyy', 'alumnox', 'password', NULL, NULL, NULL, 'alumnox', 2, 'Programacion II', NULL, NULL, NULL, NULL),
(7, 'Sandra', 'Romero', 'Chams', 'sandra', 'password', NULL, NULL, NULL, 'sandra@hotmail.com', 2, 'Moodle', NULL, NULL, NULL, NULL),
(9, 'Lorenzo', 'Matas', 'Espinoza', 'lorenzo', 'password', NULL, NULL, NULL, 'lorenzo@hotmail.com', 2, 'Moodle', NULL, NULL, NULL, NULL),
(11, 'Admin User', 'ap_paterno', 'ap_materno', 'cyntsc10@gmail.com', 'password', NULL, NULL, NULL, 'cyntsc10@gmail.com', 1, 'Programacion I', NULL, NULL, NULL, NULL),
(12, 'Alicia XX', 'ap_paterno', 'ap_materno', 'aliciaxx@hotmail.com', 'password', NULL, NULL, NULL, 'aliciaxx@hotmail.com', 2, 'Programacion I', NULL, NULL, NULL, NULL),
(13, 'Jorge XX', 'ap_paterno', 'ap_materno', 'jorge@hotmail.com', 'password', NULL, NULL, NULL, 'jorge@hotmail.com', 2, 'Programacion I', NULL, NULL, NULL, NULL),
(14, '', 'ap_paterno', 'ap_materno', '', 'password', NULL, NULL, NULL, '', 1, '', NULL, NULL, NULL, NULL);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `actividades_colaborativas`
--
ALTER TABLE `actividades_colaborativas`
  ADD CONSTRAINT `fk_actividad_colaborativa_modelo` FOREIGN KEY (`id_modelo`) REFERENCES `modelos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `archivos_adjuntos`
--
ALTER TABLE `archivos_adjuntos`
  ADD CONSTRAINT `fk_archivos_adjuntos_actividad_colaborativa1` FOREIGN KEY (`id_actividad`) REFERENCES `actividades_colaborativas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `clase`
--
ALTER TABLE `clase`
  ADD CONSTRAINT `fk_model` FOREIGN KEY (`model_id`) REFERENCES `modelos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `grupos_colaborativos_usuarios`
--
ALTER TABLE `grupos_colaborativos_usuarios`
  ADD CONSTRAINT `fk_grupos_colaborativos_usuarios_grupos_colaborativos1` FOREIGN KEY (`group_id`) REFERENCES `grupos_colaborativos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_grupos_colaborativos_usuarios_usuarios1` FOREIGN KEY (`user_id`) REFERENCES `usuarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `indicadores`
--
ALTER TABLE `indicadores`
  ADD CONSTRAINT `fk_class` FOREIGN KEY (`class_id`) REFERENCES `clase` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
