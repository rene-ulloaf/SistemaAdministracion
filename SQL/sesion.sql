SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `Sesion` ;
USE `Sesion` ;

-- -----------------------------------------------------
-- Table `Sesion`.`sexo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Sesion`.`sexo` (
  `idSexo` SMALLINT NOT NULL AUTO_INCREMENT ,
  `glosaSexo` VARCHAR(50) NOT NULL ,
  `vigente` TINYINT(1)  NOT NULL DEFAULT true ,
  PRIMARY KEY (`idSexo`) )
ENGINE = InnoDB
COMMENT = 'se guardan los tipos de sexo';


-- -----------------------------------------------------
-- Table `Sesion`.`Continentes`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Sesion`.`Continentes` (
  `idContinente` SMALLINT NOT NULL AUTO_INCREMENT ,
  `glosaContinente` VARCHAR(50) NOT NULL ,
  `vigente` TINYINT(1)  NOT NULL DEFAULT true ,
  PRIMARY KEY (`idContinente`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sesion`.`Idioma`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Sesion`.`Idioma` (
  `idIdioma` SMALLINT NOT NULL ,
  `glosaIdioma` VARCHAR(50) NOT NULL ,
  `vigente` TINYINT(1)  NOT NULL DEFAULT true ,
  PRIMARY KEY (`idIdioma`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sesion`.`Paises`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Sesion`.`Paises` (
  `idpais` SMALLINT NOT NULL ,
  `idContinente` SMALLINT NOT NULL ,
  `nombre` VARCHAR(50) NOT NULL ,
  `idioma` SMALLINT NOT NULL ,
  `gentilicioMasc` VARCHAR(50) NULL ,
  `gentilicioFem` VARCHAR(50) NULL ,
  `bandera` VARCHAR(100) NULL ,
  `vigente` TINYINT(1)  NOT NULL DEFAULT true ,
  PRIMARY KEY (`idpais`) ,
  INDEX `continente` (`idContinente` ASC) ,
  INDEX `idioma` (`idioma` ASC) ,
  CONSTRAINT `continente`
    FOREIGN KEY (`idContinente` )
    REFERENCES `Sesion`.`Continentes` (`idContinente` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idioma`
    FOREIGN KEY (`idioma` )
    REFERENCES `Sesion`.`Idioma` (`idIdioma` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sesion`.`Personas`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Sesion`.`Personas` (
  `idPersona` INT NOT NULL ,
  `rut` VARCHAR(15) NULL ,
  `dv` CHAR(1) NULL ,
  `nombres` VARCHAR(100) NOT NULL ,
  `primerApellido` VARCHAR(50) NOT NULL ,
  `segundoApellido` VARCHAR(50) NULL ,
  `nacionalidad` SMALLINT NOT NULL ,
  `region` SMALLINT NOT NULL ,
  `ciudad` SMALLINT NOT NULL ,
  `comuna` SMALLINT NOT NULL ,
  `direccion` VARCHAR(100) NULL ,
  `numero` SMALLINT NULL ,
  `sexo` SMALLINT NOT NULL ,
  `sistemaIngreso` SMALLINT NOT NULL ,
  `fechaIngreso` DATETIME NOT NULL ,
  `fechaModificacion` DATETIME NOT NULL ,
  `vigente` TINYINT(1)  NOT NULL DEFAULT true ,
  PRIMARY KEY (`idPersona`) ,
  INDEX `sexo` (`sexo` ASC) ,
  INDEX `nacionalidad` (`nacionalidad` ASC) ,
  CONSTRAINT `sexo`
    FOREIGN KEY (`sexo` )
    REFERENCES `Sesion`.`sexo` (`idSexo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `nacionalidad`
    FOREIGN KEY (`nacionalidad` )
    REFERENCES `Sesion`.`Paises` (`idpais` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Se guardan los datos de las personas';


-- -----------------------------------------------------
-- Table `Sesion`.`Usuario`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Sesion`.`Usuario` (
  `idUsuario` INT NOT NULL ,
  `idPersona` INT NOT NULL ,
  `idSistema` INT NOT NULL ,
  `nombreUsuario` VARCHAR(50) NOT NULL ,
  `clave` VARCHAR(32) NOT NULL ,
  `preguntaSecreta` VARCHAR(100) NULL ,
  `respuesta` VARCHAR(100) NULL ,
  `nroIntento` INT NOT NULL DEFAULT 0 ,
  `nroRecuperacion` INT NOT NULL DEFAULT 0 ,
  `bloqueo` BIT NOT NULL DEFAULT false ,
  `fechaIngreso` DATETIME NOT NULL ,
  `vigente` TINYINT(1)  NOT NULL DEFAULT true ,
  PRIMARY KEY (`idUsuario`) ,
  INDEX `idpersona` (`idPersona` ASC) ,
  CONSTRAINT `idpersona`
    FOREIGN KEY (`idPersona` )
    REFERENCES `Sesion`.`Personas` (`idPersona` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'se guardan los datos los datos del inicio de sesión';


-- -----------------------------------------------------
-- Table `Sesion`.`EMail`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Sesion`.`EMail` (
  `idEmail` INT NOT NULL AUTO_INCREMENT ,
  `email` VARCHAR(50) NOT NULL ,
  `vigente` TINYINT(1)  NOT NULL DEFAULT true ,
  PRIMARY KEY (`idEmail`) )
ENGINE = InnoDB
COMMENT = 'Se guardan los e-mail de las personas';


-- -----------------------------------------------------
-- Table `Sesion`.`Persona_Email`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Sesion`.`Persona_Email` (
  `idPersonaEmail` INT NOT NULL AUTO_INCREMENT ,
  `idPersona` INT NOT NULL ,
  `idUsuario` INT NOT NULL ,
  `idEmail` INT NOT NULL ,
  PRIMARY KEY (`idPersonaEmail`) ,
  INDEX `idpersona` (`idPersona` ASC) ,
  INDEX `idUsuario` (`idUsuario` ASC) ,
  INDEX `idemail` (`idEmail` ASC) ,
  CONSTRAINT `idpersona`
    FOREIGN KEY (`idPersona` )
    REFERENCES `Sesion`.`Personas` (`idPersona` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idUsuario`
    FOREIGN KEY (`idUsuario` )
    REFERENCES `Sesion`.`Usuario` (`idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idemail`
    FOREIGN KEY (`idEmail` )
    REFERENCES `Sesion`.`EMail` (`idEmail` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sesion`.`TipoTelefono`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Sesion`.`TipoTelefono` (
  `idTipoTelefono` SMALLINT NOT NULL AUTO_INCREMENT ,
  `glosaTelefono` VARCHAR(50) NOT NULL ,
  `vigente` TINYINT(1)  NOT NULL ,
  PRIMARY KEY (`idTipoTelefono`) )
ENGINE = InnoDB
COMMENT = 'Establece los tipos de telefonos que existen';


-- -----------------------------------------------------
-- Table `Sesion`.`Telefonos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Sesion`.`Telefonos` (
  `idTelefonos` INT NOT NULL AUTO_INCREMENT ,
  `idPersona` INT NOT NULL ,
  `idTipoTelefono` SMALLINT NOT NULL ,
  `telefono` VARCHAR(15) NOT NULL ,
  `vigente` TINYINT(1)  NOT NULL DEFAULT true ,
  `omision` TINYINT(1)  NOT NULL DEFAULT false ,
  PRIMARY KEY (`idTelefonos`) ,
  INDEX `persona` (`idPersona` ASC) ,
  INDEX `tipo_telefono` (`idTipoTelefono` ASC) ,
  CONSTRAINT `persona`
    FOREIGN KEY (`idPersona` )
    REFERENCES `Sesion`.`Personas` (`idPersona` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tipo_telefono`
    FOREIGN KEY (`idTipoTelefono` )
    REFERENCES `Sesion`.`TipoTelefono` (`idTipoTelefono` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'se guardan los teléfonos de las personas';


-- -----------------------------------------------------
-- Table `Sesion`.`Regiones`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Sesion`.`Regiones` (
  `idRegion` SMALLINT NOT NULL AUTO_INCREMENT ,
  `idPais` SMALLINT NOT NULL ,
  `glosaRegion` VARCHAR(50) NOT NULL ,
  `vigente` TINYINT(1)  NOT NULL DEFAULT true ,
  PRIMARY KEY (`idRegion`) ,
  INDEX `pais` (`idPais` ASC) ,
  CONSTRAINT `pais`
    FOREIGN KEY (`idPais` )
    REFERENCES `Sesion`.`Paises` (`idpais` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sesion`.`Ciudades`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Sesion`.`Ciudades` (
  `idciudad` SMALLINT NOT NULL AUTO_INCREMENT ,
  `idRegion` SMALLINT NOT NULL ,
  `glosaCiudad` VARCHAR(50) NOT NULL ,
  `vigente` TINYINT(1)  NOT NULL DEFAULT true ,
  PRIMARY KEY (`idciudad`) ,
  INDEX `region` (`idRegion` ASC) ,
  CONSTRAINT `region`
    FOREIGN KEY (`idRegion` )
    REFERENCES `Sesion`.`Regiones` (`idRegion` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sesion`.`Comunas`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Sesion`.`Comunas` (
  `idcomuna` SMALLINT NOT NULL ,
  `idCiudad` SMALLINT NOT NULL ,
  `glosaComuna` VARCHAR(50) NOT NULL ,
  `vigente` TINYINT(1)  NOT NULL ,
  PRIMARY KEY (`idcomuna`) ,
  INDEX `ciudad` (`idCiudad` ASC) ,
  CONSTRAINT `ciudad`
    FOREIGN KEY (`idCiudad` )
    REFERENCES `Sesion`.`Ciudades` (`idciudad` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sesion`.`Plataforma`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Sesion`.`Plataforma` (
  `idPlataforma` SMALLINT NOT NULL ,
  `glosaPlataforma` VARCHAR(50) NOT NULL ,
  `vigente` TINYINT(1)  NOT NULL DEFAULT true ,
  PRIMARY KEY (`idPlataforma`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sesion`.`SistemaOperativo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Sesion`.`SistemaOperativo` (
  `idSistemaOperativo` SMALLINT NOT NULL ,
  `glosaSistemaOperativo` VARCHAR(50) NOT NULL ,
  `vigente` TINYINT(1)  NOT NULL DEFAULT true ,
  PRIMARY KEY (`idSistemaOperativo`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sesion`.`Lenguaje`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Sesion`.`Lenguaje` (
  `idLenguaje` SMALLINT NOT NULL ,
  `glosaLenguaje` VARCHAR(50) NOT NULL ,
  `vigente` TINYINT(1)  NOT NULL DEFAULT true ,
  PRIMARY KEY (`idLenguaje`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sesion`.`Estilos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Sesion`.`Estilos` (
  `idEstilo` SMALLINT NOT NULL ,
  `tipo` VARCHAR(10) NOT NULL ,
  `nombreEstilo` VARCHAR(50) NOT NULL ,
  `descripcion` VARCHAR(100) NULL ,
  `vigente` TINYINT(1)  NOT NULL DEFAULT true ,
  PRIMARY KEY (`idEstilo`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sesion`.`Sistema`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Sesion`.`Sistema` (
  `idSistema` INT NOT NULL ,
  `nombreSistema` VARCHAR(50) NOT NULL ,
  `sitioURL` VARCHAR(100) NULL ,
  `imagen` VARCHAR(50) NULL ,
  `plataforma` SMALLINT NOT NULL ,
  `idSistemaOperativo` SMALLINT NULL ,
  `lenguaje` SMALLINT NOT NULL ,
  `versionLenguaje` VARCHAR(25) NOT NULL ,
  `framework` VARCHAR(50) NULL ,
  `versionFramework` VARCHAR(25) NULL ,
  `observacion` VARCHAR(500) NULL ,
  `idEstiloSistema` SMALLINT NOT NULL ,
  `idUsuarioCreador` INT NOT NULL ,
  `fechaCreacion` DATETIME NOT NULL ,
  `vigente` TINYINT(1)  NOT NULL DEFAULT true ,
  PRIMARY KEY (`idSistema`) ,
  INDEX `plataforma` (`plataforma` ASC) ,
  INDEX `so` (`idSistemaOperativo` ASC) ,
  INDEX `lenguaje` (`lenguaje` ASC) ,
  INDEX `estilo` (`idEstiloSistema` ASC) ,
  CONSTRAINT `plataforma`
    FOREIGN KEY (`plataforma` )
    REFERENCES `Sesion`.`Plataforma` (`idPlataforma` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `so`
    FOREIGN KEY (`idSistemaOperativo` )
    REFERENCES `Sesion`.`SistemaOperativo` (`idSistemaOperativo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `lenguaje`
    FOREIGN KEY (`lenguaje` )
    REFERENCES `Sesion`.`Lenguaje` (`idLenguaje` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `estilo`
    FOREIGN KEY (`idEstiloSistema` )
    REFERENCES `Sesion`.`Estilos` (`idEstilo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sesion`.`Menu`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Sesion`.`Menu` (
  `idMenu` INT NOT NULL ,
  `idSistema` INT NOT NULL ,
  `nombreMenu` VARCHAR(50) NOT NULL ,
  `descripcionMenu` VARCHAR(100) NULL ,
  `horientacion` VARCHAR(5) NOT NULL ,
  `idEstiloMenu` SMALLINT NOT NULL ,
  PRIMARY KEY (`idMenu`) ,
  INDEX `menu` (`idSistema` ASC) ,
  INDEX `estilo` (`idEstiloMenu` ASC) ,
  CONSTRAINT `menu`
    FOREIGN KEY (`idSistema` )
    REFERENCES `Sesion`.`Sistema` (`idSistema` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `estilo`
    FOREIGN KEY (`idEstiloMenu` )
    REFERENCES `Sesion`.`Estilos` (`idEstilo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sesion`.`MenuItem`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Sesion`.`MenuItem` (
  `idMenuItem` INT NOT NULL ,
  `idMenu` INT NOT NULL ,
  `padre` INT NOT NULL ,
  `descripcion` VARCHAR(100) NOT NULL ,
  `texto` VARCHAR(50) NOT NULL ,
  `link` VARCHAR(50) NOT NULL ,
  `imagen` VARCHAR(50) NULL ,
  `orden` SMALLINT NOT NULL ,
  `expandido` TINYINT(1)  NOT NULL DEFAULT false ,
  `target` VARCHAR(10) NOT NULL DEFAULT 'parent' ,
  `idEstiloMenuItem` SMALLINT NOT NULL ,
  `vigente` TINYINT(1)  NOT NULL DEFAULT true ,
  PRIMARY KEY (`idMenuItem`) ,
  INDEX `menu` (`idMenu` ASC) ,
  INDEX `estilo` (`idEstiloMenuItem` ASC) ,
  CONSTRAINT `menu`
    FOREIGN KEY (`idMenu` )
    REFERENCES `Sesion`.`Menu` (`idMenu` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `estilo`
    FOREIGN KEY (`idEstiloMenuItem` )
    REFERENCES `Sesion`.`Estilos` (`idEstilo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sesion`.`TipoPerfil`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Sesion`.`TipoPerfil` (
  `idTipoPerfil` SMALLINT NOT NULL ,
  `glosaTipoPerfil` VARCHAR(50) NOT NULL ,
  `vigente` TINYINT(1)  NOT NULL DEFAULT true ,
  PRIMARY KEY (`idTipoPerfil`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sesion`.`Perfil`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Sesion`.`Perfil` (
  `idPerfil` INT NOT NULL ,
  `nombrePerfil` VARCHAR(50) NOT NULL ,
  `descripcion` VARCHAR(100) NULL ,
  `idTipoPerfil` SMALLINT NOT NULL ,
  `paginaInicio` VARCHAR(50) NULL ,
  `idEstiloPerfil` SMALLINT NOT NULL ,
  `vigente` TINYINT(1)  NOT NULL DEFAULT true ,
  PRIMARY KEY (`idPerfil`) ,
  INDEX `tipoPerfil` (`idTipoPerfil` ASC) ,
  INDEX `estilo` (`idEstiloPerfil` ASC) ,
  CONSTRAINT `tipoPerfil`
    FOREIGN KEY (`idTipoPerfil` )
    REFERENCES `Sesion`.`TipoPerfil` (`idTipoPerfil` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `estilo`
    FOREIGN KEY (`idEstiloPerfil` )
    REFERENCES `Sesion`.`Estilos` (`idEstilo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sesion`.`TipoSesionUsuario`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Sesion`.`TipoSesionUsuario` (
  `idTipoSesionUsuario` SMALLINT NOT NULL ,
  `glosaTipoSesion` VARCHAR(50) NOT NULL ,
  `vigente` TINYINT(1)  NOT NULL DEFAULT true ,
  PRIMARY KEY (`idTipoSesionUsuario`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sesion`.`SesionUsuario`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Sesion`.`SesionUsuario` (
  `idSesionUsuario` INT NOT NULL ,
  `idUsuario` INT NOT NULL ,
  `idSistema` INT NOT NULL ,
  `idPerfil` INT NOT NULL ,
  `idTipoSesion` SMALLINT NOT NULL ,
  `descripcion` VARCHAR(100) NULL ,
  `idEstiloUsuario` VARCHAR(15) NULL ,
  `idUsuarioCreador` INT NOT NULL ,
  `vigente` TINYINT(1)  NOT NULL DEFAULT true ,
  PRIMARY KEY (`idSesionUsuario`) ,
  INDEX `sesionUsuario` (`idUsuario` ASC) ,
  INDEX `sesionSistema` (`idSistema` ASC) ,
  INDEX `perfil` (`idPerfil` ASC) ,
  INDEX `tipoSesion` (`idTipoSesion` ASC) ,
  INDEX `estilo` (`idEstiloUsuario` ASC) ,
  CONSTRAINT `sesionUsuario`
    FOREIGN KEY (`idUsuario` )
    REFERENCES `Sesion`.`Usuario` (`idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sesionSistema`
    FOREIGN KEY (`idSistema` )
    REFERENCES `Sesion`.`Sistema` (`idSistema` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `perfil`
    FOREIGN KEY (`idPerfil` )
    REFERENCES `Sesion`.`Perfil` (`idPerfil` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tipoSesion`
    FOREIGN KEY (`idTipoSesion` )
    REFERENCES `Sesion`.`TipoSesionUsuario` (`idTipoSesionUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `estilo`
    FOREIGN KEY (`idEstiloUsuario` )
    REFERENCES `Sesion`.`Estilos` (`idEstilo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sesion`.`MenuItemporPerfil`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Sesion`.`MenuItemporPerfil` (
  `idPerfil` INT NOT NULL ,
  `idMenu` INT NOT NULL ,
  `idMenuItem` INT NOT NULL ,
  INDEX `perfil` (`idPerfil` ASC) ,
  INDEX `menu` (`idMenu` ASC) ,
  INDEX `menuItem` (`idMenuItem` ASC) ,
  CONSTRAINT `perfil`
    FOREIGN KEY (`idPerfil` )
    REFERENCES `Sesion`.`Perfil` (`idPerfil` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `menu`
    FOREIGN KEY (`idMenu` )
    REFERENCES `Sesion`.`Menu` (`idMenu` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `menuItem`
    FOREIGN KEY (`idMenuItem` )
    REFERENCES `Sesion`.`MenuItem` (`idMenuItem` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sesion`.`MenuItemporUsuario`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Sesion`.`MenuItemporUsuario` (
  `idUsuario` INT NOT NULL ,
  `idMenu` INT NOT NULL ,
  `idMenuItem` INT NOT NULL ,
  INDEX `usuario` (`idUsuario` ASC) ,
  INDEX `menu` (`idMenu` ASC) ,
  INDEX `menuItem` (`idMenuItem` ASC) ,
  CONSTRAINT `usuario`
    FOREIGN KEY (`idUsuario` )
    REFERENCES `Sesion`.`Usuario` (`idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `menu`
    FOREIGN KEY (`idMenu` )
    REFERENCES `Sesion`.`Menu` (`idMenu` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `menuItem`
    FOREIGN KEY (`idMenuItem` )
    REFERENCES `Sesion`.`MenuItem` (`idMenuItem` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sesion`.`MenuItemporSesion`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Sesion`.`MenuItemporSesion` (
  `idSesion` INT NOT NULL ,
  `idMenu` INT NOT NULL ,
  `idMenuItem` INT NOT NULL ,
  INDEX `sesion` (`idSesion` ASC) ,
  INDEX `menu` (`idMenu` ASC) ,
  INDEX `MenuItem` (`idMenuItem` ASC) ,
  CONSTRAINT `sesion`
    FOREIGN KEY (`idSesion` )
    REFERENCES `Sesion`.`SesionUsuario` (`idSesionUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `menu`
    FOREIGN KEY (`idMenu` )
    REFERENCES `Sesion`.`Menu` (`idMenu` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `MenuItem`
    FOREIGN KEY (`idMenuItem` )
    REFERENCES `Sesion`.`MenuItem` (`idMenuItem` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sesion`.`SistemaVisita`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Sesion`.`SistemaVisita` (
  `idSistemaVisita` INT NOT NULL AUTO_INCREMENT ,
  `idSistema` INT NOT NULL ,
  `fecha` DATETIME NOT NULL ,
  `sistemaOperativo` VARCHAR(20) NOT NULL ,
  `explorador` VARCHAR(30) NOT NULL ,
  `version` VARCHAR(20) NULL ,
  `beta` TINYINT(1)  NOT NULL ,
  `javascript` TINYINT(1)  NOT NULL ,
  `javaApplets` TINYINT(1)  NOT NULL ,
  `cookies` TINYINT(1)  NOT NULL ,
  `activexControl` TINYINT(1)  NOT NULL ,
  `ajax` TINYINT(1)  NOT NULL ,
  `ip` VARCHAR(20) NOT NULL ,
  `macAddress` VARCHAR(20) NULL ,
  `pais` VARCHAR(10) NOT NULL ,
  PRIMARY KEY (`idSistemaVisita`) ,
  INDEX `sistema` (`idSistema` ASC) ,
  CONSTRAINT `sistema`
    FOREIGN KEY (`idSistema` )
    REFERENCES `Sesion`.`Sistema` (`idSistema` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
