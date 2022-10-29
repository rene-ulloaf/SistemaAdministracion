SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `Sesion` ;
SHOW WARNINGS;
USE `Sesion`;

-- -----------------------------------------------------
-- Table `Sesion`.`sexo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sesion`.`sexo` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `Sesion`.`sexo` (
  `idSexo` SMALLINT NOT NULL AUTO_INCREMENT ,
  `glosaSexo` VARCHAR(50) NOT NULL ,
  `vigente` BOOLEAN NOT NULL DEFAULT true ,
  PRIMARY KEY (`idSexo`) )
ENGINE = InnoDB
COMMENT = 'se guardan los tipos de sexo';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Sesion`.`Continentes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sesion`.`Continentes` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `Sesion`.`Continentes` (
  `idContinente` SMALLINT NOT NULL AUTO_INCREMENT ,
  `glosaContinente` VARCHAR(50) NOT NULL ,
  `vigente` BOOLEAN NOT NULL DEFAULT true ,
  PRIMARY KEY (`idContinente`) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Sesion`.`Idioma`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sesion`.`Idioma` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `Sesion`.`Idioma` (
  `idIdioma` INT NOT NULL ,
  `glosaIdioma` VARCHAR(50) NOT NULL ,
  `vigente` BOOLEAN NOT NULL DEFAULT true ,
  PRIMARY KEY (`idIdioma`) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Sesion`.`Paises`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sesion`.`Paises` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `Sesion`.`Paises` (
  `idpais` SMALLINT NOT NULL ,
  `idContinente` SMALLINT NOT NULL ,
  `nombre` VARCHAR(50) NOT NULL ,
  `idioma` SMALLINT NOT NULL ,
  `gentilicioMasc` VARCHAR(50) NULL ,
  `gentilicioFem` VARCHAR(50) NULL ,
  `bandera` VARCHAR(100) NULL ,
  `vigente` BOOLEAN NOT NULL DEFAULT true ,
  PRIMARY KEY (`idpais`) ,
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

SHOW WARNINGS;
CREATE INDEX `continente` ON `Sesion`.`Paises` (`idContinente` ASC) ;

SHOW WARNINGS;
CREATE INDEX `idioma` ON `Sesion`.`Paises` (`idioma` ASC) ;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Sesion`.`Personas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sesion`.`Personas` ;

SHOW WARNINGS;
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
  `vigente` BOOLEAN NOT NULL DEFAULT true ,
  PRIMARY KEY (`idPersona`) ,
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

SHOW WARNINGS;
CREATE INDEX `sexo` ON `Sesion`.`Personas` (`sexo` ASC) ;

SHOW WARNINGS;
CREATE INDEX `nacionalidad` ON `Sesion`.`Personas` (`nacionalidad` ASC) ;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Sesion`.`Usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sesion`.`Usuario` ;

SHOW WARNINGS;
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
  `vigente` BOOLEAN NOT NULL DEFAULT true ,
  PRIMARY KEY (`idUsuario`) ,
  CONSTRAINT `idpersona`
    FOREIGN KEY (`idPersona` )
    REFERENCES `Sesion`.`Personas` (`idPersona` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'se guardan los datos los datos del inicio de sesión';

SHOW WARNINGS;
CREATE INDEX `idpersona` ON `Sesion`.`Usuario` (`idPersona` ASC) ;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Sesion`.`EMail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sesion`.`EMail` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `Sesion`.`EMail` (
  `idEmail` INT NOT NULL AUTO_INCREMENT ,
  `email` VARCHAR(50) NOT NULL ,
  `vigente` BOOLEAN NOT NULL DEFAULT true ,
  PRIMARY KEY (`idEmail`) )
