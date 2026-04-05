-- Reiniciamos las tablas en caso de que ya estén pobladas para evitar errores de indexación o duplicados.
TRUNCATE TABLE Sponsor_Torneo, Inscripciones, Estadisticas_Jugador, Partidas, Jugador_en_equipo, Jugadores, Equipos, Torneos, Sponsors RESTART IDENTITY CASCADE;

-- AL menos 5 Sponsors.
INSERT INTO Sponsors (Nombre, Industria) Values
('Red Toro', 'Bebidas Energéticas'),
('Intel-igente', 'Hardware'),
('Razer-rasuradora', 'Periféricos'),
('Monstruo Energy', 'Bebidas Energéticas'),
('Logitech-no', 'Periféricos'),
('Sillas SecretLabrador', 'Mobiliario');

-- El Torneo 1 estará lleno de base (8/8).
INSERT INTO Torneos (Nombre, Videojuego, Fecha_Inicio, Fecha_Fin, Prize_Pool, MAX_Equipos) Values
('Calorant Champions Tour', 'Calorant', '2026-05-01', '2026-05-15', 1000000.00, 8),
('Mundo de Warcraft Arena Cup', 'Mundo de Warcraft', '2026-06-01', '2026-06-10', 50000.00, 8),
('Carreras Callejeras Pro', 'Gran Robo de Autos V', '2026-07-01', '2026-07-05', 20000.00, 8);

