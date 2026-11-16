-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         13.0.2-MariaDB - MariaDB Server
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.20.0.7320
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para rpg_manager
CREATE DATABASE IF NOT EXISTS `rpg_manager` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci */;
USE `rpg_manager`;

-- Volcando estructura para tabla rpg_manager.character_quests
CREATE TABLE IF NOT EXISTS `character_quests` (
  `character_id` int(11) NOT NULL,
  `quest_id` int(11) NOT NULL,
  `status` varchar(20) DEFAULT 'En progreso',
  PRIMARY KEY (`character_id`,`quest_id`),
  KEY `quest_id` (`quest_id`),
  CONSTRAINT `1` FOREIGN KEY (`character_id`) REFERENCES `characters` (`id`) ON DELETE CASCADE,
  CONSTRAINT `2` FOREIGN KEY (`quest_id`) REFERENCES `quests` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla rpg_manager.character_quests: ~2 rows (aproximadamente)
INSERT INTO `character_quests` (`character_id`, `quest_id`, `status`) VALUES
	(1, 1, 'En progreso'),
	(2, 2, 'Completada');

-- Volcando estructura para tabla rpg_manager.character_skills
CREATE TABLE IF NOT EXISTS `character_skills` (
  `character_id` int(11) NOT NULL,
  `skill_id` int(11) NOT NULL,
  `skill_level` int(11) DEFAULT 1,
  PRIMARY KEY (`character_id`,`skill_id`),
  KEY `skill_id` (`skill_id`),
  CONSTRAINT `1` FOREIGN KEY (`character_id`) REFERENCES `characters` (`id`) ON DELETE CASCADE,
  CONSTRAINT `2` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla rpg_manager.character_skills: ~3 rows (aproximadamente)
INSERT INTO `character_skills` (`character_id`, `skill_id`, `skill_level`) VALUES
	(1, 1, 2),
	(1, 2, 1),
	(2, 3, 2);

-- Volcando estructura para tabla rpg_manager.characters
CREATE TABLE IF NOT EXISTS `characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `char_class` varchar(30) NOT NULL,
  `level` int(11) DEFAULT 1,
  `hp` int(11) NOT NULL,
  `mp` int(11) NOT NULL,
  `experience` int(11) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla rpg_manager.characters: ~2 rows (aproximadamente)
INSERT INTO `characters` (`id`, `name`, `char_class`, `level`, `hp`, `mp`, `experience`, `created_at`) VALUES
	(1, 'Gandalf', 'Mago', 5, 120, 300, 1500, '2026-11-16 01:38:13'),
	(2, 'Aragorn', 'Guerrero', 6, 250, 80, 2100, '2026-11-16 01:38:13');

-- Volcando estructura para tabla rpg_manager.inventory
CREATE TABLE IF NOT EXISTS `inventory` (
  `character_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `quantity` int(11) DEFAULT 1,
  PRIMARY KEY (`character_id`,`item_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `1` FOREIGN KEY (`character_id`) REFERENCES `characters` (`id`) ON DELETE CASCADE,
  CONSTRAINT `2` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla rpg_manager.inventory: ~3 rows (aproximadamente)
INSERT INTO `inventory` (`character_id`, `item_id`, `quantity`) VALUES
	(1, 2, 1),
	(1, 3, 3),
	(2, 1, 1);

-- Volcando estructura para tabla rpg_manager.items
CREATE TABLE IF NOT EXISTS `items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `item_type` varchar(30) NOT NULL,
  `description` text DEFAULT NULL,
  `value` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla rpg_manager.items: ~3 rows (aproximadamente)
INSERT INTO `items` (`id`, `name`, `item_type`, `description`, `value`) VALUES
	(1, 'Espada Larga', 'Arma', 'Hoja de acero templado estándar.', 150),
	(2, 'Báculo de Roble', 'Arma', 'Aumenta ligeramente el poder mágico.', 200),
	(3, 'Poción de Vida', 'Consumible', 'Restaura 50 puntos de HP.', 25);

-- Volcando estructura para tabla rpg_manager.quests
CREATE TABLE IF NOT EXISTS `quests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `reward_xp` int(11) DEFAULT 0,
  `reward_gold` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla rpg_manager.quests: ~2 rows (aproximadamente)
INSERT INTO `quests` (`id`, `title`, `description`, `reward_xp`, `reward_gold`) VALUES
	(1, 'Derrotar al Goblin del Bosque', 'Elimina al goblin que aterroriza los caminos del norte.', 500, 100),
	(2, 'Escoltar la Caravana', 'Protege los suministros hasta la ciudad vecina.', 800, 250);

-- Volcando estructura para tabla rpg_manager.skills
CREATE TABLE IF NOT EXISTS `skills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `skill_type` varchar(30) NOT NULL,
  `mp_cost` int(11) DEFAULT 0,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Volcando datos para la tabla rpg_manager.skills: ~3 rows (aproximadamente)
INSERT INTO `skills` (`id`, `name`, `skill_type`, `mp_cost`, `description`) VALUES
	(1, 'Bola de Fuego', 'Magia', 45, 'Lanza una esfera de fuego ardiente a un objetivo.'),
	(2, 'Escudo Arcano', 'Pasiva', 0, 'Reduce el daño mágico recibido en un 15%.'),
	(3, 'Golpe Certero', 'Activa', 15, 'Ataque físico con alta probabilidad de crítico.');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
