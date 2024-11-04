-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.32-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.7.0.6850
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para eleicao
CREATE DATABASE IF NOT EXISTS `eleicao` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `eleicao`;

-- Copiando estrutura para tabela eleicao.candidatos
CREATE TABLE IF NOT EXISTS `candidatos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  `votos` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `numero` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `eleitor_id` int(11) DEFAULT NULL,
  `eleicao_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `eleitor_id` (`eleitor_id`),
  KEY `eleicao_id` (`eleicao_id`),
  CONSTRAINT `candidatos_ibfk_1` FOREIGN KEY (`eleitor_id`) REFERENCES `eleitores` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `candidatos_ibfk_2` FOREIGN KEY (`eleicao_id`) REFERENCES `eleicoes` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela eleicao.candidatos: ~3 rows (aproximadamente)
INSERT INTO `candidatos` (`id`, `descricao`, `votos`, `status`, `numero`, `createdAt`, `updatedAt`, `eleitor_id`, `eleicao_id`) VALUES
	(1, 'Liga da Justiça', 0, 0, 1, '2024-11-03 19:30:05', '2024-11-03 19:30:05', 63, 1),
	(2, 'Vingadores', 0, 0, 2, '2024-11-03 19:30:15', '2024-11-03 19:30:15', 11, 1),
	(3, 'Jovens Titans', 0, 0, 3, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 40, 1);

-- Copiando estrutura para tabela eleicao.comprovantes
CREATE TABLE IF NOT EXISTS `comprovantes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `eleitor_id` int(11) DEFAULT NULL,
  `eleicao_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `eleitor_id` (`eleitor_id`),
  KEY `eleicao_id` (`eleicao_id`),
  CONSTRAINT `comprovantes_ibfk_1` FOREIGN KEY (`eleitor_id`) REFERENCES `eleitores` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `comprovantes_ibfk_2` FOREIGN KEY (`eleicao_id`) REFERENCES `eleicoes` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela eleicao.comprovantes: ~2 rows (aproximadamente)
INSERT INTO `comprovantes` (`id`, `createdAt`, `updatedAt`, `eleitor_id`, `eleicao_id`) VALUES
	(10, '2024-11-04 00:43:40', '2024-11-04 00:43:40', 1, 1),
	(11, '2024-11-04 00:45:50', '2024-11-04 00:45:50', 2, 1);

