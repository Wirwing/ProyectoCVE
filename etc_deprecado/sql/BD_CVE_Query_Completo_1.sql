#�NOMBRE?
-- version 4.0.9
-- http://www.phpmyadmin.net
--
#�NOMBRE?
-- Tiempo de generación: 09-10-2014 a las 19:57:31
-- Versión del servidor: 5.6.14
-- Versión de PHP: 5.5.6

SET SQL_MODE = NO_AUTO_VALUE_ON_ZERO;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

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
  `IdGpo` int(11) NOT NULL,
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
-- Estructura de tabla para la tabla `indicadores`
--

CREATE TABLE IF NOT EXISTS `indicadores` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(30) NOT NULL,
  `Descripcion` varchar(30) NOT NULL,
  `Valor_Sugerido` varchar(30) NOT NULL,
  `Fecha` date NOT NULL,
  `IDAutor` varchar(30) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

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
-- Estructura de tabla para la tabla `link_actividadcolaborativa_indicadores`
--

CREATE TABLE IF NOT EXISTS `link_actividadcolaborativa_indicadores` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `IdActividad` int(11) NOT NULL,
  `IdIndicador` int(11) NOT NULL,
  `Valor_Nvo` int(11) NOT NULL,
  `Valor_tolerancia` int(11) NOT NULL,
  `IDAutor` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

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
  `FechaIni` datetime NOT NULL,
  `FechaFin` datetime DEFAULT NULL,
  `CloseSesion` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=54 ;

-- --------------------------------------------------------

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

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
