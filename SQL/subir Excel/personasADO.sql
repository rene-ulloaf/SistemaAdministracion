CREATE TABLE `personasado` (
  `idPersonaado` int(11) NOT NULL auto_increment,
  `rut` varchar(300) default NULL,
  `dv` varchar(300) default NULL,
  `nombres` varchar(300) default NULL,
  `primerApellido` varchar(300) default NULL,
  `segundoApellido` varchar(300) default NULL,
  `nacionalidad` varchar(300) default NULL,
  `region` varchar(300) default NULL,
  `ciudad` varchar(300) default NULL,
  `comuna` varchar(300) default NULL,
  `direccion` varchar(300) default NULL,
  `numero` varchar(300) default NULL,
  `email` varchar(300) default NULL,
  `fonoCasa` varchar(20) default NULL,
  `fonoCel` varchar(20) default NULL,
  `fonoTrabajo` varchar(20) default NULL,
  `otroFono` varchar(20) default NULL,
  `sexo` varchar(300) default NULL,
  `sistemaIngreso` int(11) NOT NULL,
  `comentario` varchar(500) default NULL,
  `fecIngreso` datetime NOT NULL default 'sysdate',
  `pasadoOriginal` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`idPersonaado`),
  UNIQUE KEY `idPersonaado` (`idPersonaado`)
) ENGINE=MyISAM AUTO_INCREMENT=105882 DEFAULT CHARSET=utf8 COMMENT='Se guardan los datos de las personas antes de pasarlas a la original';