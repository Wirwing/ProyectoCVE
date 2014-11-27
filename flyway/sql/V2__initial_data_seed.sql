USE `db_cve_fmat_uady` ;

--
-- Volcado de datos para la tabla `modelo`
--
INSERT INTO `modelos` (`id`, `nombre`, `is_default`) VALUES
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
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `apellido_paterno`, `apellido_materno`, `usuario`, `password`, `sexo`, `ciudad`, `estado`, `email`, `tipo`) VALUES
(1, 'Irving', 'Caro', 'Fierros', 'wirwing', 'password', NULL, NULL, NULL, NULL, 1),
(2, 'Mauricio', 'Lara', 'Soberanis', 'mauricio', 'password', NULL, NULL, NULL, NULL, 1),
(3, 'Jaime', 'Negrete', 'Chinchilla', 'chinchil', 'password', NULL, NULL, NULL, NULL, 2),
(4, 'Ricardo', 'Apellido1', 'Apellido2', 'ricardo', 'password', NULL, NULL, NULL, NULL, 2),
(5, 'Arit', 'Apellido', 'Apellido', 'arit', 'password', NULL, NULL, NULL, NULL, 2);

--
-- Volcado de datos para la tabla `actividad_colaborativa`
--
INSERT INTO `actividades_colaborativas` (`id`, `id_modelo`, `id_tutor`, `nombre`,
	`descripcion`, `fecha`, `tipo`, `estrategia_instruccional`,
	 `duracion_minima`) VALUES
	(5, 1, 1, 'Resolver el problema adjunto con estructura WHILE', '', '2014-10-09', 'CONSTRUCTIVISTA', 'ROMPECABEZAS', 50);

	--
	-- Volcado de datos para la tabla `chat_logs`
	--

INSERT INTO `chat_logs` (`id`, `id_grupo`, `id_usuario`, `id_actividad`, `id_indicador`, `fecha`, `message`) VALUES
(10, 1, 4, 5, 3, '2014-11-27 15:19:20', 'Esta es una idea');


	--
	-- Dumping data for table `grupos_colaborativos`
	--

INSERT INTO `grupos_colaborativos` (`id`, `id_tutor`, `fecha`, `nombre`, `num_integrantes`) VALUES
(1, 1, '2014-11-26', 'TEST_GROUP', 2);

	--
	-- Dumping data for table `grupos_colaborativos_usuarios`
	--

INSERT INTO `grupos_colaborativos_usuarios` (`id`, `group_id`, `user_id`, `activity_id`) VALUES
(3, 1, 5, 5),
(4, 1, 4, 5);
