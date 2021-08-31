-- --------------------------------------------------------
-- Host:                         50.62.81.146
-- Versión del servidor:         5.5.51 - MySQL Community Server (GPL)
-- SO del servidor:              Win64
-- HeidiSQL Versión:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para mcgdb
CREATE DATABASE IF NOT EXISTS `mcgdb` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `mcgdb`;

-- Volcando estructura para tabla mcgdb.acuerdo_pago
CREATE TABLE IF NOT EXISTS `acuerdo_pago` (
  `Id_Acuerdo_Pago` int(11) NOT NULL AUTO_INCREMENT,
  `Aporte_Cliente` int(11) NOT NULL,
  `Valor_Credito` int(11) NOT NULL,
  `Enditdad_Credito` varchar(45) DEFAULT NULL,
  `Fk_Id_Contrato` int(11) NOT NULL,
  PRIMARY KEY (`Id_Acuerdo_Pago`),
  KEY `fk_Acuerdo_Pago_Contrato_Venta1_idx` (`Fk_Id_Contrato`),
  CONSTRAINT `fk_Acuerdo_Pago_Contrato_Venta1` FOREIGN KEY (`Fk_Id_Contrato`) REFERENCES `contrato_venta` (`Id_Contrato`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla mcgdb.acuerdo_pago: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `acuerdo_pago` DISABLE KEYS */;
/*!40000 ALTER TABLE `acuerdo_pago` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.adicional
CREATE TABLE IF NOT EXISTS `adicional` (
  `Id_Adicional` int(11) NOT NULL AUTO_INCREMENT,
  `Concepto` varchar(45) DEFAULT NULL,
  `Valor_Adicional` int(11) DEFAULT NULL,
  `Estado_Adicional` varchar(45) DEFAULT NULL,
  `Fecha_Adicional` date DEFAULT NULL,
  `Fk_Id_Inmueble` int(11) NOT NULL,
  PRIMARY KEY (`Id_Adicional`),
  KEY `fk_Adicional_Inmueble1_idx` (`Fk_Id_Inmueble`),
  CONSTRAINT `fk_Adicional_Inmueble1` FOREIGN KEY (`Fk_Id_Inmueble`) REFERENCES `inmueble` (`Id_Inmueble`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla mcgdb.adicional: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `adicional` DISABLE KEYS */;
/*!40000 ALTER TABLE `adicional` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.aportes
CREATE TABLE IF NOT EXISTS `aportes` (
  `Id_Aporte` int(11) NOT NULL AUTO_INCREMENT,
  `Num_Aporte` int(11) DEFAULT NULL,
  `Concepto_Aporte` varchar(250) DEFAULT NULL,
  `Fecha_Aporte` datetime NOT NULL,
  `Referencia_Aporte` varchar(45) DEFAULT NULL,
  `Destino_Aporte` varchar(45) NOT NULL,
  `Valor_Ingresos` int(11) NOT NULL DEFAULT '0',
  `Fk_Id_Inmueble` int(11) NOT NULL,
  PRIMARY KEY (`Id_Aporte`),
  KEY `fk_Ingresos_Inmueble1_idx` (`Fk_Id_Inmueble`),
  CONSTRAINT `fk_Ingresos_Inmueble1` FOREIGN KEY (`Fk_Id_Inmueble`) REFERENCES `inmueble` (`Id_Inmueble`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla mcgdb.aportes: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `aportes` DISABLE KEYS */;
/*!40000 ALTER TABLE `aportes` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.area
CREATE TABLE IF NOT EXISTS `area` (
  `Id_Area` int(11) NOT NULL AUTO_INCREMENT,
  `Nom_Area` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Id_Area`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla mcgdb.area: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `area` DISABLE KEYS */;
INSERT INTO `area` (`Id_Area`, `Nom_Area`) VALUES
	(1, 'Desarrollo');
/*!40000 ALTER TABLE `area` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.cartera
CREATE TABLE IF NOT EXISTS `cartera` (
  `Id_Cartera` int(11) NOT NULL AUTO_INCREMENT,
  `Estado_Cartera` varchar(12) DEFAULT NULL,
  `Valor_Recaudado` int(11) DEFAULT NULL,
  `Saldo` int(11) DEFAULT NULL,
  `Total_Cartera` int(11) DEFAULT NULL,
  `Fk_Id_Cliente` int(11) NOT NULL,
  PRIMARY KEY (`Id_Cartera`),
  KEY `fk_cartera_cliente1_idx` (`Fk_Id_Cliente`),
  CONSTRAINT `fk_cartera_cliente1` FOREIGN KEY (`Fk_Id_Cliente`) REFERENCES `cliente` (`Id_Cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla mcgdb.cartera: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `cartera` DISABLE KEYS */;
/*!40000 ALTER TABLE `cartera` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.categoria
CREATE TABLE IF NOT EXISTS `categoria` (
  `Id_Categoria` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre Categoria` varchar(45) DEFAULT NULL,
  `Descripcion_Categoria` varchar(45) DEFAULT NULL,
  `Fk_Id_Tipo_documento` int(11) NOT NULL,
  PRIMARY KEY (`Id_Categoria`),
  KEY `fk_Categoria_Tipo_documento1_idx` (`Fk_Id_Tipo_documento`),
  CONSTRAINT `fk_Categoria_Tipo_documento1` FOREIGN KEY (`Fk_Id_Tipo_documento`) REFERENCES `tipo_documento` (`Id_Tipo_documento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla mcgdb.categoria: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.cliente
CREATE TABLE IF NOT EXISTS `cliente` (
  `Id_Cliente` int(11) NOT NULL AUTO_INCREMENT,
  `Fecha_Creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Modificacion` datetime DEFAULT NULL,
  `Estado` enum('Y','N') NOT NULL DEFAULT 'Y',
  `id_persona` int(11) NOT NULL,
  PRIMARY KEY (`Id_Cliente`),
  KEY `FKCliente_Persona` (`id_persona`),
  CONSTRAINT `FKCliente_Persona` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id_persona`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla mcgdb.cliente: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` (`Id_Cliente`, `Fecha_Creacion`, `Fecha_Modificacion`, `Estado`, `id_persona`) VALUES
	(1, '2021-08-29 22:04:19', '2021-08-29 22:04:22', 'Y', 1),
	(2, '2021-08-29 22:04:32', '2021-08-29 22:04:33', 'Y', 2);
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.contrato_venta
CREATE TABLE IF NOT EXISTS `contrato_venta` (
  `Id_Contrato` int(11) NOT NULL AUTO_INCREMENT,
  `Numero_Contrato` varchar(45) DEFAULT NULL,
  `Forma_Pago` varchar(45) DEFAULT NULL,
  `Valor_Contrato` int(11) DEFAULT NULL,
  `Fecha_Venta` date DEFAULT NULL,
  `Observacion_Contrato` varchar(45) DEFAULT NULL,
  `Fk_Id_Inmueble` int(11) NOT NULL,
  PRIMARY KEY (`Id_Contrato`),
  UNIQUE KEY `Id_Venta_UNIQUE` (`Id_Contrato`),
  KEY `fk_Contrato_Inmueble1_idx` (`Fk_Id_Inmueble`),
  CONSTRAINT `fk_Contrato_Inmueble1` FOREIGN KEY (`Fk_Id_Inmueble`) REFERENCES `inmueble` (`Id_Inmueble`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla mcgdb.contrato_venta: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `contrato_venta` DISABLE KEYS */;
/*!40000 ALTER TABLE `contrato_venta` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.costo
CREATE TABLE IF NOT EXISTS `costo` (
  `Id_Costo` int(11) NOT NULL AUTO_INCREMENT,
  `Nom_Costo` varchar(45) DEFAULT NULL,
  `Valor_Costo` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id_Costo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla mcgdb.costo: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `costo` DISABLE KEYS */;
/*!40000 ALTER TABLE `costo` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.cuota
CREATE TABLE IF NOT EXISTS `cuota` (
  `Id_Cuota` int(11) NOT NULL AUTO_INCREMENT,
  `Num_Cuota` int(11) DEFAULT NULL,
  `Valor_Cuota` int(11) DEFAULT NULL,
  `Fecha_Pago_Cuota` date DEFAULT NULL,
  `Estado_Cuota` varchar(45) DEFAULT NULL,
  `Fk_Id_Acuerdo_Pago` int(11) NOT NULL,
  PRIMARY KEY (`Id_Cuota`),
  KEY `fk_Cuota_Acuerdo_Pago1_idx` (`Fk_Id_Acuerdo_Pago`),
  CONSTRAINT `fk_Cuota_Acuerdo_Pago1` FOREIGN KEY (`Fk_Id_Acuerdo_Pago`) REFERENCES `acuerdo_pago` (`Id_Acuerdo_Pago`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla mcgdb.cuota: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `cuota` DISABLE KEYS */;
/*!40000 ALTER TABLE `cuota` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.documento
CREATE TABLE IF NOT EXISTS `documento` (
  `Id_Documento` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre_Documento` varchar(45) NOT NULL,
  `Ruta_Ubicacion` varchar(45) NOT NULL,
  `Ubicacion_Fisico_Documento` varchar(45) NOT NULL,
  `Fk_Id_Tipo_documento` int(11) NOT NULL,
  `Fk_Id_Proyecto` int(11) NOT NULL,
  `Fk_Id_Area` int(11) NOT NULL,
  PRIMARY KEY (`Id_Documento`),
  KEY `fk_Documentos_Tipo_documento1_idx` (`Fk_Id_Tipo_documento`),
  KEY `fk_Documento_Proyecto1_idx` (`Fk_Id_Proyecto`),
  KEY `fk_Documento_Area1_idx` (`Fk_Id_Area`),
  CONSTRAINT `fk_Documento_Area1` FOREIGN KEY (`Fk_Id_Area`) REFERENCES `area` (`Id_Area`),
  CONSTRAINT `fk_Documento_Proyecto1` FOREIGN KEY (`Fk_Id_Proyecto`) REFERENCES `proyecto` (`Id_Proyecto`),
  CONSTRAINT `fk_Documentos_Tipo_documento1` FOREIGN KEY (`Fk_Id_Tipo_documento`) REFERENCES `tipo_documento` (`Id_Tipo_documento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla mcgdb.documento: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `documento` DISABLE KEYS */;
/*!40000 ALTER TABLE `documento` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.egresos
CREATE TABLE IF NOT EXISTS `egresos` (
  `Id_Egresos` int(11) NOT NULL AUTO_INCREMENT,
  `Numero_Egresos` int(11) DEFAULT NULL,
  `Fecha_Egresos` datetime DEFAULT NULL,
  `Referencia_Ingresos` varchar(45) DEFAULT NULL,
  `Valor_Egresos` int(11) DEFAULT NULL,
  `Pedido_Id_Pedido` int(11) NOT NULL,
  PRIMARY KEY (`Id_Egresos`),
  KEY `fk_Egresos_Pedido1_idx` (`Pedido_Id_Pedido`),
  CONSTRAINT `fk_Egresos_Pedido1` FOREIGN KEY (`Pedido_Id_Pedido`) REFERENCES `pedido` (`Id_Pedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla mcgdb.egresos: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `egresos` DISABLE KEYS */;
/*!40000 ALTER TABLE `egresos` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.etapa
CREATE TABLE IF NOT EXISTS `etapa` (
  `Id_Etapa` int(11) NOT NULL AUTO_INCREMENT,
  `Num_Etapa` varchar(45) DEFAULT NULL,
  `Fk_Id_Proyecto` int(11) NOT NULL,
  PRIMARY KEY (`Id_Etapa`),
  KEY `fk_Etapa_Proyecto1_idx` (`Fk_Id_Proyecto`),
  CONSTRAINT `fk_Etapa_Proyecto1` FOREIGN KEY (`Fk_Id_Proyecto`) REFERENCES `proyecto` (`Id_Proyecto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla mcgdb.etapa: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `etapa` DISABLE KEYS */;
/*!40000 ALTER TABLE `etapa` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.inmueble
CREATE TABLE IF NOT EXISTS `inmueble` (
  `Id_Inmueble` int(11) NOT NULL AUTO_INCREMENT,
  `Manzana` int(11) NOT NULL,
  `Num_Casa` int(11) DEFAULT NULL,
  `Valor_Inicial` int(11) DEFAULT NULL,
  `Ficha_Catastral` varchar(45) DEFAULT NULL,
  `Escritura` int(11) DEFAULT NULL,
  `Matricula_inmobiliaria` int(11) DEFAULT NULL,
  `Estado` varchar(45) DEFAULT NULL,
  `Fk_Id_Proyecto` int(11) NOT NULL,
  PRIMARY KEY (`Id_Inmueble`),
  KEY `fk_Inmueble_Proyecto1_idx` (`Fk_Id_Proyecto`),
  CONSTRAINT `fk_Inmueble_Proyecto1` FOREIGN KEY (`Fk_Id_Proyecto`) REFERENCES `proyecto` (`Id_Proyecto`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla mcgdb.inmueble: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `inmueble` DISABLE KEYS */;
INSERT INTO `inmueble` (`Id_Inmueble`, `Manzana`, `Num_Casa`, `Valor_Inicial`, `Ficha_Catastral`, `Escritura`, `Matricula_inmobiliaria`, `Estado`, `Fk_Id_Proyecto`) VALUES
	(1, 12, 1, 1200, '56789', 5678, 6789, 'En venta', 1),
	(3, 24, 24, 134567, '13456', 1532, 111, 'En venta', 2);
/*!40000 ALTER TABLE `inmueble` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.inmueble_costo
CREATE TABLE IF NOT EXISTS `inmueble_costo` (
  `Pfk_Id_Inmueble` int(11) NOT NULL,
  `Pfk_Id_Costo` int(11) NOT NULL,
  `Fecha_Costo` varchar(45) NOT NULL,
  PRIMARY KEY (`Pfk_Id_Inmueble`,`Pfk_Id_Costo`),
  KEY `fk_Inmueble_has_Costo_Costo1_idx` (`Pfk_Id_Costo`),
  KEY `fk_Inmueble_has_Costo_Inmueble1_idx` (`Pfk_Id_Inmueble`),
  CONSTRAINT `fk_Inmueble_has_Costo_Costo1` FOREIGN KEY (`Pfk_Id_Costo`) REFERENCES `costo` (`Id_Costo`),
  CONSTRAINT `fk_Inmueble_has_Costo_Inmueble1` FOREIGN KEY (`Pfk_Id_Inmueble`) REFERENCES `inmueble` (`Id_Inmueble`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla mcgdb.inmueble_costo: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `inmueble_costo` DISABLE KEYS */;
/*!40000 ALTER TABLE `inmueble_costo` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.inmueble_documento
CREATE TABLE IF NOT EXISTS `inmueble_documento` (
  `Pfk_Id_Inmueble` int(11) NOT NULL,
  `Pfk_Id_Documento` int(11) NOT NULL,
  PRIMARY KEY (`Pfk_Id_Inmueble`,`Pfk_Id_Documento`),
  KEY `fk_Inmueble_has_Documento_Documento1_idx` (`Pfk_Id_Documento`),
  KEY `fk_Inmueble_has_Documento_Inmueble1_idx` (`Pfk_Id_Inmueble`),
  CONSTRAINT `fk_Inmueble_has_Documento_Documento1` FOREIGN KEY (`Pfk_Id_Documento`) REFERENCES `documento` (`Id_Documento`),
  CONSTRAINT `fk_Inmueble_has_Documento_Inmueble1` FOREIGN KEY (`Pfk_Id_Inmueble`) REFERENCES `inmueble` (`Id_Inmueble`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla mcgdb.inmueble_documento: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `inmueble_documento` DISABLE KEYS */;
/*!40000 ALTER TABLE `inmueble_documento` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.pedido
CREATE TABLE IF NOT EXISTS `pedido` (
  `Id_Pedido` int(11) NOT NULL AUTO_INCREMENT,
  `Fecha_Pedido` datetime NOT NULL,
  `Valor_Pedido` int(11) NOT NULL,
  `Estado` varchar(45) NOT NULL,
  `Referencia` varchar(45) NOT NULL,
  `Fecha_Pago` datetime NOT NULL,
  `Fk_Id_Proveedor` int(11) NOT NULL,
  `Fk_Id_Usuario` int(11) NOT NULL,
  PRIMARY KEY (`Id_Pedido`),
  KEY `fk_Pedido_Proveedor1_idx` (`Fk_Id_Proveedor`),
  KEY `fk_Pedido_Usuario1_idx` (`Fk_Id_Usuario`),
  CONSTRAINT `fk_Pedido_Proveedor1` FOREIGN KEY (`Fk_Id_Proveedor`) REFERENCES `proveedor` (`Id_Proveedor`),
  CONSTRAINT `fk_Pedido_Usuario1` FOREIGN KEY (`Fk_Id_Usuario`) REFERENCES `usuario` (`Id_Usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla mcgdb.pedido: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.persona
CREATE TABLE IF NOT EXISTS `persona` (
  `id_persona` int(11) NOT NULL,
  `nombres` varchar(150) DEFAULT NULL,
  `apellidos` varchar(150) DEFAULT NULL,
  `numero_identificacion` varchar(50) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `direccion` varchar(250) DEFAULT NULL,
  `correo` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id_persona`),
  UNIQUE KEY `numero_identificacion` (`numero_identificacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla mcgdb.persona: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
INSERT INTO `persona` (`id_persona`, `nombres`, `apellidos`, `numero_identificacion`, `telefono`, `direccion`, `correo`) VALUES
	(1, 'Maicol', 'Aguilar Perez', '1117553160', '3134360567', 'calle5 # 9-03', 'ma.aguilar@udla.edu.co'),
	(2, 'Diana ', 'Perez', '40092915', '3112589854', 'none', 'example@udla.edu.co');
/*!40000 ALTER TABLE `persona` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.proveedor
CREATE TABLE IF NOT EXISTS `proveedor` (
  `Id_Proveedor` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre_Proveedor` varchar(45) DEFAULT NULL,
  `Nit_Proveedor` varchar(45) DEFAULT NULL,
  `Telefono_Proveedor` varchar(45) DEFAULT NULL,
  `Correo_Proveedor` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Id_Proveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla mcgdb.proveedor: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.proyecto
CREATE TABLE IF NOT EXISTS `proyecto` (
  `Id_Proyecto` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre_Proyecto` varchar(45) DEFAULT NULL,
  `Ubicacion_Proyecto` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`Id_Proyecto`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla mcgdb.proyecto: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `proyecto` DISABLE KEYS */;
INSERT INTO `proyecto` (`Id_Proyecto`, `Nombre_Proyecto`, `Ubicacion_Proyecto`) VALUES
	(1, 'Punta del este', 'Via  a morelia detras de las casa fiscales ejercito'),
	(2, 'Altos de San Jorge', 'el cundui');
/*!40000 ALTER TABLE `proyecto` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.rol
CREATE TABLE IF NOT EXISTS `rol` (
  `Id_Rol` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre_Rol` varchar(45) DEFAULT NULL,
  `Descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Id_Rol`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla mcgdb.rol: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` (`Id_Rol`, `Nombre_Rol`, `Descripcion`) VALUES
	(1, 'Desarrollo', 'Encargado de codificar y desarrollar la app'),
	(2, 'Cartera', 'Encargado del manejo de cartera de MCG');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.tipo_documento
CREATE TABLE IF NOT EXISTS `tipo_documento` (
  `Id_Tipo_documento` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre_Tipo_documento` varchar(45) DEFAULT NULL,
  `Descripcion_Tipo_documento` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Id_Tipo_documento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla mcgdb.tipo_documento: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `tipo_documento` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_documento` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.usuario
CREATE TABLE IF NOT EXISTS `usuario` (
  `Id_Usuario` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre_Usuario` varchar(45) DEFAULT NULL,
  `Apellido_Usuario` varchar(45) DEFAULT NULL,
  `Usuario` varchar(45) DEFAULT NULL,
  `Contraseña` varchar(45) DEFAULT NULL,
  `Celular` bigint(20) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `Fk_Id_Rol` int(11) NOT NULL,
  `Fk_Id_Area` int(11) NOT NULL,
  PRIMARY KEY (`Id_Usuario`),
  UNIQUE KEY `Usuario_UNIQUE` (`Usuario`),
  KEY `fk_Usuario_Rol1_idx` (`Fk_Id_Rol`),
  KEY `fk_Usuario_Area1_idx` (`Fk_Id_Area`),
  CONSTRAINT `fk_Usuario_Area1` FOREIGN KEY (`Fk_Id_Area`) REFERENCES `area` (`Id_Area`),
  CONSTRAINT `fk_Usuario_Rol1` FOREIGN KEY (`Fk_Id_Rol`) REFERENCES `rol` (`Id_Rol`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla mcgdb.usuario: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` (`Id_Usuario`, `Nombre_Usuario`, `Apellido_Usuario`, `Usuario`, `Contraseña`, `Celular`, `email`, `Fk_Id_Rol`, `Fk_Id_Area`) VALUES
	(2, 'Admin', 'admin', 'admin', '123', NULL, NULL, 1, 1),
	(9, 'Cesar', 'Valencia', 'rasec', '4', 3133250701, '4', 1, 1);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;

-- Volcando estructura para procedimiento mcgdb.ConsultarClientes
DELIMITER //
CREATE PROCEDURE `ConsultarClientes`()
    COMMENT 'Procedimiento para consultar clientes'
BEGIN
	SELECT cliente.Id_Cliente AS id,persona.numero_identificacion AS identificacion,
	cliente.Fecha_Creacion AS fecha_creacion,
	persona.nombres AS nombres,
	persona.apellidos AS apellidos,persona.telefono AS telefono,
	persona.direccion AS direccion,persona.correo AS email  FROM cliente INNER JOIN persona on
	cliente.id_persona=persona.id_persona;
	


	#SELECT cliente.Id_Cliente AS id,cliente.Cedula AS identificacion, cliente.Nombre AS nombres,
	#cliente.Apellido AS apellidos,cliente.Telefono AS telefono,
	#cliente.Direccion AS direccion,cliente.email AS email FROM cliente ORDER BY cliente.Id_Cliente asc;
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
