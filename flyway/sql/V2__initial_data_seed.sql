USE `db_cve_fmat_uady` ;

--
-- Volcado de datos para la tabla `actividad_colaborativa`
--
INSERT INTO `actividad_colaborativa` (`id`, `id_tutor`, `fecha`, `tipo`, `estrategia_instruccional`, `duracion_minima`, `nombre`, `descripcion`, `adjuntos`, `indicadores_personalizados`) VALUES
(1, 10, '2014-10-09', 'CONSTRUCTIVISTA', 'ROMPECABEZAS', 50, 'Resolver el problema adjunto con estructura WHILE', '', 0, 1);

--
-- Volcado de datos para la tabla `actividad_modelo`
--
INSERT INTO `actividad_modelo` (`id`, `id_actividad`, `id_modelo`, `estado`) VALUES
(1, 1, 1, 0);

--
-- Volcado de datos para la tabla `modelo_estados_configuracion`
--
INSERT INTO `modelo_estados_configuracion` (`id`, `id_modelo`, `nombre_indicador`, `frecuencia_individual`, `frecuencia_grupo`, `tolerancia`, `frecuencia_individual2`, `frecuencia_grupo2`, `tolerancia2`) VALUES
(4, 1, 'argumento', 30, 30, 10, NULL, NULL, NULL),
(5, 1, 'idea', 20, 30, 10, NULL, NULL, NULL),
(6, 1, 'duda', 20, 20, 15, NULL, NULL, NULL),
(7, 1, 'pregunta', 20, 20, 10, NULL, NULL, NULL);
