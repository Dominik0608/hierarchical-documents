-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1:3307
-- Létrehozás ideje: 2021. Okt 10. 14:21
-- Kiszolgáló verziója: 10.4.13-MariaDB
-- PHP verzió: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `nexum`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `parent` mediumint(9) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `categories`
--

INSERT INTO `categories` (`id`, `name`, `parent`) VALUES
(1, 'Autók', NULL),
(2, 'Kombi', 1),
(3, 'Terepjáró', 1),
(4, 'Ingatlanok', NULL),
(5, 'Cabrio', 1),
(6, 'Családi ház', 4);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `documents`
--

DROP TABLE IF EXISTS `documents`;
CREATE TABLE IF NOT EXISTS `documents` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `filename` varchar(128) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `user` mediumint(9) NOT NULL,
  `category` mediumint(9) NOT NULL,
  `hash` varchar(64) COLLATE utf8mb4_hungarian_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `documents`
--

INSERT INTO `documents` (`id`, `filename`, `user`, `category`, `hash`) VALUES
(5, 'sample.pdf', 1, 3, '0df84dfb3164bc984d9c422b05503776821aa5b459c3993d112c9ea759c706a0');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `password` varchar(100) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_hungarian_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `users`
--

INSERT INTO `users` (`id`, `name`, `password`, `remember_token`) VALUES
(1, 'test', '$2y$10$UOO5hbLVrCZsztvnWOFcqO.4njMCVVbRR9IOzXnQL81ukFkOmVIPm', 'yaFJYgkXDdn3uSWlvZ1YwsP2mUDiuHNiRXa1U73H9XnlChIV18q4BVVG14UT');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user_permissions`
--

DROP TABLE IF EXISTS `user_permissions`;
CREATE TABLE IF NOT EXISTS `user_permissions` (
  `userid` mediumint(9) NOT NULL,
  `category` mediumint(9) NOT NULL,
  PRIMARY KEY (`userid`,`category`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `user_permissions`
--

INSERT INTO `user_permissions` (`userid`, `category`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
