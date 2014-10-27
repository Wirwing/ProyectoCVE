SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Base de datos: `cve_fmat_uady`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividadcolaborativa`
--

CREATE TABLE IF NOT EXISTS `actividadcolaborativa` (
  `IDActividad` int(11) NOT NULL AUTO_INCREMENT,
  `IdTutor` int(11) NOT NULL,
  `Fecha` date NOT NULL,
  `Tipo` varchar(50) NOT NULL,
  `EstrategiaInstruccional` varchar(50) NOT NULL,
  `DuracionMin` int(11) NOT NULL,
  `Nombre` varchar(50) NOT NULL,
  `Descripcion` varchar(200) NOT NULL,
  `Adjuntos` bit(1) NOT NULL,
  `Indicadores_Personalizados` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`IDActividad`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `actividadcolaborativa`
--

INSERT INTO `actividadcolaborativa` (`IDActividad`, `IdTutor`, `Fecha`, `Tipo`, `EstrategiaInstruccional`, `DuracionMin`, `Nombre`, `Descripcion`, `Adjuntos`, `Indicadores_Personalizados`) VALUES
(1, 10, '2014-10-09', 'CONSTRUCTIVISTA', 'ROMPECABEZAS', 50, 'Resolver el problema adjunto con estructura WHILE', '', b'0', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `archivosadjuntos`
--

CREATE TABLE IF NOT EXISTS `archivosadjuntos` (
  `IdArchivoAdjunto` int(11) NOT NULL AUTO_INCREMENT,
  `IdTutor` int(11) NOT NULL,
  `Fecha` date NOT NULL,
  `Nombre` varchar(100) NOT NULL,
  `URL` varchar(100) NOT NULL,
  PRIMARY KEY (`IdArchivoAdjunto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `chat_extendido`
--

CREATE TABLE IF NOT EXISTS `chat_extendido` (
  `IdChatLog` int(11) NOT NULL,
  `Acuerdo` int(11) NOT NULL,
  `NoAcuerdo` int(11) NOT NULL,
  PRIMARY KEY (`IdChatLog`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `chat_log`
--

CREATE TABLE IF NOT EXISTS `chat_log` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `IdChatSesion` int(11) NOT NULL,
  `IdUsuario` int(11) NOT NULL,
  `IdActividad` int(11) NOT NULL,
  `IdIndicador` int(11) NOT NULL,
  `Fecha` datetime NOT NULL,
  `Log` varchar(500) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gruposcolaborativos`
--

CREATE TABLE IF NOT EXISTS `gruposcolaborativos` (
  `IDGpo` int(11) NOT NULL AUTO_INCREMENT,
  `IdTutor` int(11) NOT NULL,
  `Fecha` date NOT NULL,
  `NombreGpo` varchar(50) NOT NULL,
  `NumIntegrantes` int(11) NOT NULL,
  PRIMARY KEY (`IDGpo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `link_actividadcolaborativa_archivos`
--

CREATE TABLE IF NOT EXISTS `link_actividadcolaborativa_archivos` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `IdActividad` int(11) NOT NULL,
  `IdArchivoAdjunto` int(11) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `link_actividad_modelo`
--

CREATE TABLE IF NOT EXISTS `link_actividad_modelo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `IdActividad` int(11) NOT NULL,
  `IdModelo` int(11) NOT NULL,
  `Estado` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Tabla intermedia para relacional actividad colaborativa con el modelo de estados' AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `link_actividad_modelo`
--

INSERT INTO `link_actividad_modelo` (`id`, `IdActividad`, `IdModelo`, `Estado`) VALUES
(1, 1, 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `link_gruposcolaborativos_usuarios`
--

CREATE TABLE IF NOT EXISTS `link_gruposcolaborativos_usuarios` (
  `Id_Link_GruposColaborativos_Usuarios` int(11) NOT NULL AUTO_INCREMENT,
  `IdGpo` int(11) NOT NULL,
  `IdUsuario` int(11) NOT NULL,
  `IdActividad` int(11) NOT NULL,
  PRIMARY KEY (`Id_Link_GruposColaborativos_Usuarios`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modelo_estados_config`
--

CREATE TABLE IF NOT EXISTS `modelo_estados_config` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `IdModelo` int(11) NOT NULL,
  `Nombre_indicador` char(20) NOT NULL,
  `Frec_Indiv` tinyint(4) NOT NULL,
  `Frec_Gpo` tinyint(4) NOT NULL,
  `Tolerancia` tinyint(4) NOT NULL,
  `Frec_Indiv2` tinyint(4) DEFAULT NULL,
  `Frec_Gpo2` tinyint(4) DEFAULT NULL,
  `Tolerancia2` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Tabla para configurar el modelo de estados CLL' AUTO_INCREMENT=8 ;

--
-- Volcado de datos para la tabla `modelo_estados_config`
--

INSERT INTO `modelo_estados_config` (`ID`, `IdModelo`, `Nombre_indicador`, `Frec_Indiv`, `Frec_Gpo`, `Tolerancia`, `Frec_Indiv2`, `Frec_Gpo2`, `Tolerancia2`) VALUES
(4, 1, 'argumento', 30, 30, 10, NULL, NULL, NULL),
(5, 1, 'idea', 20, 30, 10, NULL, NULL, NULL),
(6, 1, 'duda', 20, 20, 15, NULL, NULL, NULL),
(7, 1, 'pregunta', 20, 20, 10, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `moodle_rcd`
--

CREATE TABLE IF NOT EXISTS `moodle_rcd` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `IdUser` int(11) NOT NULL,
  `UserName` varchar(100) NOT NULL,
  `Rol` tinyint(4) NOT NULL,
  `IdCourse` int(11) NOT NULL,
  `CourseName` varchar(100) NOT NULL,
  `EmailSesion` varchar(100) NOT NULL,
  `FechaIni` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `FechaFin` datetime DEFAULT NULL,
  `CloseSesion` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=100 ;


--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE IF NOT EXISTS `usuarios` (
  `IDUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(30) NOT NULL,
  `AP_PAT` varchar(30) NOT NULL,
  `AP_MAT` varchar(30) NOT NULL,
 `USUARIO` varchar(8) NOT NULL,
  `PASSWORD` varchar(8) NOT NULL,
  `SEXO` bit(1) DEFAULT NULL,
  `CIUDAD` varchar(30) DEFAULT NULL,
  `ESTADO` varchar(30) DEFAULT NULL,
  `EMAIL` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`IDUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Usuarios registrados en el Juego CLL' AUTO_INCREMENT=1 ;