-- 5 Jugadores por Equipo, 50 Jugadores en total.
INSERT INTO Jugadores (Gamertag, Nombre_Real, Email, Fecha_Nacimiento, Pais) VALUES
-- Team Liquidos
('PenS', 'Tyson Ngo', 'pens@liquidos.com', '2001-05-05', 'Canadá'),
('S1mpleton', 'Sasha Kostyliev', 's1mple@liquidos.com', '1997-10-02', 'Ucrania'),
('Moonral', 'Kyle Jackson', 'moonral@liquidos.com', '2004-08-13', 'Reino Unido'),
('MergeSort', 'Alan Turing', 'sort@liquidos.com', '1999-01-01', 'Chile'),
('El_Bicho', 'Cristiano R.', 'bicho@liquidos.com', '1985-02-05', 'Portugal'),
-- Face Clan
('Bugha_Chueco', 'Kyle Giersdorf', 'bugha@face.com', '2002-12-30', 'EEUU'),
('Niko_tina', 'Nikola Kovac', 'niko@face.com', '1997-02-16', 'Bosnia'),
('Twist_zz', 'Russel Van Dulken', 'twist@face.com', '1999-11-14', 'Canadá'),
('Karrigan_t', 'Finn Andersen', 'karri@face.com', '1990-04-14', 'Dinamarca'),
('Ropz_illa', 'Robin Kool', 'ropz@face.com', '1999-12-22', 'Estonia'),
-- Maloi
('Ibai_Llanuras', 'Ibai L.', 'ibai@maloi.com', '1995-03-26', 'España'),
('Mixwell_Hecho', 'Oscar Cañellas', 'mix@maloi.com', '1995-10-10', 'España'),
('Koldamenta', 'Jose Luis', 'kolda@maloi.com', '1996-05-05', 'España'),
('Trexx_T-Rex', 'Nikita C.', 'trexx@maloi.com', '2003-01-01', 'Rusia'),
('Wolfen_stein', 'Kamil S.', 'wolf@maloi.com', '2000-02-02', 'Polonia'),
-- Krö
('Aguero_San', 'Sergio A.', 'kun@kro.com', '1988-06-02', 'Argentina'),
('Keznit_deu', 'Angelo Mori', 'keznit@kro.com', '2001-01-01', 'Chile'),
('Klaus_trofobia', 'Nicolas F.', 'klaus@kro.com', '2000-11-11', 'Argentina'),
('Mazino_ino', 'Roberto R.', 'mazi@kro.com', '2001-05-05', 'Chile'),
('Delz1k_o', 'Joaquin P.', 'delz@kro.com', '2000-03-03', 'Chile'),
-- Nube9
('Mang0_Biche', 'Joseph M.', 'mango@nube9.com', '1991-12-10', 'EEUU'),
('Zellsis_bro', 'Jordan M.', 'zell@nube9.com', '1998-03-02', 'EEUU'),
('Xeppaa_a', 'Erick B.', 'xepp@nube9.com', '2000-07-07', 'EEUU'),
('OXY_gen', 'Nathan M.', 'oxy@nube9.com', '2005-01-01', 'EEUU'),
('Vanity_Fair', 'Anthony M.', 'vanity@nube9.com', '1998-12-12', 'EEUU'),
-- Sentados
('SicK_o', 'Hunter M.', 'sick@sentados.com', '1998-09-02', 'EEUU'),
('Zekken_N', 'Zachary P.', 'zekken@sentados.com', '2005-03-03', 'EEUU'),
('Sacy_Salsa', 'Gustavo R.', 'sacy@sentados.com', '1997-12-12', 'Brasil'),
('Pancada_Fuerte', 'Bryan L.', 'pancada@sentados.com', '1999-05-05', 'Brasil'),
('JohnQT_pie', 'Amine O.', 'john@sentados.com', '1999-01-01', 'Marruecos'),
-- G-Tres
('Caps_ula', 'Rasmus B.', 'caps@gtres.com', '1999-11-17', 'Dinamarca'),
('M0NESY_Money', 'Ilya O.', 'monesy@gtres.com', '2005-05-01', 'Rusia'),
('NiKo_tina_2', 'Nikola K.', 'niko2@gtres.com', '1997-02-16', 'Bosnia'),
('Hunter_Recolector', 'Nemanja K.', 'hunter@gtres.com', '1996-01-03', 'Bosnia'),
('HooXi_Dady', 'Rasmus N.', 'hooxi@gtres.com', '1995-05-21', 'Dinamarca'),
-- Papel Rex
('Jinggg_le', 'Wang Jing', 'jing@papelrex.com', '2003-07-29', 'Singapur'),
('F0rsakeN_o', 'Jason S.', 'forsaken@papelrex.com', '2004-03-25', 'Indonesia'),
('Mindfreak_out', 'Aaron L.', 'mind@papelrex.com', '1999-10-10', 'Indonesia'),
('D4v41_AI', 'Khalish R.', 'd4v41@papelrex.com', '1998-11-14', 'Malasia'),
('Something_Else', 'Ilya P.', 'some@papelrex.com', '2002-02-11', 'Rusia'),
-- FnatiK
('Boaster_Toaster', 'Jake Howlett', 'boaster@fnatik.com', '1995-05-25', 'Reino Unido'),
('Derke_Dark', 'Nikita S.', 'derke@fnatik.com', '2003-02-06', 'Finlandia'),
('Alfajer_Alfajor', 'Emir Ali', 'alfa@fnatik.com', '2005-06-10', 'Turquía'),
('Leo_Messi', 'Leo J.', 'leo@fnatik.com', '2003-12-12', 'Suecia'),
('Chronicle_Books', 'Timofey K.', 'chronicle@fnatik.com', '2002-08-16', 'Rusia'),
-- Opticos
('FormaLidad', 'Matthew P.', 'formal@opticos.com', '1995-05-20', 'EEUU'),
('Scump_Cump', 'Seth A.', 'scump@opticos.com', '1995-06-30', 'EEUU'),
('Shotzzy_Gun', 'Anthony C.', 'shotzzy@opticos.com', '2001-07-04', 'EEUU'),
('Pred_ator', 'Amer Z.', 'pred@opticos.com', '2001-10-10', 'Australia'),
('KennyS_Sniper', 'Kenny S.', 'kenny@opticos.com', '1995-05-19', 'Francia');

-- 10 Equipos.
INSERT INTO Equipos (Nombre_Equipo, Fecha_Creacion, ID_Capitan) Values
('Team Liquidos', '2020-01-15', 'PenS'),
('Face Clan', '2019-03-22', 'Bugha_Chueco'),
('Maloi', '2021-12-01', 'Ibai_Llanuras'),
('Krö', '2020-10-10', 'Aguero_San'),
('Nube9', '2015-05-05', 'Mang0_Biche'),
('Sentados', '2018-08-18', 'SicK_o'),
('G-Tres', '2016-02-28', 'Caps_ula'),
('Papel Rex', '2022-01-10', 'Jinggg_le'),
('FnatiK', '2011-11-11', 'Boaster_Toaster'),
('Opticos', '2017-07-07', 'FormaLidad');

