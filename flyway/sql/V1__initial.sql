SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Table `db_cve_fmat_uady`.`modelos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_cve_fmat_uady`.`modelos` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `is_default` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = 'Tabla intermedia para relacional actividad colaborativa con el modelo de estados';


-- -----------------------------------------------------
-- Table `db_cve_fmat_uady`.`actividades_colaborativas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_cve_fmat_uady`.`actividades_colaborativas` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_modelo` INT(11) NOT NULL,
  `id_tutor` INT(11) NOT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `descripcion` VARCHAR(200) NOT NULL,
  `fecha` DATE NOT NULL,
  `tipo` VARCHAR(50) NOT NULL,
  `estrategia_instruccional` VARCHAR(50) NOT NULL,
  `duracion_minima` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_actividad_colaborativa_modelo_idx` (`id_modelo` ASC),
  CONSTRAINT `fk_actividad_colaborativa_modelo`
    FOREIGN KEY (`id_modelo`)
    REFERENCES `db_cve_fmat_uady`.`modelos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `db_cve_fmat_uady`.`actividad_colaborativa_archivos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_cve_fmat_uady`.`actividad_colaborativa_archivos` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_actividad` INT(11) NOT NULL,
  `id_archivo_adjunto` INT(11) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `db_cve_fmat_uady`.`archivos_adjuntos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_cve_fmat_uady`.`archivos_adjuntos` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_actividad` INT(11) NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `url` VARCHAR(100) NOT NULL,
  `fecha` DATE NOT NULL,
  PRIMARY KEY (`id`, `id_actividad`),
  INDEX `fk_archivos_adjuntos_actividad_colaborativa1_idx` (`id_actividad` ASC),
  CONSTRAINT `fk_archivos_adjuntos_actividad_colaborativa1`
    FOREIGN KEY (`id_actividad`)
    REFERENCES `db_cve_fmat_uady`.`actividades_colaborativas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `db_cve_fmat_uady`.`chat_extendido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_cve_fmat_uady`.`chat_extendido` (
  `id` INT(11) NOT NULL,
  `acuerdo` INT(11) NOT NULL,
  `no_acuerdo` INT(11) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `db_cve_fmat_uady`.`chat_logs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_cve_fmat_uady`.`chat_logs` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_chat_sesion` INT(11) NOT NULL,
  `id_usuario` INT(11) NOT NULL,
  `id_actividad` INT(11) NOT NULL,
  `id_indicador` INT(11) NOT NULL,
  `fecha` DATETIME NOT NULL,
  `log` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `db_cve_fmat_uady`.`grupos_colaborativos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_cve_fmat_uady`.`grupos_colaborativos` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_tutor` INT(11) NOT NULL,
  `fecha` DATE NOT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `num_integrantes` INT(11) NOT NULL DEFAULT 3,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `db_cve_fmat_uady`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_cve_fmat_uady`.`usuarios` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(30) NOT NULL,
  `apellido_paterno` VARCHAR(30) NOT NULL,
  `apellido_materno` VARCHAR(30) NOT NULL,
  `usuario` VARCHAR(8) NOT NULL,
  `password` VARCHAR(8) NOT NULL,
  `sexo` TINYINT(1) NULL DEFAULT NULL,
  `ciudad` VARCHAR(30) NULL DEFAULT NULL,
  `estado` VARCHAR(30) NULL DEFAULT NULL,
  `email` VARCHAR(80) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Usuarios registrados en el Juego CLL';


-- -----------------------------------------------------
-- Table `db_cve_fmat_uady`.`grupos_colaborativos_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_cve_fmat_uady`.`grupos_colaborativos_usuarios` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_grupo` INT(11) NOT NULL,
  `id_usuario` INT(11) NOT NULL,
  `id_actividad` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_grupos_colaborativos_usuarios_grupos_colaborativos1_idx` (`id_grupo` ASC),
  INDEX `fk_grupos_colaborativos_usuarios_usuarios1_idx` (`id_usuario` ASC),
  INDEX `fk_grupos_colaborativos_usuarios_actividad_colaborativa1_idx` (`id_actividad` ASC),
  CONSTRAINT `fk_grupos_colaborativos_usuarios_grupos_colaborativos1`
    FOREIGN KEY (`id_grupo`)
    REFERENCES `db_cve_fmat_uady`.`grupos_colaborativos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grupos_colaborativos_usuarios_usuarios1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `db_cve_fmat_uady`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grupos_colaborativos_usuarios_actividad_colaborativa1`
    FOREIGN KEY (`id_actividad`)
    REFERENCES `db_cve_fmat_uady`.`actividades_colaborativas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `db_cve_fmat_uady`.`indicadores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_cve_fmat_uady`.`indicadores` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_modelo` INT(11) NOT NULL,
  `nombre` CHAR(20) NOT NULL,
  `frecuencia_individual` TINYINT(4) NOT NULL,
  `frecuencia_grupo` TINYINT(4) NOT NULL,
  `tolerancia` TINYINT(4) NOT NULL,
  PRIMARY KEY (`id`, `id_modelo`),
  INDEX `fk_indicadores_modelo1_idx` (`id_modelo` ASC),
  CONSTRAINT `fk_indicadores_modelo1`
    FOREIGN KEY (`id_modelo`)
    REFERENCES `db_cve_fmat_uady`.`modelos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = 'Tabla para configurar el modelo de estados CLL';


-- -----------------------------------------------------
-- Table `db_cve_fmat_uady`.`moodle_rcd`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_cve_fmat_uady`.`moodle_rcd` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_user` INT(11) NOT NULL,
  `username` VARCHAR(100) NOT NULL,
  `rol` TINYINT(4) NOT NULL,
  `id_course` INT(11) NOT NULL,
  `course_name` VARCHAR(100) NOT NULL,
  `email_sesion` VARCHAR(100) NOT NULL,
  `fecha_inicio` DATETIME NOT NULL,
  `fecha_final` DATETIME NULL DEFAULT NULL,
  `close_sesion` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