-- Copiando estrutura para tabela eleicao.eleicoes
CREATE TABLE IF NOT EXISTS `eleicoes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  `inicio` datetime NOT NULL,
  `fim` datetime NOT NULL,
  `status` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela eleicao.eleicoes: ~1 rows (aproximadamente)
INSERT INTO `eleicoes` (`id`, `descricao`, `inicio`, `fim`, `status`, `createdAt`, `updatedAt`) VALUES
	(1, 'Centro Acadêmico (CADS)', '2024-11-04 11:00:00', '2024-04-08 02:59:00', 1, '2024-11-03 19:27:07', '2024-11-03 19:27:07');

-- Copiando estrutura para tabela eleicao.eleitores
CREATE TABLE IF NOT EXISTS `eleitores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `matricula` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `status` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela eleicao.eleitores: ~63 rows (aproximadamente)
INSERT INTO `eleitores` (`id`, `matricula`, `email`, `nome`, `status`, `createdAt`, `updatedAt`) VALUES
	(1, '1226388', 'brunovicente.lima@ifma.edu.br', 'Bruno Vicente Alves de Lima', 1, '2024-11-03 16:25:43', '2024-11-03 16:25:43'),
	(2, '20241ADS.CNT0024', 'silvaalderlindson@gmail.com', 'Alderlindson Sousa Silva', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(3, '20232ADS.CNT0024', 'doralicemariajsantoss@gmail.com', 'Alice Maria de Jesus dos Santos', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(4, '20241ADS.CNT0015', 'amandaalmeidapaz18@gmail.com', 'AMANDA PAZ DE ALMEIDA', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(5, '20232ADS.CNT0040', 'limaaflavia22@gmail.com', 'Ana Flavia Lima Nascimento', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(6, '20241ADS.CNT0031', 'anasantosparente09@gmail.com', 'Ana Francisca dos Santos Parente da Silva', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(7, '20241ADS.CNT0001', 'anielantonio063@gmail.com', 'Aniel Antonio Araujo Nascimento', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(8, '20232ADS.CNT0001', 'anthony.araujo888@gmail.com', 'Anthony Araújo Ferreira', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(9, '20242ADS.CNT0004', 'tavaresjr9@gmail.com', 'Antônio Tavares Júnior', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(10, '20232ADS.CNT0037', 'brunofereira822@gmail.com', 'Bruno Pereira', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(11, '20232ADS.CNT0008', 'caiosouzza408@gmail.com', 'Caio de Souza Oliveira', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(12, '20241ADS.CNT0008', 'nunes200456@gmail.com', 'Carlos Henrique Nunes da Silva', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(13, '20232ADS.CNT0014', 'carloswilliamwilliam7almeida@gmail.com', 'CARLOS WILLIAM ROCHA ALMEIDA', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(14, '20232ADS.CNT0033', 'cleydenetesilvasales@gmail.com', 'Cleidinete Silva Sales', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(15, '20241ADS.CNT0016', 'cleodomfilho@gmail.com', 'CLEODOM GOMES DA SILVA FILHO', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(16, '20232ADS.CNT0010', 'cruzdavi001@gmail.com', 'Davi Silva da Cruz', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(17, '20232ADS.CNT0013', 'dennisgabr745@gmail.com', 'DENNIS GABRIEL SILVA ALVES', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(18, '20241ADS.CNT0026', 'edyelsomsantos@gmail.com', 'EDYELSON SANTOS PEREIRA', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(19, '20241ADS.CNT0014', 'emillykauane563@gmail.com', 'Emilly Kauane da Silva Machado', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(20, '20232ADS.CNT0005', 'erlan.ara@gmail.com', 'Erlan de Araujo Silva', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(21, '20241ADS.CNT0021', 'evonaldodamiao@hotmail.com', 'Evonaldo Pereira Damiao', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(22, '20241ADS.CNT0020', 'felypemaxbrasil@gmail.com', 'FELYPE MAX SANTOS SILVA', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(23, '20232ADS.CNT0038', 'fco.anderson.1997@gmail.com', 'Francisco Anderson Pereira da Costa', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(24, '20232ADS.CNT0030', 'francisaraujo023@gmail.com', 'FRANCISCO DAS DORES ARAUJO DA CONCEICAO', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(25, '20232ADS.CNT0022', 'gn35679biel@gmail.com', 'GABRIEL LUIS DE ANDRADE CARVALHO', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(26, '20241ADS.CNT0004', 'geovergdiaslima@gmail.com', 'Geoverg Dias Lima', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(27, '20241ADS.CNT0022', 'glauconvinicius70@gmail.com', 'Glaucon Vinicius Assis da Silva', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(28, '20232ADS.CNT0028', 'handson97silva@gmail.com', 'Handson Francisco Marques da Silva', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(29, '20232ADS.CNT0009', 'igormetal59@gmail.com', 'Igor Ryan Bacelar Frota', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(30, '20232ADS.CNT0034', 'joana2507005@gmail.com', 'Joana Luiza Leal Almeida', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(31, '20241ADS.CNT0012', 'joaonelo874@gmail.com', 'João Emanuel Melo da Silva', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(32, '20241ADS.CNT0023', 'joaojoserocha003@gmail.com', 'João José Melo Rocha', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(33, '20241ADS.CNT0030', 'joaojoaovictornunes721@gmail.com', 'João Victor Nunes Correia', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(34, '20232ADS.CNT0023', '0liv3ira397@gmail.com', 'JOAO VITOR SANTOS OLIVEIRA', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(35, '20232ADS.CNT0007', 'neto-hpk10@hotmail.com', 'Jose Alves de Carvalho neto', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(36, '20242ADS.CNT0005', 'cjoseane631@gmail.com', 'Joseane da Silva Costa Silva', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(37, '20241ADS.CNT0010', 'juliogutierres123789@gmail.com', 'JULIO GUTIERRES CAMPOS DE SOUSA', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(38, '20241ADS.CNT0032', 'kaians131@gmail.com', 'Kaian Silva Rego', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(39, '20232ADS.CNT0031', 'kailanesilva34567@gmail.com', 'KAILANE DA SILVA MACHADO', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(40, '20232ADS.CNT0002', 'lauanderson38@gmail.com', 'Lauanderson Rael Costa Gomes', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(41, '20241ADS.CNT0034', 'leonidas5franca6@gmail.com', 'Leonidas Ferreira de França Neto', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(42, '20241ADS.CNT0013', 'vasconcelosleticia544@gmail.com', 'LETICIA VASCONCELOS SOUSA', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(43, '20241ADS.CNT0028', 'luanregysslima2016@gmail.com', 'Luan Regys Lima de Carvalho', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(44, '20241ADS.CNT0017', 'lucaslviana07@gmail.com', 'Lucas Lima Viana', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(45, '20232ADS.CNT0003', 'felipelipelop@gmail.com', 'Luiz Felipe Lopes da Silva', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(46, '20241ADS.CNT0007', 'marcelloccb1110@gmail.com', 'Marcelo Damasceno Conceição', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(47, '20232ADS.CNT0004', 'mf9190824@gmail.com', 'Maria Fernanda Da Silva', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(48, '20241ADS.CNT0018', 'marianeoliveira807@gmail.com', 'Mariane de Oliveira Silveira', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(49, '20241ADS.CNT0006', 'marvioty@gmail.com', 'MARVIO RODRIGUES DA SILVA', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(50, '20241ADS.CNT0002', 'nb799031@gmail.com', 'Natalia Bianca Silva Costa', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(51, '20242ADS.CNT0002', 'silvanatan6@gmail.com', 'Natanael da Silva Costa', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(52, '20241ADS.CNT0027', 'nawana608@gmail.com', 'Nawana Emanuelle Silva Sousa', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(53, '20242ADS.CNT0003', 'pedroalexandre406@gmail.com', 'Pedro Alexandre Linhares Lima', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(54, '20232ADS.CNT0039', 'rianlucas1638@gmail.com', 'Rian Lucas Moreira Araújo', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(55, '20241ADS.CNT0029', 'samwellcardous@gmail.com', 'SAMUEL CARDOSO FRANÇA', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(56, '20242ADS.CNT0001', 'samuelsilvaf7@yahoo.com', 'Samuel Silva dos Santos', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(57, '20232ADS.CNT0011', 'saviobarradas@gmail.com', 'SÁVIO HENRIQUE BARRADAS OLIVEIRA', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(58, '20232ADS.CNT0016', 'thamarasb.30@gmail.com', 'Tamara Silva Bastos', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(59, '20241ADS.CNT0005', 'freiretauan@gmail.com', 'Tauan Freire Dos Santos', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(60, '20232ADS.CNT0021', 'vitorsampi16@gmail.com', 'Vitor Augusto Lima Sampaio', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(61, '20232ADS.CNT0015', 'wesonbotinele@gmail.com', 'Wemerson da Silva Fontineles', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(62, '20232ADS.CNT0012', 'weslensousa4002@gmail.com', 'WESLEN SILVA DE SOUSA', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00'),
	(63, '20232ADS.CNT0019', 'yuregabriel11.yg76@gmail.com', 'Yure Gabriel Vasconcelos Pires', 0, '2024-10-31 00:00:00', '2024-10-31 00:00:00');

-- Copiando estrutura para tabela eleicao.urnas
CREATE TABLE IF NOT EXISTS `urnas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  `status` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `eleicao_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `eleicao_id` (`eleicao_id`),
  CONSTRAINT `urnas_ibfk_1` FOREIGN KEY (`eleicao_id`) REFERENCES `eleicoes` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela eleicao.urnas: ~1 rows (aproximadamente)
INSERT INTO `urnas` (`id`, `descricao`, `status`, `createdAt`, `updatedAt`, `eleicao_id`) VALUES
	(2, 'Urna Única', 0, '2024-11-03 20:07:18', '2024-11-03 20:07:18', 1);

-- Copiando estrutura para tabela eleicao.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(250) DEFAULT NULL,
  `categoria` int(11) DEFAULT NULL,
  `codigo` varchar(45) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `eleitor_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `eleitor_id` (`eleitor_id`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`eleitor_id`) REFERENCES `eleitores` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela eleicao.usuarios: ~64 rows (aproximadamente)
INSERT INTO `usuarios` (`id`, `username`, `password`, `categoria`, `codigo`, `status`, `createdAt`, `updatedAt`, `eleitor_id`) VALUES
	(3, '20241ADS.CNT0024', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 2),
	(4, '20232ADS.CNT0040', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 5),
	(5, '20232ADS.CNT0024', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 3),
	(6, '20241ADS.CNT0031', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 6),
	(7, '20241ADS.CNT0015', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 4),
	(8, '20241ADS.CNT0001', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 7),
	(9, '20232ADS.CNT0001', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 8),
	(10, '20242ADS.CNT0004', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 9),
	(11, '20232ADS.CNT0037', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 10),
	(12, '20232ADS.CNT0008', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 11),
	(13, '20241ADS.CNT0008', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 12),
	(14, '20232ADS.CNT0014', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 13),
	(15, '20232ADS.CNT0033', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 14),
	(16, '20241ADS.CNT0016', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 15),
	(17, '20232ADS.CNT0010', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 16),
	(18, '20232ADS.CNT0013', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 17),
	(19, '20241ADS.CNT0026', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 18),
	(20, '20241ADS.CNT0014', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 19),
	(21, '20232ADS.CNT0005', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 20),
	(22, '20241ADS.CNT0021', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 21),
	(23, '20241ADS.CNT0020', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 22),
	(24, '20232ADS.CNT0038', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 23),
	(25, '20232ADS.CNT0030', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 24),
	(26, '20232ADS.CNT0022', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 25),
	(27, '20241ADS.CNT0004', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 26),
	(28, '20241ADS.CNT0022', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 27),
	(29, '20232ADS.CNT0028', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 28),
	(30, '20232ADS.CNT0009', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 29),
	(31, '20232ADS.CNT0034', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 30),
	(32, '20241ADS.CNT0012', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 31),
	(33, '20241ADS.CNT0023', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 32),
	(34, '20241ADS.CNT0030', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 33),
	(35, '20232ADS.CNT0023', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 34),
	(36, '20232ADS.CNT0007', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 35),
	(37, '20242ADS.CNT0005', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 36),
	(38, '20241ADS.CNT0010', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 37),
	(39, '20241ADS.CNT0032', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 38),
	(40, '20232ADS.CNT0031', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 39),
	(41, '20232ADS.CNT0002', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 40),
	(42, '20241ADS.CNT0034', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 41),
	(43, '20241ADS.CNT0013', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 42),
	(44, '20241ADS.CNT0028', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 43),
	(45, '20241ADS.CNT0017', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 44),
	(46, '20232ADS.CNT0003', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 45),
	(47, '20241ADS.CNT0007', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 46),
	(48, '20232ADS.CNT0004', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 47),
	(49, '20241ADS.CNT0018', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 48),
	(50, '20241ADS.CNT0006', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 49),
	(51, '20241ADS.CNT0002', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 50),
	(52, '20242ADS.CNT0002', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 51),
	(53, '20241ADS.CNT0027', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 52),
	(54, '20242ADS.CNT0003', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 53),
	(55, '20232ADS.CNT0039', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 54),
	(56, '20241ADS.CNT0029', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 55),
	(57, '20242ADS.CNT0001', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 56),
	(58, '20232ADS.CNT0011', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 57),
	(59, '20232ADS.CNT0016', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 58),
	(60, '20241ADS.CNT0005', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 59),
	(61, '20232ADS.CNT0021', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 60),
	(62, '20232ADS.CNT0015', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 61),
	(63, '20232ADS.CNT0012', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 62),
	(64, '20232ADS.CNT0019', '$2a$10$V.ItWdFSQ4KRbCJ5PXke/ezVntHCghLZL/Al8YPqtRGviIgIN/vqG', 0, NULL, 1, '2024-11-03 23:44:15', '2024-11-03 23:44:15', 63),
	(65, '232323', '$2a$10$MZ1chMUl/QU3dQyS4lioT..Rsn92DbHTZWS3aBahFLfKGzcr5ppXS', 0, NULL, 0, '2024-11-04 11:42:01', '2024-11-04 11:42:01', NULL),
	(66, '1226388', '$2a$10$Qy9lPIlSnU4mnri9FWAYuOJJLc6SaLECHa5kWUOtqE7MZlNWozxba', 1, NULL, 0, '2024-11-04 12:23:37', '2024-11-04 12:30:01', NULL);

-- Copiando estrutura para tabela eleicao.votos
CREATE TABLE IF NOT EXISTS `votos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` int(11) NOT NULL,
  `urna_id` int(11) DEFAULT NULL,
  `candidato_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `urna_id` (`urna_id`),
  KEY `candidato_id` (`candidato_id`),
  CONSTRAINT `votos_ibfk_1` FOREIGN KEY (`urna_id`) REFERENCES `urnas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `votos_ibfk_2` FOREIGN KEY (`candidato_id`) REFERENCES `candidatos` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela eleicao.votos: ~2 rows (aproximadamente)
INSERT INTO `votos` (`id`, `tipo`, `urna_id`, `candidato_id`) VALUES
	(11, 1, 2, 2),
	(12, 1, 2, 2);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