-- Jugador_en_equipo, 5 por equipo,
INSERT INTO Jugador_en_equipo (Gamertag, Nombre_Equipo) VALUES
-- Team Liquidos (5 jugadores)
('PenS', 'Team Liquidos'),
('S1mpleton', 'Team Liquidos'),
('Moonral', 'Team Liquidos'),
('MergeSort', 'Team Liquidos'),
('El_Bicho', 'Team Liquidos'),
-- Face Clan (5 jugadores)
('Bugha_Chueco', 'Face Clan'),
('Niko_tina', 'Face Clan'),
('Twist_zz', 'Face Clan'),
('Karrigan_t', 'Face Clan'),
('Ropz_illa', 'Face Clan'),
-- Maloi (5 jugadores)
('Ibai_Llanuras', 'Maloi'),
('Mixwell_Hecho', 'Maloi'),
('Koldamenta', 'Maloi'),
('Trexx_T-Rex', 'Maloi'),
('Wolfen_stein', 'Maloi'),
-- Krö (5 jugadores)
('Aguero_San', 'Krö'),
('Keznit_deu', 'Krö'),
('Klaus_trofobia', 'Krö'),
('Mazino_ino', 'Krö'),
('Delz1k_o', 'Krö'),
-- Nube9 (5 jugadores)
('Mang0_Biche', 'Nube9'),
('Zellsis_bro', 'Nube9'),
('Xeppaa_a', 'Nube9'),
('OXY_gen', 'Nube9'),
('Vanity_Fair', 'Nube9'),
-- Sentados (5 jugadores)
('SicK_o', 'Sentados'),
('Zekken_N', 'Sentados'),
('Sacy_Salsa', 'Sentados'),
('Pancada_Fuerte', 'Sentados'),
('JohnQT_pie', 'Sentados'),
-- G-Tres (5 jugadores)
('Caps_ula', 'G-Tres'),
('M0NESY_Money', 'G-Tres'),
('NiKo_tina_2', 'G-Tres'),
('Hunter_Recolector', 'G-Tres'),
('HooXi_Dady', 'G-Tres'),
-- Papel Rex (5 jugadores)
('Jinggg_le', 'Papel Rex'),
('F0rsakeN_o', 'Papel Rex'),
('Mindfreak_out', 'Papel Rex'),
('D4v41_AI', 'Papel Rex'),
('Something_Else', 'Papel Rex'),
-- FnatiK (5 jugadores)
('Boaster_Toaster', 'FnatiK'),
('Derke_Dark', 'FnatiK'),
('Alfajer_Alfajor', 'FnatiK'),
('Leo_Messi', 'FnatiK'),
('Chronicle_Books', 'FnatiK'),
-- Opticos (5 jugadores)
('FormaLidad', 'Opticos'),
('Scump_Cump', 'Opticos'),
('Shotzzy_Gun', 'Opticos'),
('Pred_ator', 'Opticos'),
('KennyS_Sniper', 'Opticos');

-- Sponsors para cada torneo.
INSERT INTO Sponsor_Torneo (ID_Sponsor, ID_Torneo, Monto_Aporte) VALUES
(1, 1, 500000.00), (2, 1, 300000.00), (3, 1, 200000.00), -- sponsors para Calorant
(4, 2, 40000.00),  (5, 2, 10000.00),                     -- sponsors para MoW
(1, 3, 10000.00),  (6, 3, 10000.00);                     -- sponsors para GRA V

-- LLenada la Capacidad del Torneo 1 (8/8).
INSERT INTO Inscripciones (ID_Torneo, Nombre_Equipo) VALUES
(1, 'Team Liquidos'), (1, 'Face Clan'), (1, 'Maloi'), (1, 'Krö'),
(1, 'Nube9'), (1, 'Sentados'), (1, 'G-Tres'), (1, 'Papel Rex');

