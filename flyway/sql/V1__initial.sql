SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividad_colaborativa`
--

CREATE TABLE IF NOT EXISTS `actividad_colaborativa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_tutor` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `estrategia_instruccional` varchar(50) NOT NULL,
  `duracion_minima` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(200) NOT NULL,
  `adjuntos` tinyint(1) NOT NULL,
  `indicadores_personalizados` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `archivos_adjuntos`
--

CREATE TABLE IF NOT EXISTS `archivos_adjuntos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_tutor` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `url` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
-- Estructura de tabla para la tabla `chat_log`
--

CREATE TABLE IF NOT EXISTS `chat_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_chat_sesion` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_actividad` int(11) NOT NULL,
  `id_indicador` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `log` varchar(500) NOT NULL,
  PRIMARY KEY (`id`)
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
  `num_integrantes` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
-- Estructura de tabla para la tabla `actividad_modelo`
--

CREATE TABLE IF NOT EXISTS `actividad_modelo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_actividad` int(11) NOT NULL,
  `id_modelo` int(11) NOT NULL,
  `estado` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Tabla intermedia para relacional actividad colaborativa con el modelo de estados' AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupos_colaborativos_usuarios`
--
CREATE TABLE IF NOT EXISTS `grupos_colaborativos_usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_grupo` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_actividad` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modelo_estados_configuracion`
--

CREATE TABLE IF NOT EXISTS `modelo_estados_configuracion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_modelo` int(11) NOT NULL,
  `nombre_indicador` char(20) NOT NULL,
  `frecuencia_individual` tinyint(4) NOT NULL,
  `frecuencia_grupo` tinyint(4) NOT NULL,
  `tolerancia` tinyint(4) NOT NULL,
  `frecuencia_individual2` tinyint(4) DEFAULT NULL,
  `frecuencia_grupo2` tinyint(4) DEFAULT NULL,
  `tolerancia2` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Tabla para configurar el modelo de estados CLL' AUTO_INCREMENT=8 ;


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
  `fecha_inicio` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_final` datetime DEFAULT NULL,
  `close_sesion` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=100 ;


--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE IF NOT EXISTS `usuarios` (
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Usuarios registrados en el Juego CLL' AUTO_INCREMENT=1 ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;