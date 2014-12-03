
USE `db_cve_fmat_uady`;

/*Table structure for table `actividades_colaborativas` */

DROP TABLE IF EXISTS `actividades_colaborativas`;

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
  `iniciada` int(11) NOT NULL DEFAULT '0',
  `fecha limite` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_actividad_colaborativa_modelo_idx` (`id_modelo`),
  CONSTRAINT `fk_actividad_colaborativa_modelo` FOREIGN KEY (`id_modelo`) REFERENCES `modelos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `actividades_colaborativas` */

insert  into `actividades_colaborativas`(`id`,`id_modelo`,`id_tutor`,`nombre`,`descripcion`,`fecha`,`tipo`,`estrategia_instruccional`,`duracion_minima`,`iniciada`,`fecha limite`) values (5,1,1,'Resolver el problema adjunto con estructura WHILE','','2014-10-09','CONSTRUCTIVISTA','ROMPECABEZAS',50,1,'2014-12-03 21:15:00'),(6,1,1,'asdasd','asdasd','2014-12-03','1','asdasd',40,0,NULL);