-- Agregamos algunos equipos a los otros torneos (para que no estén vacíos).
INSERT INTO Inscripciones (ID_Torneo, Nombre_Equipo) VALUES
(2, 'FnatiK'), (2, 'Opticos'), (2, 'Maloi'), (2, 'Team Liquidos'),
(3, 'Face Clan'), (3, 'Sentados');

-- Formato: 8 equipos en 2 grupos. 
INSERT INTO Partidas (ID_Torneo, Equipo_A, Equipo_B, Fecha_Hora, Score_A, Score_B, Fase) VALUES
-- GRUPO A (Round Robin)
(1, 'Team Liquidos', 'Face Clan', '2026-05-01 10:00:00', 13, 10, 'fase de grupos'),
(1, 'Maloi', 'Krö', '2026-05-01 12:00:00', 9, 13, 'fase de grupos'),
(1, 'Team Liquidos', 'Maloi', '2026-05-02 10:00:00', 13, 5, 'fase de grupos'),
(1, 'Face Clan', 'Krö', '2026-05-02 12:00:00', 13, 11, 'fase de grupos'),
(1, 'Team Liquidos', 'Krö', '2026-05-03 10:00:00', 13, 7, 'fase de grupos'),
(1, 'Face Clan', 'Maloi', '2026-05-03 12:00:00', 13, 8, 'fase de grupos'),
-- Avanzan Liquidos y Face Clan

-- GRUPO B (Round Robin)
(1, 'Nube9', 'Sentados', '2026-05-04 10:00:00', 10, 13, 'fase de grupos'),
(1, 'G-Tres', 'Papel Rex', '2026-05-04 12:00:00', 13, 9, 'fase de grupos'),
(1, 'Nube9', 'G-Tres', '2026-05-05 10:00:00', 13, 11, 'fase de grupos'),
(1, 'Sentados', 'Papel Rex', '2026-05-05 12:00:00', 13, 6, 'fase de grupos'),
(1, 'Nube9', 'Papel Rex', '2026-05-06 10:00:00', 13, 4, 'fase de grupos'),
(1, 'Sentados', 'G-Tres', '2026-05-06 12:00:00', 13, 11, 'fase de grupos'),
-- Avanzan Sentados y Nube9

-- SEMIFINALES
(1, 'Team Liquidos', 'Nube9', '2026-05-10 15:00:00', 13, 8, 'semifinal'),
(1, 'Sentados', 'Face Clan', '2026-05-11 15:00:00', 11, 13, 'semifinal'),

-- FINAL
(1, 'Team Liquidos', 'Face Clan', '2026-05-15 18:00:00', 13, 11, 'final');
 
-- Definimos las estadísticas de cada jugador en cada partida jugada en el torneo.
INSERT INTO Estadisticas_Jugador (ID_Partida, Gamertag, KOs, Restarts, Assists) VALUES

-- FASE DE GRUPOS - GRUPO A

-- Match 1 (Liquidos vs Face Clan)
(1, 'PenS', 25, 10, 5), (1, 'S1mpleton', 20, 12, 4), (1, 'Moonral', 15, 15, 8), (1, 'MergeSort', 12, 11, 10), (1, 'El_Bicho', 18, 14, 2),
(1, 'Bugha_Chueco', 18, 16, 6), (1, 'Niko_tina', 22, 17, 3), (1, 'Twist_zz', 14, 18, 5), (1, 'Karrigan_t', 9, 20, 12), (1, 'Ropz_illa', 16, 19, 4),

-- Match 2 (Maloi vs Krö)
(2, 'Ibai_Llanuras', 10, 18, 5), (2, 'Mixwell_Hecho', 15, 15, 6), (2, 'Koldamenta', 8, 20, 10), (2, 'Trexx_T-Rex', 20, 16, 2), (2, 'Wolfen_stein', 14, 17, 4),
(2, 'Aguero_San', 22, 12, 3), (2, 'Keznit_deu', 25, 10, 5), (2, 'Klaus_trofobia', 12, 14, 8), (2, 'Mazino_ino', 15, 15, 7), (2, 'Delz1k_o', 10, 16, 12),

