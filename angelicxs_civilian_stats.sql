CREATE TABLE IF NOT EXISTS `angelicxs_civilian_stats` (
  `identifier` varchar(50) NOT NULL,
  `xp` int(11) DEFAULT 0,
  `level` int(11) DEFAULT 1,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