ENGINE = InnoDB
COMMENT = 'Se guardan los e-mail de las personas';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Sesion`.`Persona_Email`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sesion`.`Persona_Email` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `Sesion`.`Persona_Email` (
  `idPersonaEmail` INT NOT NULL AUTO_INCREMENT ,
  `idPersona` INT NOT NULL ,
  `idUsuario` INT NOT NULL ,
  `idEmail` INT NOT NULL ,
  PRIMARY KEY (`idPersonaEmail`) ,
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

SHOW WARNINGS;
CREATE INDEX `idpersona` ON `Sesion`.`Persona_Email` (`idPersona` ASC) ;

SHOW WARNINGS;
CREATE INDEX `idUsuario` ON `Sesion`.`Persona_Email` (`idUsuario` ASC) ;

SHOW WARNINGS;
CREATE INDEX `idemail` ON `Sesion`.`Persona_Email` (`idEmail` ASC) ;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Sesion`.`TipoTelefono`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sesion`.`TipoTelefono` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `Sesion`.`TipoTelefono` (
  `idTipoTelefono` SMALLINT NOT NULL AUTO_INCREMENT ,
  `glosaTelefono` VARCHAR(50) NOT NULL ,
  `vigente` BOOLEAN NOT NULL ,
  PRIMARY KEY (`idTipoTelefono`) )
ENGINE = InnoDB
COMMENT = 'Establece los tipos de telefonos que existen';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Sesion`.`Telefonos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sesion`.`Telefonos` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `Sesion`.`Telefonos` (
  `idTelefonos` INT NOT NULL AUTO_INCREMENT ,
  `idPersona` INT NOT NULL ,
  `idTipoTelefono` SMALLINT NOT NULL ,
  `telefono` VARCHAR(15) NOT NULL ,
  `vigente` BOOLEAN NOT NULL DEFAULT true ,
  `omision` BOOLEAN NOT NULL DEFAULT false ,
  PRIMARY KEY (`idTelefonos`) ,
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

SHOW WARNINGS;
CREATE INDEX `persona` ON `Sesion`.`Telefonos` (`idPersona` ASC) ;

SHOW WARNINGS;
CREATE INDEX `tipo_telefono` ON `Sesion`.`Telefonos` (`idTipoTelefono` ASC) ;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Sesion`.`Regiones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sesion`.`Regiones` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `Sesion`.`Regiones` (
  `idRegion` SMALLINT NOT NULL AUTO_INCREMENT ,
  `idPais` SMALLINT NOT NULL ,
  `glosaRegion` VARCHAR(50) NOT NULL ,
  `vigente` BOOLEAN NOT NULL DEFAULT true ,
  PRIMARY KEY (`idRegion`) ,
  CONSTRAINT `pais`
    FOREIGN KEY (`idPais` )
    REFERENCES `Sesion`.`Paises` (`idpais` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `pais` ON `Sesion`.`Regiones` (`idPais` ASC) ;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Sesion`.`Ciudades`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sesion`.`Ciudades` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `Sesion`.`Ciudades` (
  `idciudad` SMALLINT NOT NULL AUTO_INCREMENT ,
  `idRegion` SMALLINT NOT NULL ,
  `glosaCiudad` VARCHAR(50) NOT NULL ,
  `vigente` BOOLEAN NOT NULL DEFAULT true ,
  PRIMARY KEY (`idciudad`) ,
  CONSTRAINT `region`
    FOREIGN KEY (`idRegion` )
    REFERENCES `Sesion`.`Regiones` (`idRegion` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `region` ON `Sesion`.`Ciudades` (`idRegion` ASC) ;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Sesion`.`Comunas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sesion`.`Comunas` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `Sesion`.`Comunas` (
  `idcomuna` SMALLINT NOT NULL ,
  `idCiudad` SMALLINT NOT NULL ,
  `glosaComuna` VARCHAR(50) NOT NULL ,
  `vigente` BOOLEAN NOT NULL ,
  PRIMARY KEY (`idcomuna`) ,
  CONSTRAINT `ciudad`
    FOREIGN KEY (`idCiudad` )
    REFERENCES `Sesion`.`Ciudades` (`idciudad` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `ciudad` ON `Sesion`.`Comunas` (`idCiudad` ASC) ;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Sesion`.`Plataforma`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sesion`.`Plataforma` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `Sesion`.`Plataforma` (
  `idPlataforma` SMALLINT NOT NULL ,
  `glosaPlataforma` VARCHAR(50) NOT NULL ,
  `vigente` BOOLEAN NOT NULL DEFAULT true ,
  PRIMARY KEY (`idPlataforma`) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Sesion`.`SistemaOperativo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sesion`.`SistemaOperativo` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `Sesion`.`SistemaOperativo` (
  `idSistemaOperativo` SMALLINT NOT NULL ,
  `glosaSistemaOperativo` VARCHAR(50) NOT NULL ,
  `vigente` BOOLEAN NOT NULL DEFAULT true ,
  PRIMARY KEY (`idSistemaOperativo`) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Sesion`.`Lenguaje`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sesion`.`Lenguaje` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `Sesion`.`Lenguaje` (
  `idLenguaje` SMALLINT NOT NULL ,
  `glosaLenguaje` VARCHAR(50) NOT NULL ,
  `vigente` BOOLEAN NOT NULL DEFAULT true ,
  PRIMARY KEY (`idLenguaje`) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Sesion`.`Estilos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sesion`.`Estilos` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `Sesion`.`Estilos` (
  `idEstilo` SMALLINT NOT NULL ,
  `tipo` VARCHAR(10) NOT NULL ,
  `nombreEstilo` VARCHAR(50) NOT NULL ,
  `descripcion` VARCHAR(100) NULL ,
  `vigente` BOOLEAN NOT NULL DEFAULT true ,
  PRIMARY KEY (`idEstilo`) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Sesion`.`Sistema`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sesion`.`Sistema` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `Sesion`.`Sistema` (
  `idSistema` INT NOT NULL ,
  `nombre_sistema` VARCHAR(50) NOT NULL ,
  `sitioURL` VARCHAR(100) NULL ,
  `imagen` VARCHAR(50) NULL ,
  `plataforma` SMALLINT NOT NULL ,
  `idSistemaOperativo` SMALLINT NOT NULL ,
  `lenguaje` SMALLINT NOT NULL ,
  `observacion` VARCHAR(500) NULL ,
  `idEstiloSistema` SMALLINT NOT NULL ,
  `idUsuarioCreador` INT NOT NULL ,
  `fechaCreacion` DATETIME NOT NULL ,
  `vigente` BOOLEAN NOT NULL DEFAULT true ,
  PRIMARY KEY (`idSistema`) ,
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

SHOW WARNINGS;
CREATE INDEX `plataforma` ON `Sesion`.`Sistema` (`plataforma` ASC) ;

SHOW WARNINGS;
CREATE INDEX `so` ON `Sesion`.`Sistema` (`idSistemaOperativo` ASC) ;

SHOW WARNINGS;
CREATE INDEX `lenguaje` ON `Sesion`.`Sistema` (`lenguaje` ASC) ;

SHOW WARNINGS;
CREATE INDEX `estilo` ON `Sesion`.`Sistema` (`idEstiloSistema` ASC) ;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Sesion`.`Menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sesion`.`Menu` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `Sesion`.`Menu` (
  `idMenu` INT NOT NULL ,
  `idSistema` INT NOT NULL ,
  `nombreMenu` VARCHAR(50) NOT NULL ,
  `descripcionMenu` VARCHAR(100) NULL ,
  `horientacion` VARCHAR(5) NOT NULL ,
  `idEstiloMenu` SMALLINT NOT NULL ,
  PRIMARY KEY (`idMenu`) ,
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

SHOW WARNINGS;
CREATE INDEX `menu` ON `Sesion`.`Menu` (`idSistema` ASC) ;

SHOW WARNINGS;
CREATE INDEX `estilo` ON `Sesion`.`Menu` (`idEstiloMenu` ASC) ;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Sesion`.`MenuItem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sesion`.`MenuItem` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `Sesion`.`MenuItem` (
  `idMenuItem` INT NOT NULL ,
  `idMenu` INT NOT NULL ,
  `padre` INT NOT NULL ,
  `descripcion` VARCHAR(100) NOT NULL ,
  `texto` VARCHAR(50) NOT NULL ,
  `link` VARCHAR(50) NOT NULL ,
  `imagen` VARCHAR(50) NULL ,
  `orden` SMALLINT NOT NULL ,
  `expandido` BOOLEAN NOT NULL DEFAULT false ,
  `target` VARCHAR(10) NOT NULL DEFAULT 'parent' ,
  `idEstiloMenuItem` SMALLINT NOT NULL ,
  `vigente` BOOLEAN NOT NULL DEFAULT true ,
  PRIMARY KEY (`idMenuItem`) ,
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

SHOW WARNINGS;
CREATE INDEX `menu` ON `Sesion`.`MenuItem` (`idMenu` ASC) ;

SHOW WARNINGS;
CREATE INDEX `estilo` ON `Sesion`.`MenuItem` (`idEstiloMenuItem` ASC) ;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Sesion`.`TipoPerfil`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sesion`.`TipoPerfil` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `Sesion`.`TipoPerfil` (
  `idTipoPerfil` SMALLINT NOT NULL ,
  `glosaTipoPerfil` VARCHAR(50) NOT NULL ,
  `vigente` BOOLEAN NOT NULL DEFAULT true ,
  PRIMARY KEY (`idTipoPerfil`) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Sesion`.`Perfil`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sesion`.`Perfil` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `Sesion`.`Perfil` (
  `idPerfil` INT NOT NULL ,
  `nombrePerfil` VARCHAR(50) NOT NULL ,
  `descripcion` VARCHAR(100) NULL ,
  `idTipoPerfil` SMALLINT NOT NULL ,
  `paginaInicio` VARCHAR(50) NULL ,
  `idEstiloPerfil` SMALLINT NOT NULL ,
  `vigente` BOOLEAN NOT NULL DEFAULT true ,
  PRIMARY KEY (`idPerfil`) ,
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

SHOW WARNINGS;
CREATE INDEX `tipoPerfil` ON `Sesion`.`Perfil` (`idTipoPerfil` ASC) ;

SHOW WARNINGS;
CREATE INDEX `estilo` ON `Sesion`.`Perfil` (`idEstiloPerfil` ASC) ;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Sesion`.`TipoSesionUsuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sesion`.`TipoSesionUsuario` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `Sesion`.`TipoSesionUsuario` (
  `idTipoSesionUsuario` SMALLINT NOT NULL ,
  `glosaTipoSesion` VARCHAR(50) NOT NULL ,
  `vigente` BOOLEAN NOT NULL DEFAULT true ,
  PRIMARY KEY (`idTipoSesionUsuario`) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Sesion`.`SesionUsuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sesion`.`SesionUsuario` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `Sesion`.`SesionUsuario` (
  `idSesionUsuario` INT NOT NULL ,
  `idUsuario` INT NOT NULL ,
  `idSistema` INT NOT NULL ,
  `idPerfil` INT NOT NULL ,
  `idTipoSesion` SMALLINT NOT NULL ,
  `descripcion` VARCHAR(100) NULL ,
  `idEstiloUsuario` VARCHAR(15) NULL ,
  `idUsuarioCreador` INT NOT NULL ,
  `vigente` BOOLEAN NOT NULL DEFAULT true ,
  PRIMARY KEY (`idSesionUsuario`) ,
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

SHOW WARNINGS;
CREATE INDEX `sesionUsuario` ON `Sesion`.`SesionUsuario` (`idUsuario` ASC) ;

SHOW WARNINGS;
CREATE INDEX `sesionSistema` ON `Sesion`.`SesionUsuario` (`idSistema` ASC) ;

SHOW WARNINGS;
CREATE INDEX `perfil` ON `Sesion`.`SesionUsuario` (`idPerfil` ASC) ;

SHOW WARNINGS;
CREATE INDEX `tipoSesion` ON `Sesion`.`SesionUsuario` (`idTipoSesion` ASC) ;

SHOW WARNINGS;
CREATE INDEX `estilo` ON `Sesion`.`SesionUsuario` (`idEstiloUsuario` ASC) ;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Sesion`.`MenuItemporPerfil`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sesion`.`MenuItemporPerfil` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `Sesion`.`MenuItemporPerfil` (
  `idPerfil` INT NOT NULL ,
  `idMenu` INT NOT NULL ,
  `idMenuItem` INT NOT NULL ,
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

SHOW WARNINGS;
CREATE INDEX `perfil` ON `Sesion`.`MenuItemporPerfil` (`idPerfil` ASC) ;

SHOW WARNINGS;
CREATE INDEX `menu` ON `Sesion`.`MenuItemporPerfil` (`idMenu` ASC) ;

SHOW WARNINGS;
CREATE INDEX `menuItem` ON `Sesion`.`MenuItemporPerfil` (`idMenuItem` ASC) ;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Sesion`.`MenuItemporUsuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sesion`.`MenuItemporUsuario` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `Sesion`.`MenuItemporUsuario` (
  `idUsuario` INT NOT NULL ,
  `idMenu` INT NOT NULL ,
  `idMenuItem` INT NOT NULL ,
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

SHOW WARNINGS;
CREATE INDEX `usuario` ON `Sesion`.`MenuItemporUsuario` (`idUsuario` ASC) ;

SHOW WARNINGS;
CREATE INDEX `menu` ON `Sesion`.`MenuItemporUsuario` (`idMenu` ASC) ;

SHOW WARNINGS;
CREATE INDEX `menuItem` ON `Sesion`.`MenuItemporUsuario` (`idMenuItem` ASC) ;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Sesion`.`MenuItemporSesion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sesion`.`MenuItemporSesion` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `Sesion`.`MenuItemporSesion` (
  `idSesion` INT NOT NULL ,
  `idMenu` INT NOT NULL ,
  `idMenuItem` INT NOT NULL ,
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

SHOW WARNINGS;
CREATE INDEX `sesion` ON `Sesion`.`MenuItemporSesion` (`idSesion` ASC) ;

SHOW WARNINGS;
CREATE INDEX `menu` ON `Sesion`.`MenuItemporSesion` (`idMenu` ASC) ;

SHOW WARNINGS;
CREATE INDEX `MenuItem` ON `Sesion`.`MenuItemporSesion` (`idMenuItem` ASC) ;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `Sesion`.`SistemaVisita`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sesion`.`SistemaVisita` ;

SHOW WARNINGS;
CREATE  TABLE IF NOT EXISTS `Sesion`.`SistemaVisita` (
  `idSistemaVisita` INT NOT NULL AUTO_INCREMENT ,
  `idSistema` INT NOT NULL ,
  `fecha` DATETIME NOT NULL ,
  `sistemaOperativo` VARCHAR(20) NOT NULL ,
  `explorador` VARCHAR(30) NOT NULL ,
  `version` VARCHAR(20) NULL ,
  `beta` BOOLEAN NOT NULL ,
  `javascript` BOOLEAN NOT NULL ,
  `javaApplets` BOOLEAN NOT NULL ,
  `cookies` BOOLEAN NOT NULL ,
  `activexControl` BOOLEAN NOT NULL ,
  `ajax` BOOLEAN NOT NULL ,
  `ip` VARCHAR(20) NOT NULL ,
  `macAddress` VARCHAR(20) NULL ,
  `pais` VARCHAR(10) NOT NULL ,
  PRIMARY KEY (`idSistemaVisita`) ,
  CONSTRAINT `sistema`
    FOREIGN KEY (`idSistema` )
    REFERENCES `Sesion`.`Sistema` (`idSistema` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `sistema` ON `Sesion`.`SistemaVisita` (`idSistema` ASC) ;

SHOW WARNINGS;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
