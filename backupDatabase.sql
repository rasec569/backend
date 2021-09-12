-- --------------------------------------------------------
-- Host:                         72.167.41.112
-- Versión del servidor:         8.0.26 - MySQL Community Server - GPL
-- SO del servidor:              Linux
-- HeidiSQL Versión:             11.3.0.6337
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para mcgdb
CREATE DATABASE IF NOT EXISTS `mcgdb` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mcgdb`;

-- Volcando estructura para tabla mcgdb.acreedor
CREATE TABLE IF NOT EXISTS `acreedor` (
  `Id_Acreedor` int NOT NULL AUTO_INCREMENT,
  `Fecha_Creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Modificacion` datetime DEFAULT NULL,
  `Estado` enum('Y','N') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'Y',
  `id_persona` int NOT NULL,
  PRIMARY KEY (`Id_Acreedor`) USING BTREE,
  KEY `FK_acreedor_persona` (`id_persona`),
  CONSTRAINT `FK_acreedor_persona` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.acreedor: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `acreedor` DISABLE KEYS */;
/*!40000 ALTER TABLE `acreedor` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.acuerdo_pago
CREATE TABLE IF NOT EXISTS `acuerdo_pago` (
  `Id_Acuerdo_Pago` int NOT NULL AUTO_INCREMENT,
  `Aporte_Cliente` int NOT NULL,
  `Valor_Credito` int NOT NULL,
  `Enditdad_Credito` varchar(45) DEFAULT NULL,
  `Fk_Id_Contrato` int NOT NULL,
  PRIMARY KEY (`Id_Acuerdo_Pago`),
  KEY `fk_Acuerdo_Pago_Contrato_Venta1_idx` (`Fk_Id_Contrato`),
  CONSTRAINT `fk_Acuerdo_Pago_Contrato_Venta1` FOREIGN KEY (`Fk_Id_Contrato`) REFERENCES `contrato_venta` (`Id_Contrato`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.acuerdo_pago: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `acuerdo_pago` DISABLE KEYS */;
/*!40000 ALTER TABLE `acuerdo_pago` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.adicional
CREATE TABLE IF NOT EXISTS `adicional` (
  `Id_Adicional` int NOT NULL AUTO_INCREMENT,
  `Concepto` varchar(45) DEFAULT NULL,
  `Valor_Adicional` int DEFAULT NULL,
  `Estado_Adicional` enum('Y','N') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Fecha_Adicional` date DEFAULT NULL,
  `Fk_Id_Inmueble` int NOT NULL,
  PRIMARY KEY (`Id_Adicional`),
  KEY `fk_Adicional_Inmueble1_idx` (`Fk_Id_Inmueble`),
  CONSTRAINT `fk_Adicional_Inmueble1` FOREIGN KEY (`Fk_Id_Inmueble`) REFERENCES `inmueble` (`Id_Inmueble`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.adicional: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `adicional` DISABLE KEYS */;
/*!40000 ALTER TABLE `adicional` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.aportes
CREATE TABLE IF NOT EXISTS `aportes` (
  `Id_Aporte` int NOT NULL AUTO_INCREMENT,
  `Num_Aporte` int DEFAULT NULL,
  `Concepto_Aporte` varchar(250) DEFAULT NULL,
  `Fecha_Aporte` datetime NOT NULL,
  `Referencia_Aporte` varchar(45) DEFAULT NULL,
  `Destino_Aporte` varchar(45) NOT NULL,
  `Valor_Ingresos` int NOT NULL DEFAULT '0',
  `Fk_Id_Inmueble` int NOT NULL,
  PRIMARY KEY (`Id_Aporte`),
  KEY `fk_Ingresos_Inmueble1_idx` (`Fk_Id_Inmueble`),
  CONSTRAINT `fk_Ingresos_Inmueble1` FOREIGN KEY (`Fk_Id_Inmueble`) REFERENCES `inmueble` (`Id_Inmueble`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.aportes: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `aportes` DISABLE KEYS */;
/*!40000 ALTER TABLE `aportes` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.area
CREATE TABLE IF NOT EXISTS `area` (
  `Id_Area` int NOT NULL AUTO_INCREMENT,
  `Nom_Area` varchar(45) DEFAULT NULL,
  `Desc_Area` varchar(50) DEFAULT NULL,
  `Estado` enum('Y','N') DEFAULT NULL,
  PRIMARY KEY (`Id_Area`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.area: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `area` DISABLE KEYS */;
INSERT INTO `area` (`Id_Area`, `Nom_Area`, `Desc_Area`, `Estado`) VALUES
	(1, 'Desarrollo', 'programadores de la app web', 'Y'),
	(2, 'Gerencia', 'Toman las deciciones de la constructora', 'Y'),
	(3, 'ensayo', 'ensayo', 'N');
/*!40000 ALTER TABLE `area` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.cartera
CREATE TABLE IF NOT EXISTS `cartera` (
  `Id_Cartera` int NOT NULL AUTO_INCREMENT,
  `Estado_Cartera` varchar(12) DEFAULT NULL,
  `Valor_Recaudado` int DEFAULT NULL,
  `Saldo` int DEFAULT NULL,
  `Total_Cartera` int DEFAULT NULL,
  `Fk_Id_Cliente` int NOT NULL,
  PRIMARY KEY (`Id_Cartera`),
  KEY `fk_cartera_cliente1_idx` (`Fk_Id_Cliente`),
  CONSTRAINT `fk_cartera_cliente1` FOREIGN KEY (`Fk_Id_Cliente`) REFERENCES `cliente` (`Id_Cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.cartera: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `cartera` DISABLE KEYS */;
INSERT INTO `cartera` (`Id_Cartera`, `Estado_Cartera`, `Valor_Recaudado`, `Saldo`, `Total_Cartera`, `Fk_Id_Cliente`) VALUES
	(3, 'Y', 0, 0, 0, 3),
	(4, 'Y', 0, 0, 0, 4),
	(5, 'Y', 0, 0, 0, 5),
	(6, 'Y', 0, 0, 0, 6),
	(7, 'Y', 0, 0, 0, 7),
	(8, 'Y', 0, 0, 0, 8),
	(9, 'Y', 0, 0, 0, 9);
/*!40000 ALTER TABLE `cartera` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.categoria
CREATE TABLE IF NOT EXISTS `categoria` (
  `Id_Categoria` int NOT NULL AUTO_INCREMENT,
  `Nombre Categoria` varchar(45) DEFAULT NULL,
  `Descripcion_Categoria` varchar(45) DEFAULT NULL,
  `Fk_Id_Tipo_documento` int NOT NULL,
  PRIMARY KEY (`Id_Categoria`),
  KEY `fk_Categoria_Tipo_documento1_idx` (`Fk_Id_Tipo_documento`),
  CONSTRAINT `fk_Categoria_Tipo_documento1` FOREIGN KEY (`Fk_Id_Tipo_documento`) REFERENCES `tipo_documento` (`Id_Tipo_documento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.categoria: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.cliente
CREATE TABLE IF NOT EXISTS `cliente` (
  `Id_Cliente` int NOT NULL AUTO_INCREMENT,
  `Fecha_Creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Modificacion` datetime DEFAULT NULL,
  `Estado` enum('Y','N') NOT NULL DEFAULT 'Y',
  `id_persona` int NOT NULL,
  PRIMARY KEY (`Id_Cliente`),
  KEY `FKCliente_Persona` (`id_persona`),
  CONSTRAINT `FKCliente_Persona` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id_persona`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.cliente: ~8 rows (aproximadamente)
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` (`Id_Cliente`, `Fecha_Creacion`, `Fecha_Modificacion`, `Estado`, `id_persona`) VALUES
	(1, '2021-08-29 22:04:19', '2021-08-29 22:04:22', 'Y', 1),
	(2, '2021-08-29 22:04:32', '2021-08-29 22:04:33', 'Y', 2),
	(3, '2021-09-02 19:27:08', '2021-09-02 19:27:08', 'Y', 3),
	(4, '2021-09-06 03:50:51', '2021-09-06 03:50:51', 'Y', 4),
	(5, '2021-09-06 03:53:57', '2021-09-06 03:53:57', 'Y', 5),
	(6, '2021-09-07 01:01:06', '2021-09-07 19:25:08', 'Y', 6),
	(7, '2021-09-07 04:19:28', '2021-09-06 23:19:46', 'N', 7),
	(8, '2021-09-07 20:39:37', '2021-09-07 15:39:37', 'N', 8),
	(9, '2021-09-07 22:00:27', '2021-09-07 17:00:27', 'Y', 9);
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.cliente_contrato
CREATE TABLE IF NOT EXISTS `cliente_contrato` (
  `Pfk_Id_Cliente` int NOT NULL,
  `Pfk_Id_Contrato` int NOT NULL,
  `Fecha_Cambio` date DEFAULT NULL,
  `Estado` enum('Y','N') DEFAULT NULL,
  PRIMARY KEY (`Pfk_Id_Cliente`,`Pfk_Id_Contrato`),
  KEY `fk_cliente_has_contrato_venta_contrato_venta1_idx` (`Pfk_Id_Contrato`),
  KEY `fk_cliente_has_contrato_venta_cliente1_idx` (`Pfk_Id_Cliente`),
  CONSTRAINT `fk_cliente_has_contrato_venta_cliente1` FOREIGN KEY (`Pfk_Id_Cliente`) REFERENCES `cliente` (`Id_Cliente`),
  CONSTRAINT `fk_cliente_has_contrato_venta_contrato_venta1` FOREIGN KEY (`Pfk_Id_Contrato`) REFERENCES `contrato_venta` (`Id_Contrato`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.cliente_contrato: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `cliente_contrato` DISABLE KEYS */;
INSERT INTO `cliente_contrato` (`Pfk_Id_Cliente`, `Pfk_Id_Contrato`, `Fecha_Cambio`, `Estado`) VALUES
	(1, 1, '2021-09-11', 'Y');
/*!40000 ALTER TABLE `cliente_contrato` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.contrato_venta
CREATE TABLE IF NOT EXISTS `contrato_venta` (
  `Id_Contrato` int NOT NULL AUTO_INCREMENT,
  `Numero_Contrato` varchar(45) DEFAULT NULL,
  `Forma_Pago` varchar(45) DEFAULT NULL,
  `Valor_Contrato` int DEFAULT NULL,
  `Fecha_Venta` date DEFAULT NULL,
  `Observacion_Contrato` varchar(45) DEFAULT NULL,
  `Fk_Id_Inmueble` int NOT NULL,
  PRIMARY KEY (`Id_Contrato`),
  UNIQUE KEY `Id_Venta_UNIQUE` (`Id_Contrato`),
  KEY `fk_Contrato_Inmueble1_idx` (`Fk_Id_Inmueble`),
  CONSTRAINT `fk_Contrato_Inmueble1` FOREIGN KEY (`Fk_Id_Inmueble`) REFERENCES `inmueble` (`Id_Inmueble`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.contrato_venta: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `contrato_venta` DISABLE KEYS */;
INSERT INTO `contrato_venta` (`Id_Contrato`, `Numero_Contrato`, `Forma_Pago`, `Valor_Contrato`, `Fecha_Venta`, `Observacion_Contrato`, `Fk_Id_Inmueble`) VALUES
	(1, '1111111', 'none', 1123434, '2021-09-11', 'none observacion', 1);
/*!40000 ALTER TABLE `contrato_venta` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.costo
CREATE TABLE IF NOT EXISTS `costo` (
  `Id_Costo` int NOT NULL AUTO_INCREMENT,
  `Nom_Costo` varchar(45) DEFAULT NULL,
  `Valor_Costo` int DEFAULT NULL,
  PRIMARY KEY (`Id_Costo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.costo: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `costo` DISABLE KEYS */;
/*!40000 ALTER TABLE `costo` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.cuota
CREATE TABLE IF NOT EXISTS `cuota` (
  `Id_Cuota` int NOT NULL AUTO_INCREMENT,
  `Num_Cuota` int DEFAULT NULL,
  `Valor_Cuota` int DEFAULT NULL,
  `Fecha_Pago_Cuota` date DEFAULT NULL,
  `Estado_Cuota` varchar(45) DEFAULT NULL,
  `Fk_Id_Acuerdo_Pago` int NOT NULL,
  PRIMARY KEY (`Id_Cuota`),
  KEY `fk_Cuota_Acuerdo_Pago1_idx` (`Fk_Id_Acuerdo_Pago`),
  CONSTRAINT `fk_Cuota_Acuerdo_Pago1` FOREIGN KEY (`Fk_Id_Acuerdo_Pago`) REFERENCES `acuerdo_pago` (`Id_Acuerdo_Pago`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.cuota: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `cuota` DISABLE KEYS */;
/*!40000 ALTER TABLE `cuota` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.documento
CREATE TABLE IF NOT EXISTS `documento` (
  `Id_Documento` int NOT NULL AUTO_INCREMENT,
  `Nombre_Documento` varchar(45) NOT NULL,
  `Ruta_Ubicacion` varchar(45) NOT NULL,
  `Ubicacion_Fisico_Documento` varchar(45) NOT NULL,
  `Fk_Id_Tipo_documento` int NOT NULL,
  `Fk_Id_Proyecto` int NOT NULL,
  `Fk_Id_Area` int NOT NULL,
  PRIMARY KEY (`Id_Documento`),
  KEY `fk_Documentos_Tipo_documento1_idx` (`Fk_Id_Tipo_documento`),
  KEY `fk_Documento_Proyecto1_idx` (`Fk_Id_Proyecto`),
  KEY `fk_Documento_Area1_idx` (`Fk_Id_Area`),
  CONSTRAINT `fk_Documento_Area1` FOREIGN KEY (`Fk_Id_Area`) REFERENCES `area` (`Id_Area`),
  CONSTRAINT `fk_Documento_Proyecto1` FOREIGN KEY (`Fk_Id_Proyecto`) REFERENCES `proyecto` (`Id_Proyecto`),
  CONSTRAINT `fk_Documentos_Tipo_documento1` FOREIGN KEY (`Fk_Id_Tipo_documento`) REFERENCES `tipo_documento` (`Id_Tipo_documento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.documento: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `documento` DISABLE KEYS */;
/*!40000 ALTER TABLE `documento` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.egresos
CREATE TABLE IF NOT EXISTS `egresos` (
  `Id_Egresos` int NOT NULL AUTO_INCREMENT,
  `Numero_Egresos` int DEFAULT NULL,
  `Fecha_Egresos` datetime DEFAULT NULL,
  `Referencia_Ingresos` varchar(45) DEFAULT NULL,
  `Valor_Egresos` int DEFAULT NULL,
  `Pedido_Id_Pedido` int NOT NULL,
  PRIMARY KEY (`Id_Egresos`),
  KEY `fk_Egresos_Pedido1_idx` (`Pedido_Id_Pedido`),
  CONSTRAINT `fk_Egresos_Pedido1` FOREIGN KEY (`Pedido_Id_Pedido`) REFERENCES `obligacion` (`Id_Obligacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.egresos: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `egresos` DISABLE KEYS */;
/*!40000 ALTER TABLE `egresos` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.errorlog
CREATE TABLE IF NOT EXISTS `errorlog` (
  `Id_ErrorLog` int NOT NULL AUTO_INCREMENT,
  `SqlState` varchar(50) NOT NULL,
  `FechaError` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Procedimiento` varchar(50) NOT NULL,
  PRIMARY KEY (`Id_ErrorLog`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COMMENT='tabla de registro de errores en los procedimientos ';

-- Volcando datos para la tabla mcgdb.errorlog: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `errorlog` DISABLE KEYS */;
INSERT INTO `errorlog` (`Id_ErrorLog`, `SqlState`, `FechaError`, `Procedimiento`) VALUES
	(2, 'error', '2021-09-11 16:44:35', 'ConsultarEtapa');
/*!40000 ALTER TABLE `errorlog` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.etapa
CREATE TABLE IF NOT EXISTS `etapa` (
  `Id_Etapa` int NOT NULL AUTO_INCREMENT,
  `Num_Etapa` varchar(45) DEFAULT NULL,
  `Estado_Etapa` enum('Y','N','Proyectada','En Ejecución','Finalizada') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'Y',
  `Num_Manzanas` int DEFAULT NULL,
  `Fecha_Modicacion` date DEFAULT NULL,
  `Fk_Id_Proyecto` int DEFAULT NULL,
  PRIMARY KEY (`Id_Etapa`),
  KEY `FK_etapa_proyecto` (`Fk_Id_Proyecto`),
  CONSTRAINT `FK_etapa_proyecto` FOREIGN KEY (`Fk_Id_Proyecto`) REFERENCES `proyecto` (`Id_Proyecto`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.etapa: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `etapa` DISABLE KEYS */;
INSERT INTO `etapa` (`Id_Etapa`, `Num_Etapa`, `Estado_Etapa`, `Num_Manzanas`, `Fecha_Modicacion`, `Fk_Id_Proyecto`) VALUES
	(1, '1', 'Y', 4, NULL, 1),
	(2, '2', 'Y', 3, NULL, 1),
	(3, 'Unica', 'Proyectada', 3, NULL, 4);
/*!40000 ALTER TABLE `etapa` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.inmueble
CREATE TABLE IF NOT EXISTS `inmueble` (
  `Id_Inmueble` int NOT NULL AUTO_INCREMENT,
  `Manzana` int NOT NULL,
  `Num_Casa` int DEFAULT NULL,
  `Valor_Inicial` int DEFAULT NULL,
  `Valor_Final` int DEFAULT NULL,
  `Ficha_Catastral` varchar(45) DEFAULT NULL,
  `Escritura` int DEFAULT NULL,
  `Matricula_inmobiliaria` int DEFAULT NULL,
  `Estado` enum('Lote','En Venta','Vendido','Pagado','N') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Fk_Id_Proyecto` int NOT NULL,
  `Fk_Id_Etapa` int DEFAULT NULL,
  PRIMARY KEY (`Id_Inmueble`),
  KEY `fk_Inmueble_Proyecto1_idx` (`Fk_Id_Proyecto`),
  KEY `FK_inmueble_etapa` (`Fk_Id_Etapa`),
  CONSTRAINT `FK_inmueble_etapa` FOREIGN KEY (`Fk_Id_Etapa`) REFERENCES `etapa` (`Id_Etapa`),
  CONSTRAINT `fk_Inmueble_Proyecto` FOREIGN KEY (`Fk_Id_Proyecto`) REFERENCES `proyecto` (`Id_Proyecto`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.inmueble: ~7 rows (aproximadamente)
/*!40000 ALTER TABLE `inmueble` DISABLE KEYS */;
INSERT INTO `inmueble` (`Id_Inmueble`, `Manzana`, `Num_Casa`, `Valor_Inicial`, `Valor_Final`, `Ficha_Catastral`, `Escritura`, `Matricula_inmobiliaria`, `Estado`, `Fk_Id_Proyecto`, `Fk_Id_Etapa`) VALUES
	(1, 12, 1, 1200, NULL, '56789', 5678, 6789, 'En Venta', 1, 1),
	(3, 24, 24, 134567, NULL, '13456', 1532, 111, 'En Venta', 2, 1),
	(4, 2, 4, 4678, 4678, '4678', 467, 467, 'Lote', 1, 1),
	(5, 2, 2, 4, 13455, '1234', 1445, 1455, 'N', 1, 1),
	(6, 2, 6, 6765, 444, '4567', 2456, 4567, 'Lote', 1, 1),
	(7, 8765, 4567, 4678, 4678, '7654', 567, 8765, 'Lote', 1, 1),
	(8, 3, 11, 12345, 13456, '21345', 2345, 23456, 'En Venta', 1, 1);
/*!40000 ALTER TABLE `inmueble` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.inmueble_costo
CREATE TABLE IF NOT EXISTS `inmueble_costo` (
  `Pfk_Id_Inmueble` int NOT NULL,
  `Pfk_Id_Costo` int NOT NULL,
  `Fecha_Costo` date NOT NULL,
  `Estado_Costo` enum('Y','N') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`Pfk_Id_Inmueble`,`Pfk_Id_Costo`),
  KEY `fk_Inmueble_has_Costo_Costo1_idx` (`Pfk_Id_Costo`),
  KEY `fk_Inmueble_has_Costo_Inmueble1_idx` (`Pfk_Id_Inmueble`),
  CONSTRAINT `fk_Inmueble_has_Costo_Costo1` FOREIGN KEY (`Pfk_Id_Costo`) REFERENCES `costo` (`Id_Costo`),
  CONSTRAINT `fk_Inmueble_has_Costo_Inmueble1` FOREIGN KEY (`Pfk_Id_Inmueble`) REFERENCES `inmueble` (`Id_Inmueble`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.inmueble_costo: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `inmueble_costo` DISABLE KEYS */;
/*!40000 ALTER TABLE `inmueble_costo` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.inmueble_documento
CREATE TABLE IF NOT EXISTS `inmueble_documento` (
  `Pfk_Id_Inmueble` int NOT NULL,
  `Pfk_Id_Documento` int NOT NULL,
  PRIMARY KEY (`Pfk_Id_Inmueble`,`Pfk_Id_Documento`),
  KEY `fk_Inmueble_has_Documento_Documento1_idx` (`Pfk_Id_Documento`),
  KEY `fk_Inmueble_has_Documento_Inmueble1_idx` (`Pfk_Id_Inmueble`),
  CONSTRAINT `fk_Inmueble_has_Documento_Documento1` FOREIGN KEY (`Pfk_Id_Documento`) REFERENCES `documento` (`Id_Documento`),
  CONSTRAINT `fk_Inmueble_has_Documento_Inmueble1` FOREIGN KEY (`Pfk_Id_Inmueble`) REFERENCES `inmueble` (`Id_Inmueble`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.inmueble_documento: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `inmueble_documento` DISABLE KEYS */;
/*!40000 ALTER TABLE `inmueble_documento` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.obligacion
CREATE TABLE IF NOT EXISTS `obligacion` (
  `Id_Obligacion` int NOT NULL AUTO_INCREMENT,
  `Fecha_Obligacion` datetime NOT NULL,
  `Valor_Obligacion` int NOT NULL,
  `Estado_Obligacion` enum('Por pagar','Pagada','Vencida') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'Por pagar',
  `Concepto_Obligacion` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Fecha_Pago` datetime NOT NULL,
  `Fk_Id_Acreedor` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id_Obligacion`) USING BTREE,
  KEY `FK_obligacion_acreedor` (`Fk_Id_Acreedor`),
  CONSTRAINT `FK_obligacion_acreedor` FOREIGN KEY (`Fk_Id_Acreedor`) REFERENCES `acreedor` (`Id_Acreedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.obligacion: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `obligacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `obligacion` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.persona
CREATE TABLE IF NOT EXISTS `persona` (
  `id_persona` int NOT NULL,
  `nombres` varchar(150) DEFAULT NULL,
  `apellidos` varchar(150) DEFAULT NULL,
  `numero_identificacion` varchar(50) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `direccion` varchar(250) DEFAULT NULL,
  `correo` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id_persona`),
  UNIQUE KEY `numero_identificacion` (`numero_identificacion`),
  UNIQUE KEY `correo` (`correo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.persona: ~11 rows (aproximadamente)
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
INSERT INTO `persona` (`id_persona`, `nombres`, `apellidos`, `numero_identificacion`, `telefono`, `direccion`, `correo`) VALUES
	(1, 'Maicol', 'Aguilar Perez', '1117553160', '3134360567', 'calle5 # 9-03', 'ma.aguilar@udla.edu.co'),
	(2, 'Cesar Augusto', 'Valencia Velasques', '1075238593', '3133250701', 'none', 'example@udla.edu.co'),
	(3, 'Jair', 'Morales', '10068695478', '31111111', 'calle 5 # 9-03', 'none@gamil.com'),
	(4, 'Jamaica', 'Ole', '1000678958', '25488844', 'calle 5 #4432', 'nonee@gmail.com'),
	(5, 'mAICOL', 'sTEVEN', '1117553161', '11111113', 'NONE', 'happy@gmail.com'),
	(6, 'Anitos', 'Morales Orting', '1117553167', '31111', 'none', 'none@gmail.es'),
	(7, 'Prueba|', 'Final', '122555', '5885558', 'ddsdsds', 'noesmicorreo@gmail.com'),
	(8, 'ccc', 'ccc', '2345', '1234', 'sdff', 'ccc@ccc.com'),
	(9, 'sdff', 'asdasdad', '1111', '45677', 'dfaghjkl', 'asas@asdff.com'),
	(10, 'ensayo', 'ensayo', '3456789', '234567580', '', 'aaa@aaa.aaa'),
	(11, 'dfsfdf', 'asfasf', '345678', '345678', '', 'asasa@assfads.caa');
/*!40000 ALTER TABLE `persona` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.proyecto
CREATE TABLE IF NOT EXISTS `proyecto` (
  `Id_Proyecto` int NOT NULL AUTO_INCREMENT,
  `Nombre_Proyecto` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Ubicacion_Proyecto` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Estado_Proyecto` enum('N','En Venta','Vendido') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'En Venta',
  `Fecha_Modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`Id_Proyecto`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.proyecto: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `proyecto` DISABLE KEYS */;
INSERT INTO `proyecto` (`Id_Proyecto`, `Nombre_Proyecto`, `Ubicacion_Proyecto`, `Estado_Proyecto`, `Fecha_Modificacion`) VALUES
	(1, 'Punta del este', 'Via  a morelia detras de las casa fiscales ejercito', 'En Venta', '2021-09-11 00:29:41'),
	(2, 'Altos de San Jorge', 'Barrio el Cunduy22', 'Vendido', '2021-09-11 00:30:26'),
	(3, 'wertyu', 'ertyui', 'N', NULL),
	(4, 'ensayo', 'ensayo', 'En Venta', NULL);
/*!40000 ALTER TABLE `proyecto` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.rol
CREATE TABLE IF NOT EXISTS `rol` (
  `Id_Rol` int NOT NULL AUTO_INCREMENT,
  `Nombre_Rol` varchar(45) DEFAULT NULL,
  `Descripcion` varchar(45) DEFAULT NULL,
  `Estado` enum('Y','N') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`Id_Rol`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.rol: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` (`Id_Rol`, `Nombre_Rol`, `Descripcion`, `Estado`) VALUES
	(1, 'Desarrollo', 'Encargado de codificar y desarrollar la app', 'Y'),
	(2, 'Cartera', 'Encargado del manejo de cartera de MCG', 'Y'),
	(3, 'Gerencia', 'ensayo', 'N'),
	(4, 'bnm', '444', 'N');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.tipo_documento
CREATE TABLE IF NOT EXISTS `tipo_documento` (
  `Id_Tipo_documento` int NOT NULL AUTO_INCREMENT,
  `Nombre_Tipo_documento` varchar(45) DEFAULT NULL,
  `Descripcion_Tipo_documento` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Id_Tipo_documento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.tipo_documento: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `tipo_documento` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_documento` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.usuario
CREATE TABLE IF NOT EXISTS `usuario` (
  `Id_Usuario` int NOT NULL AUTO_INCREMENT,
  `Usuario` varchar(45) DEFAULT NULL,
  `Contraseña` varchar(45) DEFAULT NULL,
  `Fecha_Creacion_User` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Modificacion_User` datetime DEFAULT NULL,
  `Estado_User` enum('Y','N') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'Y',
  `Fk_Id_Persona` int NOT NULL,
  `Fk_Id_Rol` int NOT NULL,
  `Fk_Id_Area` int NOT NULL,
  PRIMARY KEY (`Id_Usuario`),
  UNIQUE KEY `Usuario_UNIQUE` (`Usuario`),
  KEY `fk_Usuario_Rol1_idx` (`Fk_Id_Rol`),
  KEY `fk_Usuario_Area1_idx` (`Fk_Id_Area`),
  KEY `fk_Usuario_Persona` (`Fk_Id_Persona`) USING BTREE,
  CONSTRAINT `fk_Usuario_Area` FOREIGN KEY (`Fk_Id_Area`) REFERENCES `area` (`Id_Area`),
  CONSTRAINT `fk_Usuario_Persona` FOREIGN KEY (`Fk_Id_Persona`) REFERENCES `persona` (`id_persona`),
  CONSTRAINT `fk_Usuario_Rol` FOREIGN KEY (`Fk_Id_Rol`) REFERENCES `rol` (`Id_Rol`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.usuario: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` (`Id_Usuario`, `Usuario`, `Contraseña`, `Fecha_Creacion_User`, `Fecha_Modificacion_User`, `Estado_User`, `Fk_Id_Persona`, `Fk_Id_Rol`, `Fk_Id_Area`) VALUES
	(2, 'admin', '123', '2021-09-03 00:56:05', NULL, 'Y', 1, 1, 1),
	(9, 'rasec', '4', '2021-09-03 00:56:05', '2021-09-09 22:45:11', 'Y', 2, 1, 1),
	(10, 'ensayo', '1', '2021-09-10 03:58:59', '2021-09-09 22:58:59', 'N', 10, 1, 1),
	(11, 'admin2', '12322', '2021-09-10 04:01:05', '2021-09-09 23:01:05', 'N', 11, 2, 1);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;

-- Volcando estructura para procedimiento mcgdb.ConsultarAdicional
DELIMITER //
CREATE PROCEDURE `ConsultarAdicional`(
	IN `inmuebleId` INT
)
    COMMENT 'Procediento para listar los adicionales del inmueble'
BEGIN
	DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		SELECT adicional.Id_Adicional AS id, adicional.Concepto, adicional.Valor_Adicional AS valor, adicional.Estado_Adicional AS estado, adicional.Fecha_Adicional AS fecha FROM adicional WHERE adicional.Fk_Id_Inmueble=inmuebleId;
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.ConsultarArea
DELIMITER //
CREATE PROCEDURE `ConsultarArea`(
	IN `ID` INT
)
    COMMENT 'Procedimiento para consultar la información de una area por Id'
BEGIN
	DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		SELECT area.Id_Area AS id, area.Nom_Area AS nombre,area.Desc_Area AS descripcion, area.Estado AS estado  FROM area WHERE area.Id_Area=ID AND area.Estado='Y';
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.ConsultarAreas
DELIMITER //
CREATE PROCEDURE `ConsultarAreas`()
    COMMENT 'Procediento para listar las area de la constructora'
BEGIN
DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		SELECT area.Id_Area AS id, area.Nom_Area AS Area,area.Desc_Area AS Descripcion  FROM area WHERE area.Estado='Y';
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.ConsultarCartera
DELIMITER //
CREATE PROCEDURE `ConsultarCartera`()
    COMMENT 'Procedimiento para consultar la cartera'
BEGIN
DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		SELECT cartera.Id_Cartera,cliente.Id_Cliente, persona.numero_identificacion AS cedula, persona.nombres, persona.apellidos, cartera.Estado_Cartera, cartera.Valor_Recaudado, cartera.Saldo, 
		cartera.Total_Cartera  FROM cartera INNER JOIN cliente ON cliente.Id_Cliente=cartera.Fk_Id_Cliente INNER JOIN persona ON persona.id_persona= cliente.id_persona
		WHERE cliente.Estado='Y';
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.ConsultarCliente
DELIMITER //
CREATE PROCEDURE `ConsultarCliente`(
	IN `ID` INT
)
    COMMENT 'Procedimiento para consultar la información de un cliente por Id'
BEGIN
	DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		SELECT cliente.Id_Cliente AS id,persona.numero_identificacion AS identification,
		cliente.Fecha_Creacion AS fecha_creacion,
		persona.nombres AS nombres,
		persona.apellidos AS apellidos,persona.telefono AS telefono,
		persona.direccion AS direccion,persona.correo AS correo FROM cliente INNER JOIN persona on
		cliente.id_persona=persona.id_persona
		WHERE cliente.Id_Cliente=ID and cliente.Estado='Y';
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.ConsultarClientes
DELIMITER //
CREATE PROCEDURE `ConsultarClientes`()
    COMMENT 'Procedimiento para consultar clientes'
BEGIN
	DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		SELECT cliente.Id_Cliente AS id,persona.numero_identificacion AS identification,
		cliente.Fecha_Creacion AS fecha_creacion,
		persona.nombres AS nombres,
		persona.apellidos AS apellidos,persona.telefono AS telefono,
		persona.direccion AS direccion,persona.correo AS correo FROM cliente INNER JOIN persona on
		cliente.id_persona=persona.id_persona
		WHERE cliente.Estado='Y';
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.ConsultarContratosClientes
DELIMITER //
CREATE PROCEDURE `ConsultarContratosClientes`(
	IN `ID_CLIENTE` INT
)
    COMMENT 'Procedimiento para listar los contratos de un cliente'
BEGIN
	DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		SELECT * FROM cliente 
		INNER JOIN cliente_contrato ON cliente_contrato.Pfk_Id_Cliente=cliente.Id_Cliente
		INNER JOIN contrato_venta ON cliente_contrato.Pfk_Id_Contrato=contrato_venta.Id_Contrato
		WHERE cliente.Id_Cliente=ID_CLIENTE AND  cliente_contrato.Estado='Y';
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.ConsultarCosto
DELIMITER //
CREATE PROCEDURE `ConsultarCosto`(
	IN `inmuebleId` INT
)
    COMMENT 'Procediento para listar los costos del inmueble'
BEGIN
	DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		SELECT costo.Nom_Costo AS nombre, costo.Valor_Costo, inmueble_costo.Fecha_Costo, inmueble_costo.Estado_Costo FROM inmueble_costo INNER JOIN costo ON costo.Id_Costo= inmueble_costo.Pfk_Id_Costo WHERE inmueble_costo.Pfk_Id_Inmueble=inmuebleId;
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.ConsultarEtapa
DELIMITER //
CREATE PROCEDURE `ConsultarEtapa`(
	IN `ID` VARCHAR(50)
)
    COMMENT 'Procediento para busar etapa por su id'
BEGIN
DECLARE exit handler for sqlexception
  		BEGIN
  			INSERT INTO errorlog(errorlog.`SqlState`,errorlog.FechaError,errorlog.Procedimiento) VALUES('error',NOW(),'ConsultarEtapa');
  			COMMIT;
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;  		
	END;
	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;
	START TRANSACTION;
		SELECT etapa.Id_Etapa AS id, etapa.Num_Etapa AS numero,COUNT(inmueble.Id_Inmueble) AS inmuebles, etapa.Num_Manzanas,
		SUM(inmueble.Valor_Final) AS valor ,etapa.Estado_Etapa AS estado 
		FROM etapa INNER JOIN inmueble ON etapa.Id_Etapa= inmueble.Fk_Id_Etapa 
		WHERE etapa.Id_Etapa=ID GROUP BY etapa.Id_Etapa;
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.ConsultarEtapasProyecto
DELIMITER //
CREATE PROCEDURE `ConsultarEtapasProyecto`(
	IN `proyectoid` INT
)
    COMMENT 'Procediento para listar las etapas de un proyecto'
BEGIN
DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		SELECT etapa.Id_Etapa AS id, etapa.Num_Etapa AS numero,(SELECT COUNT(inmueble.Id_Inmueble) FROM inmueble WHERE inmueble.Fk_Id_Proyecto=etapa.Fk_Id_Proyecto AND inmueble.Fk_Id_Etapa=etapa.Id_Etapa AND inmueble.Estado!='N')  AS inmuebles, etapa.Num_Manzanas AS manzanas,
		(SELECT SUM(inmueble.Valor_Final)FROM inmueble WHERE inmueble.Fk_Id_Proyecto=etapa.Fk_Id_Proyecto AND inmueble.Fk_Id_Etapa=etapa.Id_Etapa AND inmueble.Estado!='N')  AS valor ,etapa.Estado_Etapa AS estado 
		FROM etapa LEFT JOIN inmueble ON etapa.Id_Etapa= inmueble.Fk_Id_Etapa
		WHERE etapa.Fk_Id_Proyecto=proyectoid GROUP BY etapa.Id_Etapa;
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.ConsultarInmueble
DELIMITER //
CREATE PROCEDURE `ConsultarInmueble`(
	IN `ID` INT
)
    COMMENT 'Procedimiento para consultar un inmueble por id'
BEGIN
	DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		SELECT inmueble.Id_Inmueble AS id ,inmueble.Manzana AS manzana, inmueble.Num_Casa AS casa, inmueble.Valor_Inicial, inmueble.Valor_Final, 
		inmueble.Fk_Id_Proyecto AS idproyecto , inmueble.Ficha_Catastral AS catastral, inmueble.Escritura AS escritura, inmueble.Matricula_inmobiliaria AS matricula, 
		inmueble.Estado AS estado, inmueble.Fk_Id_Etapa FROM inmueble 
		WHERE inmueble.Id_Inmueble=ID AND inmueble.Estado!='N';
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.ConsultarInmuebles
DELIMITER //
CREATE PROCEDURE `ConsultarInmuebles`()
    COMMENT 'Procedimiento para consultar los inmuebles'
BEGIN
	DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		SELECT inmueble.Id_Inmueble AS id, proyecto.Nombre_Proyecto AS proyecto, inmueble.Id_Inmueble ,inmueble.Manzana, inmueble.Num_Casa AS Casa, inmueble.Valor_Final,
		inmueble.Estado AS estado FROM inmueble INNER JOIN proyecto ON proyecto.Id_Proyecto=inmueble.Fk_Id_Proyecto WHERE inmueble.Estado!='N' ORDER BY inmueble.Fk_Id_Proyecto,inmueble.Manzana, inmueble.Num_Casa ;
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.ConsultarInmueblesProyecto
DELIMITER //
CREATE PROCEDURE `ConsultarInmueblesProyecto`(
	IN `ID` INT
)
    COMMENT 'Procedimiento para consultar los inmuebles por proyecto'
BEGIN
	DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		SELECT inmueble.Id_Inmueble ,inmueble.Manzana, inmueble.Num_Casa AS Casa, inmueble.Valor_Inicial, inmueble.Valor_Final, 
		proyecto.Nombre_Proyecto AS proyecto ,inmueble.Ficha_Catastral AS 'Ficha', inmueble.Escritura, inmueble.Matricula_inmobiliaria AS 'Matricula', 
		inmueble.Estado FROM inmueble INNER JOIN proyecto ON proyecto.Id_Proyecto=inmueble.Fk_Id_Proyecto WHERE inmueble.Fk_Id_Proyecto=ID AND inmueble.Estado!='N'
		ORDER BY inmueble.Fk_Id_Proyecto;
	COMMIT;

END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.ConsultarProyecto
DELIMITER //
CREATE PROCEDURE `ConsultarProyecto`(
	IN `ID` INT
)
    COMMENT 'Procedimiento para consultar la información de un proyecto por Id'
BEGIN
	DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		SELECT proyecto.Id_Proyecto AS id, proyecto.Nombre_Proyecto AS nombre, proyecto.Ubicacion_Proyecto AS ubicacion, COUNT(etapa.Id_Etapa) AS etapas,
				 proyecto.Estado_Proyecto AS estado FROM proyecto LEFT JOIN etapa ON proyecto.Id_Proyecto=etapa.Fk_Id_Proyecto
		WHERE proyecto.Id_Proyecto=ID 
		AND proyecto.Estado_Proyecto!='N' GROUP BY proyecto.Id_Proyecto;
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.ConsultarProyectos
DELIMITER //
CREATE PROCEDURE `ConsultarProyectos`()
    COMMENT 'Procedimiento para consultar los proyectos de la constructora'
BEGIN
	DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		SELECT proyecto.Id_Proyecto AS id, proyecto.Nombre_Proyecto AS nombre, proyecto.Ubicacion_Proyecto AS ubicacion, COUNT(etapa.Id_Etapa) AS etapas,
				 proyecto.Estado_Proyecto AS estado FROM proyecto LEFT JOIN etapa ON etapa.Fk_Id_Proyecto=proyecto.Id_Proyecto 
				 WHERE proyecto.Estado_Proyecto!='N' 
				 GROUP BY proyecto.Id_Proyecto;
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.ConsultarRol
DELIMITER //
CREATE PROCEDURE `ConsultarRol`(
	IN `ID` INT
)
    COMMENT 'Procedimiento para consultar la información de un rol por Id'
BEGIN
	DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		SELECT rol.Id_Rol AS id, rol.Nombre_Rol AS 'nombre', rol.Descripcion AS descripcion FROM rol WHERE rol.Id_Rol=ID AND rol.Estado='Y';
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.ConsultarRoles
DELIMITER //
CREATE PROCEDURE `ConsultarRoles`()
    COMMENT 'Procedimiento para consultar roles'
BEGIN
	DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		SELECT rol.Id_Rol AS id, rol.Nombre_Rol AS nombre, rol.Descripcion AS descripcion FROM rol WHERE rol.Estado='Y';
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.ConsultarUsuario
DELIMITER //
CREATE PROCEDURE `ConsultarUsuario`(
	IN `ID` INT
)
    COMMENT 'Procedimiento para consultar usuario'
BEGIN
	DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		SELECT persona.nombres AS nombres,
		persona.apellidos AS apellidos,persona.telefono AS telefono,
		persona.direccion AS direccion,persona.correo AS correo,
		persona.numero_identificacion AS identificacion, usuario.Id_Usuario AS iduser,
		usuario.Usuario AS `nick`,usuario.`Contraseña` AS `password`,
		area.Id_Area AS `IdArea`, rol.Id_Rol AS `IdRol`
		FROM usuario INNER JOIN persona on
		usuario.Fk_Id_Persona=persona.id_persona 
		INNER JOIN area ON usuario.Fk_Id_Area=area.Id_Area
		INNER JOIN rol ON usuario.Fk_Id_Rol= rol.Id_Rol WHERE usuario.Id_Usuario=ID;
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.ConsultarUsuarios
DELIMITER //
CREATE PROCEDURE `ConsultarUsuarios`()
    COMMENT 'Procedimiento para consultar usuarios'
BEGIN
	DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		SELECT persona.nombres AS nombres,
		persona.apellidos AS apellidos,persona.telefono AS telefono,
		persona.direccion AS direccion,persona.correo AS email,
		persona.numero_identificacion AS identification, usuario.Id_Usuario AS iduser,
		usuario.Usuario AS `usuario`,usuario.`Contraseña` AS `password`,
		area.Nom_Area AS `Area`, rol.Nombre_Rol AS `Rol`
		FROM usuario INNER JOIN persona on
		usuario.Fk_Id_Persona=persona.id_persona 
		INNER JOIN area ON usuario.Fk_Id_Area=area.Id_Area
		INNER JOIN rol ON usuario.Fk_Id_Rol= rol.Id_Rol
		WHERE usuario.Estado_User='Y';
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.CrearAdicional
DELIMITER //
CREATE PROCEDURE `CrearAdicional`(
	IN `Concepto` VARCHAR(150),
	IN `Valor_Adicional` VARCHAR(50),
	IN `Fecha_Adicional` VARCHAR(50),
	IN `Id_Inmueble` INT
)
    COMMENT 'procedimiento para crear un nuevo adicional'
BEGIN
DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		SET @IDADIC=(SELECT IFNULL(MAX(adicional.Id_Adicional),0) FROM adicional);	
		INSERT INTO adicional (adicional.Id_Adicional, adicional.Concepto, adicional.Valor_Adicional, adicional.Estado_Adicional, adicional.Fecha_Adicional, adicional.Fk_Id_Inmueble) 
		VALUES (@IDADIC+1, Concepto, Valor_Adicional, 'Y', Fecha_Adicional, Id_Inmueble);
		CALL `SHOW_MENSAJE`('3', 'Registro exitoso, el adicional fué creado de forma exitosa.');
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.CrearArea
DELIMITER //
CREATE PROCEDURE `CrearArea`(
	IN `nombre` VARCHAR(50),
	IN `descripcion` VARCHAR(150)
)
    COMMENT 'procedimiento para crear un nuevo area'
BEGIN
DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		SET @IDAREA=(SELECT IFNULL(MAX(area.Id_Area),0) FROM area);			
		
		INSERT INTO area(area.Id_Area,area.Nom_Area,area.Desc_Area, area.Estado)
		values
		(@IDAREA+1,nombre,descripcion,'Y');
		CALL `SHOW_MENSAJE`('3', 'Registro exitoso, el area fué creado de forma exitosa.');
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.CrearCliente
DELIMITER //
CREATE PROCEDURE `CrearCliente`(
	IN `nombres` VARCHAR(150),
	IN `apellidos` VARCHAR(150),
	IN `identificacion` VARCHAR(50),
	IN `telefono` INT,
	IN `direccion` VARCHAR(150),
	IN `correo` VARCHAR(150)
)
    COMMENT 'procedimiento para crear un nuevo cliente'
BEGIN
	DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		SET @IDCLI=(SELECT IFNULL(MAX(cliente.Id_Cliente),0) FROM cliente);
		SET @IDPER=(SELECT IFNULL(MAX(persona.id_persona),0) FROM persona);
		
		INSERT INTO persona(persona.id_persona,persona.nombres,persona.apellidos,
		persona.numero_identificacion,persona.telefono,persona.direccion,persona.correo)
		values
		(@IDPER+1,nombres,apellidos,identificacion,telefono,direccion,correo);
		
		INSERT INTO cliente(cliente.Id_Cliente,cliente.Fecha_Creacion,cliente.Fecha_Modificacion,
		cliente.Estado,cliente.id_persona)
		values
		(@IDCLI+1,NOW(),NOW(),'Y',@IDPER+1);
		CALL `SHOW_MENSAJE`('3', 'Registro exitoso, el cliente fué creado de forma exitosa.');
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.CrearContratoCliente
DELIMITER //
CREATE PROCEDURE `CrearContratoCliente`(
	IN `ID_CLIENTE` INT,
	IN `NUMERO_CONTRATO` VARCHAR(150),
	IN `FORMA_PAGO` VARCHAR(150),
	IN `VALOR_CONTRATO` INT,
	IN `FECHA_VENTA` DATE,
	IN `OBSERVACION` VARCHAR(550),
	IN `ID_INMUEBLE` INT
)
    COMMENT 'Procedimiento para crear un contrato a un cliente'
BEGIN
	DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		SET @IDCONT=(SELECT IFNULL(MAX(contrato_venta.Id_Contrato),0) FROM contrato_venta);
		
		INSERT INTO contrato_venta
		(contrato_venta.Id_Contrato,contrato_venta.Numero_Contrato,contrato_venta.Forma_Pago,
		contrato_venta.Valor_Contrato,contrato_venta.Fecha_Venta,contrato_venta.Observacion_Contrato,contrato_venta.Fk_Id_Inmueble)
		VALUES(@IDCONT+1,NUMERO_CONTRATO,FORMA_PAGO,VALOR_CONTRATO,FECHA_VENTA,OBSERVACION,ID_INMUEBLE);
		
		INSERT INTO cliente_contrato(cliente_contrato.Pfk_Id_Cliente,cliente_contrato.Pfk_Id_Contrato,cliente_contrato.Fecha_Cambio,cliente_contrato.Estado)
		VALUES(ID_CLIENTE,@IDCONT+1,NOW(),'Y');
  	 	CALL `SHOW_MENSAJE`('3', 'Se ha creado el contrato de forma exitosa');
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.CrearCosto
DELIMITER //
CREATE PROCEDURE `CrearCosto`(
	IN `Id_Inmueble` INT,
	IN `Fecha_Costo` VARCHAR(50)
)
    COMMENT 'procedimiento para crear un nuevo costo del inmueble'
BEGIN
DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		SET @IDCOS=(SELECT IFNULL(MAX(costo.Id_Costo),0) FROM costo);
		
		INSERT INTO costo (costo.Id_Costo, costo.Nom_Costo, costo.Valor_Costo) 
		VALUES (@IDCOS+1, NULL, NULL);
		INSERT INTO inmueble_costo (inmueble_costo.Pfk_Id_Inmueble, inmueble_costo.Pfk_Id_Costo, inmueble_costo.Fecha_Costo, inmueble_costo.Estado_Costo) 
		VALUES (Id_Inmueble, @IDCOS, Fecha_Costo, 'Y');
		CALL `SHOW_MENSAJE`('3', 'Registro exitoso, el costo fué creado de forma exitosa.');
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.CrearEtapa
DELIMITER //
CREATE PROCEDURE `CrearEtapa`(
	IN `num_etapa` VARCHAR(15),
	IN `estado_etapa` INT,
	IN `manzanas` INT,
	IN `idproyecto` INT
)
    COMMENT 'procedimiento para crear un nueva etapa'
BEGIN
DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		SET @IDETA=(SELECT IFNULL(MAX(etapa.Id_Etapa),0) FROM etapa);		

		INSERT INTO etapa (etapa.Id_Etapa, etapa.Num_Etapa, etapa.Estado_Etapa, etapa.Num_Manzanas, etapa.Fk_Id_Proyecto) 
		VALUES 
		(@IDETA+1, num_etapa, estado_etapa, manzanas, idproyecto);
		CALL `SHOW_MENSAJE`('3', 'Registro exitoso, la etapa fué creada de forma exitosa.');
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.CrearInmueble
DELIMITER //
CREATE PROCEDURE `CrearInmueble`(
	IN `manzana` VARCHAR(10),
	IN `casa` VARCHAR(10),
	IN `Valor_Inicial` VARCHAR(15),
	IN `Valor_Final` VARCHAR(15),
	IN `catastral` VARCHAR(20),
	IN `escritura` VARCHAR(20),
	IN `matricula` VARCHAR(20),
	IN `estado` VARCHAR(10),
	IN `idproyecto` INT,
	IN `idetapa` INT
)
    COMMENT 'procedimiento para crear un nuevo inmueble'
BEGIN
DECLARE exit handler for sqlexception
  	BEGIN	  		  	
    	CALL `SHOW_MENSAJE`('1', 'Error, por el momento e sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');    		
  		ROLLBACK;  		
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		SET @IDINMU=(SELECT IFNULL(MAX(inmueble.Id_Inmueble),0) FROM inmueble);			
		
		INSERT INTO inmueble (inmueble.Id_Inmueble, inmueble.Manzana, inmueble.Num_Casa, inmueble.Valor_Inicial, inmueble.Valor_Final, inmueble.Ficha_Catastral, 
						inmueble.Escritura, inmueble.Matricula_inmobiliaria, inmueble.Estado, inmueble.Fk_Id_Proyecto, inmueble.Fk_Id_Etapa) 
		VALUES 
		(@IDINMU+1, manzana, casa, Valor_Inicial, Valor_Final, catastral, escritura, matricula, estado, idproyecto, idetapa);
		CALL `SHOW_MENSAJE`('3', 'Registro exitoso, el inmueble fué creado de forma exitosa.');
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.CrearProyecto
DELIMITER //
CREATE PROCEDURE `CrearProyecto`(
	IN `nombre` VARCHAR(150),
	IN `ubicacion` VARCHAR(150),
	IN `estado` VARCHAR(10),
	IN `num_etapa` VARCHAR(50),
	IN `estado_etapa` VARCHAR(50),
	IN `manzanas` INT
)
    COMMENT 'procedimiento para crear un nuevo proyecto'
BEGIN
DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
    		#SHOW ERRORS;
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		SET @IDPROY=(SELECT IFNULL(MAX(proyecto.Id_Proyecto),0) FROM proyecto);		
		SET @IDETA=(SELECT IFNULL(MAX(etapa.Id_Etapa),0) FROM etapa);	
		
		INSERT INTO proyecto (proyecto.Id_Proyecto, proyecto.Nombre_Proyecto, proyecto.Ubicacion_Proyecto, proyecto.Estado_Proyecto ) 
		VALUES 
		(@IDPROY+1, nombre, ubicacion, estado);
		
		INSERT INTO etapa (etapa.Id_Etapa, etapa.Num_Etapa, etapa.Estado_Etapa, etapa.Num_Manzanas, etapa.Fk_Id_Proyecto) 
		VALUES 
		(@IDETA+1, num_etapa, estado_etapa, manzanas, @IDPROY+1);
		
		CALL `SHOW_MENSAJE`('3', 'Registro exitoso, el proyecto fué creado de forma exitosa.');
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.CrearRol
DELIMITER //
CREATE PROCEDURE `CrearRol`(
	IN `Nombre_Rol` VARCHAR(50),
	IN `Descripcion` VARCHAR(150)
)
    COMMENT 'procedimiento para crear un nuevo rol'
BEGIN
DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		SET @IDROL=(SELECT IFNULL(MAX(rol.Id_Rol),0) FROM rol);			
		
		INSERT INTO rol(rol.Id_Rol,rol.Nombre_Rol,rol.Descripcion, rol.Estado)
		values
		(@IDROL+1,Nombre_Rol,Descripcion,'Y');
		CALL `SHOW_MENSAJE`('3', 'Registro exitoso, el rol fué creado de forma exitosa.');
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.CrearUsuario
DELIMITER //
CREATE PROCEDURE `CrearUsuario`(
	IN `nombres` VARCHAR(150),
	IN `apellidos` VARCHAR(150),
	IN `identificacion` VARCHAR(15),
	IN `telefono` VARCHAR(15),
	IN `direccion` VARCHAR(150),
	IN `correo` VARCHAR(150),
	IN `nick` VARCHAR(50),
	IN `password` VARCHAR(50),
	IN `IdRol` INT,
	IN `IdArea` INT
)
    COMMENT 'procedimiento para crear un nuevo usuario'
BEGIN
	DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		SET @IDUSER=(SELECT IFNULL(MAX(usuario.Id_Usuario),0) FROM usuario);
		SET @IDPER=(SELECT IFNULL(MAX(persona.id_persona),0) FROM persona);
		
		INSERT INTO persona(persona.id_persona,persona.nombres,persona.apellidos,
		persona.numero_identificacion,persona.telefono,persona.direccion,persona.correo)
		values
		(@IDPER+1,nombres,apellidos,identificacion,telefono,direccion,correo);
		
		INSERT INTO usuario(usuario.Id_Usuario,usuario.`Usuario`, usuario.`Contraseña`, usuario.Fecha_Creacion_User,usuario.Fecha_Modificacion_User,
		usuario.Estado_User ,usuario.Fk_Id_Persona, usuario.Fk_Id_Rol, usuario.Fk_Id_Area)
		values
		(@IDUSER+1,nick,`password`,NOW(),NOW(),'Y',@IDPER+1,IdRol,IdArea);
		CALL `SHOW_MENSAJE`('3', 'Registro exitoso, el usuario fué creado de forma exitosa.');
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.EditarArea
DELIMITER //
CREATE PROCEDURE `EditarArea`(
	IN `id` INT,
	IN `nombre` VARCHAR(100),
	IN `descripcion` VARCHAR(150),
	IN `estado` VARCHAR(10)
)
    COMMENT 'procedimiento para editar una area'
BEGIN
	DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		
		UPDATE area SET area.Nom_Area=nombre, area.Desc_Area=descripcion, 
		area.Estado=estado WHERE area.Id_Area=id;

		CALL `SHOW_MENSAJE`('3', 'Datos del area modificados de forma exitosa!');
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.EditarCliente
DELIMITER //
CREATE PROCEDURE `EditarCliente`(
	IN `ID` INT,
	IN `nombres` VARCHAR(150),
	IN `apellidos` VARCHAR(150),
	IN `correo` VARCHAR(150),
	IN `telefono` VARCHAR(150),
	IN `direccion` VARCHAR(150)
)
    COMMENT 'procedimiento para editar un cliente'
BEGIN
	DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		SET @IDPER=(SELECT IFNULL(cliente.id_persona,0) FROM cliente WHERE cliente.Id_Cliente=ID);
		
		UPDATE cliente SET cliente.Fecha_Modificacion=NOW() WHERE cliente.Id_Cliente=ID;
		
		UPDATE persona SET persona.nombres=nombres,persona.apellidos=apellidos,
		persona.telefono=telefono,persona.direccion=direccion,persona.correo=correo
		WHERE persona.id_persona=@IDPER;

		CALL `SHOW_MENSAJE`('3', 'Datos del cliente modificados de forma exitosa! Los cambios serán reflejados en su totalidad a partir del proximo inicio de sesión.');
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.EditarContratoCliente
DELIMITER //
CREATE PROCEDURE `EditarContratoCliente`(
	IN `ID_CLIENTE` INT,
	IN `NUMERO_CONTRATO` VARCHAR(150),
	IN `FORMA_PAGO` INT,
	IN `VALOR_CONTRATO` INT,
	IN `FECHA_VENTA` DATE,
	IN `OBSERVACION` VARCHAR(550),
	IN `ID_INMUEBLE` INT
)
    COMMENT 'procedimiento para modifciar la información del contrato de un cliente'
BEGIN
	DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		SET @IDCONT=(SELECT IFNULL(MAX(contrato_venta.Id_Contrato),0) FROM contrato_venta);
		
		INSERT INTO contrato_venta
		(contrato_venta.Id_Contrato,contrato_venta.Numero_Contrato,contrato_venta.Forma_Pago,
		contrato_venta.Valor_Contrato,contrato_venta.Fecha_Venta,contrato_venta.Observacion_Contrato,contrato_venta.Fk_Id_Inmueble)
		VALUES(@IDCONT+1,NUMERO_CONTRATO,FORMA_PAGO,VALOR_CONTRATO,FECHA_VENTA,OBSERVACION,ID_INMUEBLE);
		
		INSERT INTO cliente_contrato(cliente_contrato.Pfk_Id_Cliente,cliente_contrato.Pfk_Id_Contrato,cliente_contrato.Fecha_Cambio,cliente_contrato.Estado)
		VALUES(ID_CLIENTE,@IDCONT+1,NOW(),'Y');
  	 	CALL `SHOW_MENSAJE`('3', 'Se ha creado el contrato de forma exitosa');
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.EditarEtapa
DELIMITER //
CREATE PROCEDURE `EditarEtapa`(
	IN `ID` INT
)
    COMMENT 'procedimiento para editar una etapa'
BEGIN
	DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		
		UPDATE etapa SET etapa.Num_Etapa=num_etapa, etapa.Estado_Etapa=estado_etapa, 
		etapa.Num_Manzanas=manzanas WHERE etapa.Id_Etapa=ID;

		CALL `SHOW_MENSAJE`('3', 'Datos de la etapa modificados de forma exitosa!');
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.EditarInmueble
DELIMITER //
CREATE PROCEDURE `EditarInmueble`(
	IN `ID` INT,
	IN `manzana` INT,
	IN `casa` INT,
	IN `Valor_Inicial` VARCHAR(50),
	IN `Valor_Final` VARCHAR(50),
	IN `catastral` VARCHAR(50),
	IN `escritura` VARCHAR(50),
	IN `matricula` VARCHAR(50),
	IN `estado` VARCHAR(10),
	IN `idproyecto` INT,
	IN `idetapa` INT
)
    COMMENT 'procedimiento para editar un inmueble'
BEGIN
	DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		
		UPDATE inmueble SET inmueble.Manzana=manzana, inmueble.Num_Casa=casa, inmueble.Valor_Inicial=Valor_Inicial,
		inmueble.Valor_Final=Valor_Final, inmueble.Ficha_Catastral=catastral,inmueble.Escritura=escritura, inmueble.Matricula_inmobiliaria=matricula,
		inmueble.Estado=estado, inmueble.Fk_Id_Proyecto=idproyecto, inmueble.Fk_Id_Etapa=idetapa WHERE inmueble.Id_Inmueble=ID;

		CALL `SHOW_MENSAJE`('3', 'Datos del inmueble modificados de forma exitosa!');
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.EditarProyecto
DELIMITER //
CREATE PROCEDURE `EditarProyecto`(
	IN `ID` INT,
	IN `nombre` VARCHAR(150),
	IN `ubicacion` VARCHAR(150),
	IN `estado` VARCHAR(10)
)
    COMMENT 'procedimiento para editar un proyecto'
BEGIN
DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		
		UPDATE proyecto SET proyecto.Nombre_Proyecto=nombre, proyecto.Ubicacion_Proyecto=ubicacion, 
		proyecto.Estado_Proyecto=estado, proyecto.Fecha_Modificacion=NOW() WHERE proyecto.Id_Proyecto=ID;

		CALL `SHOW_MENSAJE`('3', 'Datos del proyecto modificados de forma exitosa!');
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.EditarRol
DELIMITER //
CREATE PROCEDURE `EditarRol`(
	IN `ID` INT,
	IN `nombre` VARCHAR(150),
	IN `descripcion` VARCHAR(150)
)
    COMMENT 'procedimiento para editar un rol'
BEGIN
DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		
		UPDATE rol SET rol.Nombre_Rol=nombre, rol.Descripcion=descripcion, 
		rol.Estado=estado WHERE rol.Id_Rol=ID;

		CALL `SHOW_MENSAJE`('3', 'Datos del rol modificados de forma exitosa!');
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.EditarUsuario
DELIMITER //
CREATE PROCEDURE `EditarUsuario`(
	IN `id` INT,
	IN `nombres` VARCHAR(150),
	IN `apellidos` VARCHAR(150),
	IN `identificacion` INT,
	IN `telefono` VARCHAR(15),
	IN `direccion` VARCHAR(100),
	IN `correo` VARCHAR(100),
	IN `nick` VARCHAR(50),
	IN `password` VARCHAR(50),
	IN `IdRol` INT,
	IN `IdArea` INT
)
    COMMENT 'procedimiento para editar un usuario'
BEGIN
	DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		SET @IDUSER=(SELECT IFNULL(usuario.Fk_Id_Persona,0) FROM usuario WHERE usuario.Id_Usuario=ID);
		
		UPDATE usuario SET usuario.Usuario=`Usuario`, usuario.Contraseña=`password`, usuario.Fk_Id_Rol=IdRol, 
		usuario.Fk_Id_Area=IdArea, usuario.Fecha_Modificacion_User=NOW() WHERE usuario.Id_Usuario=ID;
		
		UPDATE persona SET persona.numero_identificacion=identificacion, persona.nombres=nombres,persona.apellidos=apellidos,
		persona.telefono=telefono,persona.direccion=direccion,persona.correo=correo
		WHERE persona.id_persona=@IDUSER;

		CALL `SHOW_MENSAJE`('3', 'Datos del usuario modificados de forma exitosa!');
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.EliminarArea
DELIMITER //
CREATE PROCEDURE `EliminarArea`(
	IN `ID` INT
)
    COMMENT 'Procedimiento para eliminar un area'
BEGIN
	DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		IF((SELECT area.Estado FROM area WHERE area.Id_Area=ID)='Y') THEN
			UPDATE area SET area.Estado="N" WHERE area.Id_Area=ID;
			CALL `SHOW_MENSAJE`('3', 'Area eliminada con exito.');
		ELSE
			CALL `SHOW_MENSAJE`('1', 'Lo sentimos, ya fué eliminado o no existe.');
		END IF;
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.EliminarCliente
DELIMITER //
CREATE PROCEDURE `EliminarCliente`(
	IN `ID` INT
)
    COMMENT 'Procedimiento para eliminar un cliente'
BEGIN
	DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		IF((SELECT cliente.Estado FROM cliente WHERE cliente.Id_Cliente=ID)= 'Y') THEN
			UPDATE cliente SET cliente.Estado="N" WHERE cliente.Id_Cliente=ID;
			CALL `SHOW_MENSAJE`('3', 'Cliente eliminado con exito.');
		ELSE
			CALL `SHOW_MENSAJE`('1', 'Lo sentimos, ya fué eliminado o no existe.');
		END IF;
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.EliminarEtapa
DELIMITER //
CREATE PROCEDURE `EliminarEtapa`(
	IN `ID` INT
)
    COMMENT 'Procedimiento para eliminar una etapa'
BEGIN
	DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		IF((SELECT etapa.Estado_Etapa FROM etapa WHERE etapa.Id_Etapa=ID)!='N') THEN
			UPDATE etapa SET etapa.Estado_Etapa="N" WHERE etapa.Id_Etapa=ID;
			CALL `SHOW_MENSAJE`('3', 'Etapa eliminada con exito.');
		ELSE
			CALL `SHOW_MENSAJE`('1', 'Lo sentimos, ya fué eliminado o no existe.');
		END IF;
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.EliminarInmueble
DELIMITER //
CREATE PROCEDURE `EliminarInmueble`(
	IN `ID` INT
)
    COMMENT 'Procedimiento para eliminar un inmueble'
BEGIN
	DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		IF((SELECT inmueble.Estado FROM inmueble WHERE inmueble.Id_Inmueble=ID)!='N') THEN
			UPDATE inmueble SET inmueble.Estado="N" WHERE inmueble.Id_Inmueble=ID;
			CALL `SHOW_MENSAJE`('3', 'Inmueble eliminado con exito.');
		ELSE
			CALL `SHOW_MENSAJE`('1', 'Lo sentimos, ya fué eliminado o no existe.');
		END IF;
	COMMIT;

END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.EliminarProyecto
DELIMITER //
CREATE PROCEDURE `EliminarProyecto`(
	IN `ID` INT
)
    COMMENT 'Procedimiento para eliminar un proyecto'
BEGIN
	DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		IF((SELECT proyecto.Estado_Proyecto FROM proyecto WHERE proyecto.Id_Proyecto=ID)!='N') THEN
			UPDATE proyecto SET proyecto.Estado_Proyecto="N" WHERE proyecto.Id_Proyecto=ID;
			CALL `SHOW_MENSAJE`('3', 'Proyecto eliminado con exito.');
		ELSE
			CALL `SHOW_MENSAJE`('1', 'Lo sentimos, ya fué eliminado o no existe.');
		END IF;
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.EliminarRol
DELIMITER //
CREATE PROCEDURE `EliminarRol`(
	IN `ID` INT
)
    COMMENT 'Procedimiento para eliminar un rol'
BEGIN
	DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		IF((SELECT rol.Estado FROM rol WHERE rol.Id_Rol=ID)='Y') THEN
			UPDATE rol SET rol.Estado="N" WHERE rol.Id_Rol=ID;
			CALL `SHOW_MENSAJE`('3', 'Rol eliminado con exito.');
		ELSE
			CALL `SHOW_MENSAJE`('1', 'Lo sentimos, ya fué eliminado o no existe.');
		END IF;
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.EliminarUsuario
DELIMITER //
CREATE PROCEDURE `EliminarUsuario`(
	IN `ID` INT
)
    COMMENT 'Procedimiento para eliminar un usuario'
BEGIN
	DECLARE exit handler for sqlexception
  		BEGIN
    		CALL `SHOW_MENSAJE`('1', 'Error, por el momento el sistema está teniendo problemas para realizar la operación solicitada. Tome una foto o captura de pantalla y contáctese con soporte, disculpe las molestias.');
  		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
 		BEGIN
   	 	CALL `SHOW_MENSAJE`('2', 'Se ha producido un evento inesperado, por favor contáctar con soporte.');
 		ROLLBACK;
	END;

	START TRANSACTION;
		IF((SELECT usuario.Estado_User FROM usuario WHERE usuario.Id_Usuario=ID)= 'Y') THEN
			UPDATE usuario SET usuario.Estado_User ="N" WHERE usuario.Id_Usuario=ID;
			CALL `SHOW_MENSAJE`('3', 'Usuario eliminado con exito.');
		ELSE
			CALL `SHOW_MENSAJE`('1', 'Lo sentimos, ya fué eliminado o no existe.');
		END IF;
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.SHOW_MENSAJE
DELIMITER //
CREATE PROCEDURE `SHOW_MENSAJE`(
	IN `TIPO` INT,
	IN `MENSAJE` VARCHAR(200)
)
    COMMENT 'PROCEDIMIENTO PARA MOSTRAR UN MENSAJE'
BEGIN
	SELECT TIPO AS 'TIPO', MENSAJE AS 'MENSAJE';
END//
DELIMITER ;

-- Volcando estructura para disparador mcgdb.cliente_before_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `cliente_before_insert` AFTER INSERT ON `cliente` FOR EACH ROW BEGIN
		SET @IDCAR=(SELECT IFNULL(MAX(cartera.Id_Cartera),0) FROM cartera);

		INSERT INTO cartera(cartera.Id_Cartera,cartera.Estado_Cartera,cartera.Valor_Recaudado,
		cartera.Saldo,cartera.Total_Cartera,cartera.Fk_Id_Cliente)
		VALUES(@IDCAR+1,'Y',0,0,0,NEW.Id_Cliente);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
