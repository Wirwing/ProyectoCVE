USE `db_cve_fmat_uady` ;

--
-- Volcado de datos para la tabla `modelo`
--
INSERT INTO `modelo` (`id`, `nombre`, `is_default`) VALUES
(1, "Default", 1);

--
-- Volcado de datos para la tabla `indicadores`
--
INSERT INTO `indicadores` (`id`, `id_modelo`, `nombre`, `frecuencia_individual`, `frecuencia_grupo`, `tolerancia`) VALUES
(1, 1, 'Argumento', 30, 30, 10),
(2, 1, 'Idea', 20, 30, 10),
(3, 1, 'Duda', 20, 20, 15),
(4, 1, 'Pregunta', 20, 20, 10);

--
-- Volcado de datos para la tabla `usuarios`
--
INSERT INTO `usuarios` (`id`, `nombre`, `apellido_paterno`, 
	`apellido_materno`, `usuario`, `password`) VALUES
	(1, 'Irving', 'Caro', 'Fierros', 'wirwing', 'password');

--
-- Volcado de datos para la tabla `actividad_colaborativa`
--
INSERT INTO `actividad_colaborativa` (`id`, `id_modelo`, `id_tutor`, `nombre`, 
	`descripcion`, `fecha`, `tipo`, `estrategia_instruccional`,
	 `duracion_minima`) VALUES
	(1, 1, 1, 'Resolver el problema adjunto con estructura WHILE', '', '2014-10-09', 'CONSTRUCTIVISTA', 'ROMPECABEZAS', 50);