-- Match 3 (Liquidos vs Maloi)
(3, 'PenS', 21, 12, 6), (3, 'S1mpleton', 19, 10, 5), (3, 'Moonral', 14, 14, 7), (3, 'MergeSort', 11, 12, 9), (3, 'El_Bicho', 17, 13, 3),
(3, 'Ibai_Llanuras', 12, 16, 4), (3, 'Mixwell_Hecho', 16, 14, 5), (3, 'Koldamenta', 9, 18, 8), (3, 'Trexx_T-Rex', 18, 15, 3), (3, 'Wolfen_stein', 13, 16, 5),

-- Match 4 (Face Clan vs Krö)
(4, 'Bugha_Chueco', 20, 15, 4), (4, 'Niko_tina', 23, 14, 5), (4, 'Twist_zz', 16, 16, 4), (4, 'Karrigan_t', 10, 18, 10), (4, 'Ropz_illa', 18, 16, 3),
(4, 'Aguero_San', 19, 14, 4), (4, 'Keznit_deu', 22, 13, 6), (4, 'Klaus_trofobia', 11, 16, 7), (4, 'Mazino_ino', 14, 15, 5), (4, 'Delz1k_o', 12, 17, 9),

-- Match 5 (Liquidos vs Krö)
(5, 'PenS', 24, 11, 5), (5, 'S1mpleton', 21, 12, 4), (5, 'Moonral', 16, 13, 8), (5, 'MergeSort', 13, 11, 11), (5, 'El_Bicho', 16, 14, 2),
(5, 'Aguero_San', 18, 15, 4), (5, 'Keznit_deu', 21, 14, 5), (5, 'Klaus_trofobia', 10, 17, 6), (5, 'Mazino_ino', 13, 16, 6), (5, 'Delz1k_o', 11, 18, 8),

-- Match 6 (Face Clan vs Maloi)
(6, 'Bugha_Chueco', 19, 12, 5), (6, 'Niko_tina', 24, 11, 4), (6, 'Twist_zz', 15, 14, 6), (6, 'Karrigan_t', 8, 17, 13), (6, 'Ropz_illa', 17, 13, 4),
(6, 'Ibai_Llanuras', 11, 17, 4), (6, 'Mixwell_Hecho', 14, 15, 5), (6, 'Koldamenta', 7, 19, 9), (6, 'Trexx_T-Rex', 19, 14, 2), (6, 'Wolfen_stein', 12, 16, 5),

-- FASE DE GRUPOS - GRUPO B

-- Match 7 (Nube9 vs Sentados)
(7, 'Mang0_Biche', 16, 15, 6), (7, 'Zellsis_bro', 19, 14, 4), (7, 'Xeppaa_a', 15, 16, 5), (7, 'OXY_gen', 22, 13, 3), (7, 'Vanity_Fair', 9, 18, 11),
(7, 'SicK_o', 21, 14, 4), (7, 'Zekken_N', 23, 12, 5), (7, 'Sacy_Salsa', 15, 15, 7), (7, 'Pancada_Fuerte', 13, 16, 9), (7, 'JohnQT_pie', 11, 17, 10),

-- Match 8 (G-Tres vs Papel Rex)
(8, 'Caps_ula', 18, 13, 5), (8, 'M0NESY_Money', 24, 11, 4), (8, 'NiKo_tina_2', 20, 14, 6), (8, 'Hunter_Recolector', 16, 15, 5), (8, 'HooXi_Dady', 8, 19, 12),
(8, 'Jinggg_le', 21, 15, 4), (8, 'F0rsakeN_o', 19, 16, 5), (8, 'Mindfreak_out', 12, 17, 8), (8, 'D4v41_AI', 14, 16, 7), (8, 'Something_Else', 17, 14, 3),

-- Match 9 (Nube9 vs G-Tres)
(9, 'Mang0_Biche', 18, 14, 5), (9, 'Zellsis_bro', 17, 15, 6), (9, 'Xeppaa_a', 14, 16, 4), (9, 'OXY_gen', 24, 12, 3), (9, 'Vanity_Fair', 10, 18, 10),
(9, 'Caps_ula', 17, 16, 4), (9, 'M0NESY_Money', 22, 14, 3), (9, 'NiKo_tina_2', 19, 15, 5), (9, 'Hunter_Recolector', 15, 17, 6), (9, 'HooXi_Dady', 9, 20, 11),

