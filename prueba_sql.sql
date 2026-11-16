-- Ver el estado actual de Gandalf (nivel y atributos antes de subir)
SELECT id, name, level, hp, mp FROM characters WHERE id = 1;

-- Ejecutar el procedimiento para subir de nivel
CALL sp_level_up(1);

-- Verificar que su nivel aumentó en 1 y sus atributos (HP y MP) subieron
SELECT id, name, level, hp, mp FROM characters WHERE id = 1;

-- Ver el oro, experiencia y estado de la misión antes de completarla
SELECT c.id, c.name, c.experience, c.gold, cq.status 
FROM characters c
JOIN character_quests cq ON c.id = cq.character_id
WHERE c.id = 1 AND cq.quest_id = 1;

-- Ejecutar el procedimiento para completar la misión
CALL sp_complete_quest(1, 1);

-- Verificar que la misión cambió a 'Completada' y se sumó el XP y oro al personaje
SELECT c.id, c.name, c.experience, c.gold, cq.status 
FROM characters c
JOIN character_quests cq ON c.id = cq.character_id
WHERE c.id = 1 AND cq.quest_id = 1;

SELECT name, char_class, level
FROM characters
WHERE level >= 5
ORDER BY level DESC;

SELECT * 
FROM items 
WHERE item_type = 'Arma';

SELECT * 
FROM items 
WHERE item_name LIKE '%Poción%';