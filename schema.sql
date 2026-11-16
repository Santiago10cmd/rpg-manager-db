CREATE DATABASE rpg_manager;
USE rpg_manager;

-- ==========================================================
-- 2. CREACIÓN DE TABLAS PRINCIPALES
-- ==========================================================

-- Tabla de Personajes
CREATE TABLE characters (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    char_class VARCHAR(30) NOT NULL,
    level INT DEFAULT 1,
    hp INT DEFAULT 100,
    mp INT DEFAULT 50,
    experience INT DEFAULT 0,
    gold INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de Ítems
CREATE TABLE items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(50) NOT NULL,
    item_type VARCHAR(30) NOT NULL,
    description TEXT
);

-- Tabla de Habilidades (Skills)
CREATE TABLE skills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    skill_name VARCHAR(50) NOT NULL,
    skill_type VARCHAR(30) NOT NULL,
    mp_cost INT DEFAULT 10
);

-- Tabla de Misiones (Quests)
CREATE TABLE quests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    reward_xp INT DEFAULT 0,
    reward_gold INT DEFAULT 0
);

-- ==========================================================
-- 3. CREACIÓN DE TABLAS DE RELACIÓN (MUCHOS A MUCHOS)
-- ==========================================================

-- Inventario (Relación Characters <-> Items)
CREATE TABLE inventory (
    character_id INT,
    item_id INT,
    quantity INT DEFAULT 1,
    PRIMARY KEY (character_id, item_id),
    FOREIGN KEY (character_id) REFERENCES characters(id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES items(id) ON DELETE CASCADE
);

-- Habilidades del Personaje (Relación Characters <-> Skills)
CREATE TABLE character_skills (
    character_id INT,
    skill_id INT,
    skill_level INT DEFAULT 1,
    PRIMARY KEY (character_id, skill_id),
    FOREIGN KEY (character_id) REFERENCES characters(id) ON DELETE CASCADE,
    FOREIGN KEY (skill_id) REFERENCES skills(id) ON DELETE CASCADE
);

-- Misiones del Personaje (Relación Characters <-> Quests)
CREATE TABLE character_quests (
    character_id INT,
    quest_id INT,
    status VARCHAR(20) DEFAULT 'En progreso', -- 'En progreso', 'Completada'
    PRIMARY KEY (character_id, quest_id),
    FOREIGN KEY (character_id) REFERENCES characters(id) ON DELETE CASCADE,
    FOREIGN KEY (quest_id) REFERENCES quests(id) ON DELETE CASCADE
);

-- ==========================================================
-- 4. INSERCIÓN DE DATOS DE PRUEBA (SEEDERS)
-- ==========================================================

-- Personajes
INSERT INTO characters (name, char_class, level, hp, mp, experience, gold) VALUES
('Gandalf', 'Mago', 5, 120, 300, 1500, 150),
('Aragorn', 'Guerrero', 6, 250, 80, 2100, 250);

-- Ítems
INSERT INTO items (item_name, item_type, description) VALUES
('Báculo de Roble', 'Arma', 'Aumenta ligeramente el poder mágico.'),
('Poción de Vida', 'Consumible', 'Restaura 50 puntos de HP.'),
('Espada Larga', 'Arma', 'Hoja de acero templado estándar.');

-- Habilidades
INSERT INTO skills (skill_name, skill_type, mp_cost) VALUES
('Bola de Fuego', 'Magia', 45),
('Escudo Arcano', 'Pasiva', 0),
('Golpe Certero', 'Activa', 15);

-- Misiones
INSERT INTO quests (title, reward_xp, reward_gold) VALUES
('Derrotar al Goblin del Bosque', 500, 100),
('Escoltar la Caravana', 800, 250);

-- Relaciones de prueba
INSERT INTO inventory (character_id, item_id, quantity) VALUES
(1, 1, 1), -- Gandalf tiene Báculo de Roble
(1, 2, 3), -- Gandalf tiene 3 Pociones de Vida
(2, 3, 1); -- Aragorn tiene Espada Larga

INSERT INTO character_skills (character_id, skill_id, skill_level) VALUES
(1, 1, 2), -- Gandalf conoce Bola de Fuego (Nivel 2)
(1, 2, 1), -- Gandalf conoce Escudo Arcano (Nivel 1)
(2, 3, 2); -- Aragorn conoce Golpe Certero (Nivel 2)

INSERT INTO character_quests (character_id, quest_id, status) VALUES
(1, 1, 'En progreso'),
(2, 2, 'Completada');

-- ==========================================================
-- 5. PROCEDIMIENTOS ALMACENADOS (STORED PROCEDURES)
-- ==========================================================

DELIMITER //

-- Procedimiento para subir de nivel a un personaje
CREATE PROCEDURE sp_level_up(IN p_character_id INT)
BEGIN
    UPDATE characters 
    SET level = level + 1, 
        hp = hp + 20, 
        mp = mp + 10 
    WHERE id = p_character_id;
END //

-- Procedimiento para completar una misión y otorgar recompensas
CREATE PROCEDURE sp_complete_quest(IN p_character_id INT, IN p_quest_id INT)
BEGIN
    DECLARE v_xp INT;
    DECLARE v_gold INT;

    -- Obtener recompensas de la misión
    SELECT reward_xp, reward_gold INTO v_xp, v_gold 
    FROM quests WHERE id = p_quest_id;

    -- Actualizar el estado de la misión a completada
    UPDATE character_quests 
    SET status = 'Completada' 
    WHERE character_id = p_character_id AND quest_id = p_quest_id;

    -- Sumar experiencia y oro al personaje
    UPDATE characters 
    SET experience = experience + v_xp, 
        gold = gold + v_gold 
    WHERE id = p_character_id;
END //

DELIMITER ;