-- Match 10 (Sentados vs Papel Rex)
(10, 'SicK_o', 20, 12, 5), (10, 'Zekken_N', 25, 11, 4), (10, 'Sacy_Salsa', 16, 13, 8), (10, 'Pancada_Fuerte', 14, 14, 9), (10, 'JohnQT_pie', 12, 16, 11),
(10, 'Jinggg_le', 19, 16, 3), (10, 'F0rsakeN_o', 18, 17, 4), (10, 'Mindfreak_out', 11, 19, 7), (10, 'D4v41_AI', 13, 18, 6), (10, 'Something_Else', 15, 16, 5),

-- Match 11 (Nube9 vs Papel Rex)
(11, 'Mang0_Biche', 17, 12, 6), (11, 'Zellsis_bro', 20, 11, 5), (11, 'Xeppaa_a', 16, 13, 7), (11, 'OXY_gen', 25, 10, 4), (11, 'Vanity_Fair', 11, 15, 12),
(11, 'Jinggg_le', 18, 17, 4), (11, 'F0rsakeN_o', 16, 18, 3), (11, 'Mindfreak_out', 10, 20, 8), (11, 'D4v41_AI', 12, 19, 7), (11, 'Something_Else', 14, 18, 4),

-- Match 12 (Sentados vs G-Tres)
(12, 'SicK_o', 19, 15, 6), (12, 'Zekken_N', 22, 14, 5), (12, 'Sacy_Salsa', 15, 16, 7), (12, 'Pancada_Fuerte', 13, 17, 8), (12, 'JohnQT_pie', 10, 18, 12),
(12, 'Caps_ula', 16, 16, 4), (12, 'M0NESY_Money', 21, 15, 3), (12, 'NiKo_tina_2', 18, 17, 5), (12, 'Hunter_Recolector', 14, 18, 6), (12, 'HooXi_Dady', 7, 21, 10),

-- FASES ELIMINATORIAS (SEMIFINALES Y FINAL)

-- Match 13 (Semifinal 1: Liquidos vs Nube9)
(13, 'PenS', 28, 9, 4), (13, 'S1mpleton', 22, 11, 5), (13, 'Moonral', 16, 13, 9), (13, 'MergeSort', 10, 14, 15), (13, 'El_Bicho', 19, 12, 3),
(13, 'Mang0_Biche', 15, 18, 5), (13, 'Zellsis_bro', 18, 17, 4), (13, 'Xeppaa_a', 14, 19, 6), (13, 'OXY_gen', 21, 20, 2), (13, 'Vanity_Fair', 8, 21, 10),

-- Match 14 (Semifinal 2: Sentados vs Face Clan)
(14, 'SicK_o', 20, 15, 5), (14, 'Zekken_N', 24, 16, 4), (14, 'Sacy_Salsa', 14, 18, 8), (14, 'Pancada_Fuerte', 12, 17, 10), (14, 'JohnQT_pie', 10, 19, 12),
(14, 'Bugha_Chueco', 19, 14, 7), (14, 'Niko_tina', 25, 13, 4), (14, 'Twist_zz', 18, 15, 5), (14, 'Karrigan_t', 11, 20, 14), (14, 'Ropz_illa', 22, 18, 3),

-- Match 15 (Final: Liquidos vs Face Clan)
(15, 'PenS', 30, 12, 6), (15, 'S1mpleton', 24, 14, 5), (15, 'Moonral', 18, 16, 10), (15, 'MergeSort', 11, 15, 18), (15, 'El_Bicho', 22, 17, 4),
(15, 'Bugha_Chueco', 21, 19, 5), (15, 'Niko_tina', 28, 20, 3), (15, 'Twist_zz', 15, 21, 6), (15, 'Karrigan_t', 10, 24, 15), (15, 'Ropz_illa', 19, 21, 5);