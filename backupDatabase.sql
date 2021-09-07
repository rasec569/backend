-- --------------------------------------------------------
-- Host:                         72.167.41.112
-- Versión del servidor:         8.0.26 - MySQL Community Server - GPL
-- SO del servidor:              Linux
-- HeidiSQL Versión:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para mcgdb
CREATE DATABASE IF NOT EXISTS `mcgdb` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mcgdb`;

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
  PRIMARY KEY (`Id_Area`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.area: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `area` DISABLE KEYS */;
INSERT INTO `area` (`Id_Area`, `Nom_Area`, `Desc_Area`) VALUES
	(1, 'Desarrollo', NULL),
	(2, 'Gerencia', 'Toman las deciciones de la constructora');
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.cartera: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `cartera` DISABLE KEYS */;
INSERT INTO `cartera` (`Id_Cartera`, `Estado_Cartera`, `Valor_Recaudado`, `Saldo`, `Total_Cartera`, `Fk_Id_Cliente`) VALUES
	(3, 'Y', 0, 0, 0, 3),
	(4, 'Y', 0, 0, 0, 4),
	(5, 'Y', 0, 0, 0, 5),
	(6, 'Y', 0, 0, 0, 6),
	(7, 'Y', 0, 0, 0, 7);
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.cliente: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` (`Id_Cliente`, `Fecha_Creacion`, `Fecha_Modificacion`, `Estado`, `id_persona`) VALUES
	(1, '2021-08-29 17:04:19', '2021-08-29 22:04:22', 'Y', 1),
	(2, '2021-08-29 17:04:32', '2021-08-29 22:04:33', 'Y', 2),
	(3, '2021-09-02 14:27:08', '2021-09-02 19:27:08', 'Y', 3),
	(4, '2021-09-05 22:50:51', '2021-09-06 03:50:51', 'Y', 4),
	(5, '2021-09-05 22:53:57', '2021-09-06 03:53:57', 'Y', 5),
	(6, '2021-09-06 20:01:06', '2021-09-06 23:18:54', 'Y', 6),
	(7, '2021-09-06 23:19:28', '2021-09-06 23:19:46', 'Y', 7);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.contrato_venta: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `contrato_venta` DISABLE KEYS */;
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
  CONSTRAINT `fk_Egresos_Pedido1` FOREIGN KEY (`Pedido_Id_Pedido`) REFERENCES `pedido` (`Id_Pedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.egresos: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `egresos` DISABLE KEYS */;
/*!40000 ALTER TABLE `egresos` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.etapa
CREATE TABLE IF NOT EXISTS `etapa` (
  `Id_Etapa` int NOT NULL AUTO_INCREMENT,
  `Num_Etapa` varchar(45) DEFAULT NULL,
  `Estado_Etapa` enum('Y','N') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'Y',
  `Fk_Id_Proyecto` int NOT NULL,
  PRIMARY KEY (`Id_Etapa`),
  KEY `fk_Etapa_Proyecto1_idx` (`Fk_Id_Proyecto`),
  CONSTRAINT `fk_Etapa_Proyecto1` FOREIGN KEY (`Fk_Id_Proyecto`) REFERENCES `proyecto` (`Id_Proyecto`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.etapa: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `etapa` DISABLE KEYS */;
INSERT INTO `etapa` (`Id_Etapa`, `Num_Etapa`, `Estado_Etapa`, `Fk_Id_Proyecto`) VALUES
	(1, '1', 'Y', 1),
	(2, '2', 'Y', 1);
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
  `Estado` enum('En Venta','Vendido','Pagado') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Fk_Id_Proyecto` int NOT NULL,
  PRIMARY KEY (`Id_Inmueble`),
  KEY `fk_Inmueble_Proyecto1_idx` (`Fk_Id_Proyecto`),
  CONSTRAINT `fk_Inmueble_Proyecto1` FOREIGN KEY (`Fk_Id_Proyecto`) REFERENCES `proyecto` (`Id_Proyecto`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.inmueble: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `inmueble` DISABLE KEYS */;
INSERT INTO `inmueble` (`Id_Inmueble`, `Manzana`, `Num_Casa`, `Valor_Inicial`, `Valor_Final`, `Ficha_Catastral`, `Escritura`, `Matricula_inmobiliaria`, `Estado`, `Fk_Id_Proyecto`) VALUES
	(1, 12, 1, 1200, NULL, '56789', 5678, 6789, 'En Venta', 1),
	(3, 24, 24, 134567, NULL, '13456', 1532, 111, 'En Venta', 2);
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

-- Volcando estructura para tabla mcgdb.pedido
CREATE TABLE IF NOT EXISTS `pedido` (
  `Id_Pedido` int NOT NULL AUTO_INCREMENT,
  `Fecha_Pedido` datetime NOT NULL,
  `Valor_Pedido` int NOT NULL,
  `Estado` varchar(45) NOT NULL,
  `Referencia` varchar(45) NOT NULL,
  `Fecha_Pago` datetime NOT NULL,
  `Fk_Id_Proveedor` int NOT NULL,
  `Fk_Id_Usuario` int NOT NULL,
  PRIMARY KEY (`Id_Pedido`),
  KEY `fk_Pedido_Proveedor1_idx` (`Fk_Id_Proveedor`),
  KEY `fk_Pedido_Usuario1_idx` (`Fk_Id_Usuario`),
  CONSTRAINT `fk_Pedido_Proveedor1` FOREIGN KEY (`Fk_Id_Proveedor`) REFERENCES `proveedor` (`Id_Proveedor`),
  CONSTRAINT `fk_Pedido_Usuario1` FOREIGN KEY (`Fk_Id_Usuario`) REFERENCES `usuario` (`Id_Usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.pedido: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;

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

-- Volcando datos para la tabla mcgdb.persona: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
INSERT INTO `persona` (`id_persona`, `nombres`, `apellidos`, `numero_identificacion`, `telefono`, `direccion`, `correo`) VALUES
	(1, 'Maicol', 'Aguilar Perez', '1117553160', '3134360567', 'calle5 # 9-03', 'ma.aguilar@udla.edu.co'),
	(2, 'Cesar', 'Valencia', '1075238593', '3133250701', 'none', 'example@udla.edu.co'),
	(3, 'Jair', 'Morales', '10068695478', '31111111', 'calle 5 # 9-03', 'none@gamil.com'),
	(4, 'Jamaica', 'Ole', '1000678958', '25488844', 'calle 5 #4432', 'nonee@gmail.com'),
	(5, 'mAICOL', 'sTEVEN', '1117553161', '11111113', 'NONE', 'happy@gmail.com'),
	(6, 'Anito', 'Morales Orting', '1117553167', '31111', 'none', 'none@gmail.es'),
	(7, 'Prueba|', 'Final', '122555', '5885558', 'ddsdsds', 'noesmicorreo@gmail.com');
/*!40000 ALTER TABLE `persona` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.proveedor
CREATE TABLE IF NOT EXISTS `proveedor` (
  `Id_Proveedor` int NOT NULL AUTO_INCREMENT,
  `Nombre_Proveedor` varchar(45) DEFAULT NULL,
  `Nit_Proveedor` varchar(45) DEFAULT NULL,
  `Telefono_Proveedor` varchar(45) DEFAULT NULL,
  `Correo_Proveedor` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Id_Proveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.proveedor: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.proyecto
CREATE TABLE IF NOT EXISTS `proyecto` (
  `Id_Proyecto` int NOT NULL AUTO_INCREMENT,
  `Nombre_Proyecto` varchar(45) DEFAULT NULL,
  `Ubicacion_Proyecto` varchar(150) DEFAULT NULL,
  `Estado_Proyecto` enum('Venta','Vendido') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'Venta',
  `Fecha_Modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`Id_Proyecto`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.proyecto: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `proyecto` DISABLE KEYS */;
INSERT INTO `proyecto` (`Id_Proyecto`, `Nombre_Proyecto`, `Ubicacion_Proyecto`, `Estado_Proyecto`, `Fecha_Modificacion`) VALUES
	(1, 'Punta del este', 'Via  a morelia detras de las casa fiscales ejercito', 'Venta', NULL),
	(2, 'Altos de San Jorge', 'el cundui', 'Vendido', NULL);
/*!40000 ALTER TABLE `proyecto` ENABLE KEYS */;

-- Volcando estructura para tabla mcgdb.rol
CREATE TABLE IF NOT EXISTS `rol` (
  `Id_Rol` int NOT NULL AUTO_INCREMENT,
  `Nombre_Rol` varchar(45) DEFAULT NULL,
  `Descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Id_Rol`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.rol: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` (`Id_Rol`, `Nombre_Rol`, `Descripcion`) VALUES
	(1, 'Desarrollo', 'Encargado de codificar y desarrollar la app'),
	(2, 'Cartera', 'Encargado del manejo de cartera de MCG');
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;

-- Volcando datos para la tabla mcgdb.usuario: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` (`Id_Usuario`, `Usuario`, `Contraseña`, `Fecha_Creacion_User`, `Fecha_Modificacion_User`, `Estado_User`, `Fk_Id_Persona`, `Fk_Id_Rol`, `Fk_Id_Area`) VALUES
	(2, 'admin', '123', '2021-09-02 19:56:05', NULL, 'Y', 1, 1, 1),
	(9, 'rasec', '4', '2021-09-02 19:56:05', NULL, 'Y', 2, 1, 1);
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
		SELECT area.Nom_Area AS Area,area.Desc_Area AS Descripcion  FROM area;
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
		SELECT etapa.Id_Etapa, etapa.Num_Etapa AS Numero,COUNT(inmueble.Id_Inmueble) AS inmuebles,  etapa.Estado_Etapa AS Estado  FROM etapa INNER JOIN proyecto ON etapa.Fk_Id_Proyecto= proyecto.Id_Proyecto INNER JOIN inmueble ON proyecto.Id_Proyecto= inmueble.Fk_Id_Proyecto WHERE etapa.Fk_Id_Proyecto=proyectoid GROUP BY etapa.Id_Etapa;
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.ConsultarInmueble
DELIMITER //
CREATE PROCEDURE `ConsultarInmueble`()
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
		SELECT inmueble.Id_Inmueble ,inmueble.Manzana, inmueble.Num_Casa AS Casa, inmueble.Valor_Inicial, inmueble.Valor_Final, proyecto.Nombre_Proyecto AS proyecto ,inmueble.Ficha_Catastral AS 'Ficha', 
		inmueble.Escritura, inmueble.Matricula_inmobiliaria AS 'Matricula', inmueble.Estado FROM inmueble INNER JOIN proyecto ON proyecto.Id_Proyecto=inmueble.Fk_Id_Proyecto ORDER BY inmueble.Fk_Id_Proyecto;
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
				 proyecto.Estado_Proyecto AS estado FROM proyecto LEFT JOIN etapa ON proyecto.Id_Proyecto=etapa.Fk_Id_Proyecto GROUP BY proyecto.Id_Proyecto;
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
		SELECT rol.Nombre_Rol AS 'Rol', rol.Descripcion FROM rol;
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.ConsultarUsuarios
DELIMITER //
CREATE PROCEDURE `ConsultarUsuarios`()
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
		persona.direccion AS direccion,persona.correo AS email,
		persona.numero_identificacion AS identification, usuario.Id_Usuario AS iduser,
		usuario.Usuario AS `usuario`,usuario.`Contraseña` AS `password`,
		area.Nom_Area AS `Area`, rol.Nombre_Rol AS `Rol`
		FROM usuario INNER JOIN persona on
		usuario.Fk_Id_Persona=persona.id_persona 
		INNER JOIN area ON usuario.Fk_Id_Area=area.Id_Area
		INNER JOIN rol ON usuario.Fk_Id_Rol= rol.Id_Rol;
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
		VALUES (@IDADIC, Concepto, Valor_Adicional, 'Y', Fecha_Adicional, Id_Inmueble);
		CALL `SHOW_MENSAJE`('3', 'Registro exitoso, el adicional fué creado de forma exitosa.');
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.CrearArea
DELIMITER //
CREATE PROCEDURE `CrearArea`(
	IN `Nom_Area` VARCHAR(50),
	IN `Desc_Area` VARCHAR(150)
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
		
		INSERT INTO area(area.Id_Area,area.Nom_Area,area.Desc_Area)
		values
		(@IDAREA+1,Nom_Area,Desc_Area);
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
		VALUES (@IDCOS, NULL, NULL);
		INSERT INTO inmueble_costo (inmueble_costo.Pfk_Id_Inmueble, inmueble_costo.Pfk_Id_Costo, inmueble_costo.Fecha_Costo, inmueble_costo.Estado_Costo) 
		VALUES (Id_Inmueble, @IDCOS, Fecha_Costo, 'Y');
		CALL `SHOW_MENSAJE`('3', 'Registro exitoso, el costo fué creado de forma exitosa.');
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.CrearEtapa
DELIMITER //
CREATE PROCEDURE `CrearEtapa`(
	IN `Num_Etapa` INT,
	IN `Fk_Id_Proyecto` INT
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
		SET @IDETA=(SELECT IFNULL(MAX(inmueble.Id_Inmueble),0) FROM inmueble);		

		INSERT INTO etapa (etapa.Id_Etapa, etapa.Num_Etapa, etapa.Estado_Etapa, etapa.Fk_Id_Proyecto) 
		VALUES 
		(@IDETA, Num_Etapa, 'Y', Fk_Id_Proyecto);
		CALL `SHOW_MENSAJE`('3', 'Registro exitoso, la etapa fué creada de forma exitosa.');
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.CrearInmueble
DELIMITER //
CREATE PROCEDURE `CrearInmueble`(
	IN `Manzana` INT,
	IN `Num_Casa` INT,
	IN `Valor_Inicial` INT,
	IN `Valor_Final` INT,
	IN `Ficha_Catastral` VARCHAR(50),
	IN `Escritura` VARCHAR(50),
	IN `Matricula_inmobiliaria` VARCHAR(50),
	IN `Fk_Id_Proyecto` INT
)
    COMMENT 'procedimiento para crear un nuevo inmueble'
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
		SET @IDINMU=(SELECT IFNULL(MAX(inmueble.Id_Inmueble),0) FROM inmueble);			
		
		INSERT INTO inmueble (inmueble.Id_Inmueble, inmueble.Manzana, inmueble.Num_Casa, inmueble.Valor_Inicial, inmueble.Valor_Final, inmueble.Ficha_Catastral, inmueble.Escritura, inmueble.Matricula_inmobiliaria, inmueble.Estado, inmueble.Fk_Id_Proyecto) 
		VALUES 
		(@IDINMU, Manzana, Num_Casa, Valor_Inicial, Valor_Final, Ficha_Catastral, Escritura, Matricula_inmobiliaria, 'En venta', Fk_Id_Proyecto);
		CALL `SHOW_MENSAJE`('3', 'Registro exitoso, el inmueble fué creado de forma exitosa.');
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.CrearProyecto
DELIMITER //
CREATE PROCEDURE `CrearProyecto`(
	IN `Nombre_Proyecto` VARCHAR(150),
	IN `Ubicacion_Proyecto` VARCHAR(150)
)
    COMMENT 'procedimiento para crear un nuevo proyecto'
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
		SET @IDPROY=(SELECT IFNULL(MAX(proyecto.Id_Proyecto),0) FROM proyecto);			
		
		INSERT INTO proyecto (proyecto.Id_Proyecto, proyecto.Nombre_Proyecto, proyecto.Ubicacion_Proyecto) 
		VALUES 
		(@IDPROY+1, Nombre_Proyecto, Ubicacion_Proyecto);
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
		
		INSERT INTO rol(rol.Id_Rol,rol.Nombre_Rol,rol.Descripcion)
		values
		(@IDROL+1,Nombre_Rol,Descripcion);
		CALL `SHOW_MENSAJE`('3', 'Registro exitoso, el rol fué creado de forma exitosa.');
	COMMIT;
END//
DELIMITER ;

-- Volcando estructura para procedimiento mcgdb.CrearUsuario
DELIMITER //
CREATE PROCEDURE `CrearUsuario`(
	IN `nombres` VARCHAR(150),
	IN `apellidos` VARCHAR(150),
	IN `identificacion` VARCHAR(50),
	IN `telefono` INT,
	IN `direccion` VARCHAR(150),
	IN `correo` VARCHAR(150),
	IN `Usuario` VARCHAR(50),
	IN `password` VARCHAR(50),
	IN `Fk_Id_Rol` INT,
	IN `Fk_Id_Area` INT
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
		(@IDUSER+1,`Usuario`,`password`,NOW(),NOW(),'Y',@IDPER+1,Fk_Id_Rol,Fk_Id_Area);
		CALL `SHOW_MENSAJE`('3', 'Registro exitoso, el usuario fué creado de forma exitosa.');
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

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
