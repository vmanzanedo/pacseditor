-- phpMyAdmin SQL Dump
-- version 4.6.6deb5ubuntu0.5
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 04-09-2023 a las 17:46:01
-- Versión del servidor: 5.7.42-0ubuntu0.18.04.1
-- Versión de PHP: 7.2.24-0ubuntu0.18.04.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `pacsdb`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ae`
--

CREATE TABLE `ae` (
  `pk` bigint(20) NOT NULL,
  `aet` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `hostname` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `port` int(11) NOT NULL,
  `cipher_suites` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `pat_id_issuer` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `acc_no_issuer` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `user_id` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `passwd` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `fs_group_id` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `ae_group` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `ae_desc` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `wado_url` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `station_name` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `institution` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `department` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `installed` bit(1) NOT NULL,
  `vendor_data` longblob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `audioxstudy`
--

CREATE TABLE `audioxstudy` (
  `audioxstudy_id` int(11) NOT NULL,
  `study_iuid` varchar(250) NOT NULL,
  `audioxstudy_nombre` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditaeliminacion`
--

CREATE TABLE `auditaeliminacion` (
  `auditaeliminacion_id` int(11) NOT NULL,
  `auditaeliminacion_iuid` varchar(250) NOT NULL,
  `auditaeliminacion_tipo` tinyint(1) NOT NULL COMMENT '=1 Estudio; =2 Serie; =3 Instancia',
  `auditaeliminacion_fecha` datetime NOT NULL,
  `auditaeliminacion_usuario` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `code`
--

CREATE TABLE `code` (
  `pk` bigint(20) NOT NULL,
  `code_value` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `code_designator` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `code_version` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `code_meaning` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `confirmado`
--

CREATE TABLE `confirmado` (
  `confirmado_id` int(11) NOT NULL,
  `study_iuid` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `content_item`
--

CREATE TABLE `content_item` (
  `pk` bigint(20) NOT NULL,
  `instance_fk` bigint(20) DEFAULT NULL,
  `name_fk` bigint(20) DEFAULT NULL,
  `code_fk` bigint(20) DEFAULT NULL,
  `rel_type` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `text_value` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `destino`
--

CREATE TABLE `destino` (
  `destino_id` int(11) NOT NULL,
  `destino_descripcion` varchar(45) NOT NULL,
  `destino_ip` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `device`
--

CREATE TABLE `device` (
  `pk` bigint(20) NOT NULL,
  `station_name` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `station_aet` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `modality` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `files`
--

CREATE TABLE `files` (
  `pk` bigint(20) NOT NULL,
  `instance_fk` bigint(20) DEFAULT NULL,
  `filesystem_fk` bigint(20) DEFAULT NULL,
  `filepath` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `file_tsuid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `file_md5` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `file_size` bigint(20) DEFAULT NULL,
  `file_status` int(11) DEFAULT NULL,
  `md5_check_time` datetime DEFAULT NULL,
  `created_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `filesystem`
--

CREATE TABLE `filesystem` (
  `pk` bigint(20) NOT NULL,
  `next_fk` bigint(20) DEFAULT NULL,
  `dirpath` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `fs_group_id` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `retrieve_aet` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `availability` int(11) NOT NULL,
  `fs_status` int(11) NOT NULL,
  `user_info` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gppps`
--

CREATE TABLE `gppps` (
  `pk` bigint(20) NOT NULL,
  `patient_fk` bigint(20) DEFAULT NULL,
  `pps_iuid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `pps_start` datetime DEFAULT NULL,
  `pps_status` int(11) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `updated_time` datetime DEFAULT NULL,
  `pps_attrs` longblob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gpsps`
--

CREATE TABLE `gpsps` (
  `pk` bigint(20) NOT NULL,
  `patient_fk` bigint(20) DEFAULT NULL,
  `code_fk` bigint(20) DEFAULT NULL,
  `gpsps_iuid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `gpsps_tuid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `start_datetime` datetime NOT NULL,
  `end_datetime` datetime DEFAULT NULL,
  `gpsps_status` int(11) DEFAULT NULL,
  `gpsps_prior` int(11) DEFAULT NULL,
  `in_availability` int(11) DEFAULT NULL,
  `item_attrs` longblob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gpsps_perf`
--

CREATE TABLE `gpsps_perf` (
  `pk` bigint(20) NOT NULL,
  `gpsps_fk` bigint(20) DEFAULT NULL,
  `code_fk` bigint(20) DEFAULT NULL,
  `human_perf_name` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `hum_perf_fn_sx` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `hum_perf_gn_sx` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `hum_perf_i_name` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `hum_perf_p_name` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gpsps_req`
--

CREATE TABLE `gpsps_req` (
  `pk` bigint(20) NOT NULL,
  `gpsps_fk` bigint(20) DEFAULT NULL,
  `req_proc_id` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `accession_no` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `hp`
--

CREATE TABLE `hp` (
  `pk` bigint(20) NOT NULL,
  `user_fk` bigint(20) DEFAULT NULL,
  `hp_iuid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `hp_cuid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `hp_name` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `hp_group` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `hp_level` int(11) DEFAULT NULL,
  `num_priors` int(11) DEFAULT NULL,
  `num_screens` int(11) DEFAULT NULL,
  `hp_attrs` longblob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `hpdef`
--

CREATE TABLE `hpdef` (
  `pk` bigint(20) NOT NULL,
  `hp_fk` bigint(20) DEFAULT NULL,
  `modality` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `laterality` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `informexstudy`
--

CREATE TABLE `informexstudy` (
  `informexstudy_id` int(11) NOT NULL,
  `informexstudy_texto` text NOT NULL,
  `study_iuid` varchar(250) NOT NULL,
  `usuario_nombre` varchar(15) DEFAULT NULL,
  `informexstudy_fecha` datetime DEFAULT NULL,
  `informexstudy_guardado` int(11) DEFAULT NULL,
  `informexstudy_generado` int(11) DEFAULT NULL,
  `informexstudy_prioridad` int(11) DEFAULT NULL,
  `informexstudy_nombre` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `instance`
--

CREATE TABLE `instance` (
  `pk` bigint(20) NOT NULL,
  `series_fk` bigint(20) DEFAULT NULL,
  `srcode_fk` bigint(20) DEFAULT NULL,
  `media_fk` bigint(20) DEFAULT NULL,
  `sop_iuid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `sop_cuid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `inst_no` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `content_datetime` datetime DEFAULT NULL,
  `sr_complete` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `sr_verified` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `inst_custom1` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `inst_custom2` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `inst_custom3` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `ext_retr_aet` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `retrieve_aets` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `availability` int(11) NOT NULL,
  `inst_status` int(11) NOT NULL,
  `all_attrs` bit(1) NOT NULL,
  `commitment` bit(1) NOT NULL,
  `archived` bit(1) NOT NULL,
  `updated_time` datetime DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `inst_attrs` longblob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `internado`
--

CREATE TABLE `internado` (
  `internado_id` int(11) NOT NULL,
  `study_fk` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `issuer`
--

CREATE TABLE `issuer` (
  `pk` bigint(20) NOT NULL,
  `entity_id` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `entity_uid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `entity_uid_type` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `JBM_COUNTER`
--

CREATE TABLE `JBM_COUNTER` (
  `NAME` varchar(255) NOT NULL,
  `NEXT_ID` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `JBM_DUAL`
--

CREATE TABLE `JBM_DUAL` (
  `DUMMY` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `JBM_ID_CACHE`
--

CREATE TABLE `JBM_ID_CACHE` (
  `NODE_ID` int(11) NOT NULL,
  `CNTR` int(11) NOT NULL,
  `JBM_ID` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `JBM_MSG`
--

CREATE TABLE `JBM_MSG` (
  `MESSAGE_ID` bigint(20) NOT NULL,
  `RELIABLE` char(1) DEFAULT NULL,
  `EXPIRATION` bigint(20) DEFAULT NULL,
  `TIMESTAMP` bigint(20) DEFAULT NULL,
  `PRIORITY` tinyint(4) DEFAULT NULL,
  `TYPE` tinyint(4) DEFAULT NULL,
  `HEADERS` mediumblob,
  `PAYLOAD` longblob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `JBM_MSG_REF`
--

CREATE TABLE `JBM_MSG_REF` (
  `MESSAGE_ID` bigint(20) NOT NULL,
  `CHANNEL_ID` bigint(20) NOT NULL,
  `TRANSACTION_ID` bigint(20) DEFAULT NULL,
  `STATE` char(1) DEFAULT NULL,
  `ORD` bigint(20) DEFAULT NULL,
  `PAGE_ORD` bigint(20) DEFAULT NULL,
  `DELIVERY_COUNT` int(11) DEFAULT NULL,
  `SCHED_DELIVERY` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `JBM_POSTOFFICE`
--

CREATE TABLE `JBM_POSTOFFICE` (
  `POSTOFFICE_NAME` varchar(255) NOT NULL,
  `NODE_ID` int(11) NOT NULL,
  `QUEUE_NAME` varchar(255) NOT NULL,
  `COND` varchar(1023) DEFAULT NULL,
  `SELECTOR` varchar(1023) DEFAULT NULL,
  `CHANNEL_ID` bigint(20) DEFAULT NULL,
  `CLUSTERED` char(1) DEFAULT NULL,
  `ALL_NODES` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `JBM_ROLE`
--

CREATE TABLE `JBM_ROLE` (
  `ROLE_ID` varchar(32) NOT NULL,
  `USER_ID` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `JBM_TX`
--

CREATE TABLE `JBM_TX` (
  `NODE_ID` int(11) DEFAULT NULL,
  `TRANSACTION_ID` bigint(20) NOT NULL,
  `BRANCH_QUAL` varbinary(254) DEFAULT NULL,
  `FORMAT_ID` int(11) DEFAULT NULL,
  `GLOBAL_TXID` varbinary(254) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `JBM_USER`
--

CREATE TABLE `JBM_USER` (
  `USER_ID` varchar(32) NOT NULL,
  `PASSWD` varchar(32) NOT NULL,
  `CLIENTID` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `media`
--

CREATE TABLE `media` (
  `pk` bigint(20) NOT NULL,
  `fileset_iuid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `fileset_id` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `media_rq_iuid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `media_status` int(11) NOT NULL,
  `media_status_info` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `media_usage` bigint(20) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `updated_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensaje`
--

CREATE TABLE `mensaje` (
  `mensaje_id` int(11) NOT NULL,
  `sucursal_key` varchar(45) NOT NULL,
  `pat_id` varchar(250) NOT NULL,
  `study_iuid` text NOT NULL,
  `mensaje_telefono` char(13) NOT NULL,
  `mensaje_fechahora` datetime NOT NULL,
  `mensaje_cerrado` tinyint(1) NOT NULL,
  `mensaje_fechahoracierre` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mpps`
--

CREATE TABLE `mpps` (
  `pk` bigint(20) NOT NULL,
  `patient_fk` bigint(20) DEFAULT NULL,
  `drcode_fk` bigint(20) DEFAULT NULL,
  `mpps_iuid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `pps_start` datetime DEFAULT NULL,
  `station_aet` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `modality` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `accession_no` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `mpps_status` int(11) NOT NULL,
  `updated_time` datetime DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `mpps_attrs` longblob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mwl_item`
--

CREATE TABLE `mwl_item` (
  `pk` bigint(20) NOT NULL,
  `patient_fk` bigint(20) DEFAULT NULL,
  `sps_status` int(11) DEFAULT NULL,
  `sps_id` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `start_datetime` datetime NOT NULL,
  `station_aet` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `station_name` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `modality` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `perf_physician` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `perf_phys_fn_sx` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `perf_phys_gn_sx` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `perf_phys_i_name` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `perf_phys_p_name` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `req_proc_id` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `accession_no` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `study_iuid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `updated_time` datetime DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `item_attrs` longblob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `oculto`
--

CREATE TABLE `oculto` (
  `oculto_id` int(11) NOT NULL,
  `study_iuid` varchar(250) NOT NULL,
  `oculto_fecha` datetime NOT NULL,
  `oculto_usurio` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ocultoinstance`
--

CREATE TABLE `ocultoinstance` (
  `ocultoinstance_id` int(11) NOT NULL,
  `sop_iuid` varchar(250) NOT NULL,
  `ocultoinstance_fecha` datetime NOT NULL,
  `ocultoinstance_usuario` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ocultoserie`
--

CREATE TABLE `ocultoserie` (
  `ocultoserie_id` int(11) NOT NULL,
  `series_iuid` varchar(250) NOT NULL,
  `ocultoserie_fecha` datetime NOT NULL,
  `ocultoserie_usuario` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `other_pid`
--

CREATE TABLE `other_pid` (
  `pk` bigint(20) NOT NULL,
  `pat_id` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `pat_id_issuer` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pacientedatos`
--

CREATE TABLE `pacientedatos` (
  `pacientedatos_id` int(11) NOT NULL,
  `pat_id` varchar(250) NOT NULL,
  `telefono` char(12) NOT NULL,
  `fechainicio` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `patient`
--

CREATE TABLE `patient` (
  `pk` bigint(20) NOT NULL,
  `merge_fk` bigint(20) DEFAULT NULL,
  `pat_id` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `pat_id_issuer` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `pat_name` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `pat_fn_sx` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `pat_gn_sx` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `pat_i_name` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `pat_p_name` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `pat_birthdate` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `pat_sex` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `pat_custom1` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `pat_custom2` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `pat_custom3` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `updated_time` datetime DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `pat_attrs` longblob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `priv_file`
--

CREATE TABLE `priv_file` (
  `pk` bigint(20) NOT NULL,
  `instance_fk` bigint(20) DEFAULT NULL,
  `filesystem_fk` bigint(20) DEFAULT NULL,
  `filepath` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `file_tsuid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `file_md5` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `file_size` bigint(20) DEFAULT NULL,
  `file_status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `priv_instance`
--

CREATE TABLE `priv_instance` (
  `pk` bigint(20) NOT NULL,
  `series_fk` bigint(20) DEFAULT NULL,
  `priv_type` int(11) NOT NULL,
  `sop_iuid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `inst_attrs` longblob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `priv_patient`
--

CREATE TABLE `priv_patient` (
  `pk` bigint(20) NOT NULL,
  `priv_type` int(11) NOT NULL,
  `pat_id` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `pat_id_issuer` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `pat_name` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `pat_attrs` longblob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `priv_series`
--

CREATE TABLE `priv_series` (
  `pk` bigint(20) NOT NULL,
  `study_fk` bigint(20) DEFAULT NULL,
  `priv_type` int(11) NOT NULL,
  `series_iuid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `src_aet` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `series_attrs` longblob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `priv_study`
--

CREATE TABLE `priv_study` (
  `pk` bigint(20) NOT NULL,
  `patient_fk` bigint(20) DEFAULT NULL,
  `priv_type` int(11) NOT NULL,
  `study_iuid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `accession_no` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `study_attrs` longblob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `published_study`
--

CREATE TABLE `published_study` (
  `pk` bigint(20) NOT NULL,
  `study_fk` bigint(20) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `updated_time` datetime DEFAULT NULL,
  `doc_uid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `docentry_uid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `repository_uid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rel_dev_proto`
--

CREATE TABLE `rel_dev_proto` (
  `device_fk` bigint(20) DEFAULT NULL,
  `prcode_fk` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rel_gpsps_appcode`
--

CREATE TABLE `rel_gpsps_appcode` (
  `gpsps_fk` bigint(20) DEFAULT NULL,
  `appcode_fk` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rel_gpsps_devclass`
--

CREATE TABLE `rel_gpsps_devclass` (
  `gpsps_fk` bigint(20) DEFAULT NULL,
  `devclass_fk` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rel_gpsps_devloc`
--

CREATE TABLE `rel_gpsps_devloc` (
  `gpsps_fk` bigint(20) DEFAULT NULL,
  `devloc_fk` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rel_gpsps_devname`
--

CREATE TABLE `rel_gpsps_devname` (
  `gpsps_fk` bigint(20) DEFAULT NULL,
  `devname_fk` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rel_gpsps_gppps`
--

CREATE TABLE `rel_gpsps_gppps` (
  `gpsps_fk` bigint(20) DEFAULT NULL,
  `gppps_fk` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rel_hpdef_proc`
--

CREATE TABLE `rel_hpdef_proc` (
  `hpdef_fk` bigint(20) DEFAULT NULL,
  `proc_fk` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rel_hpdef_reason`
--

CREATE TABLE `rel_hpdef_reason` (
  `hpdef_fk` bigint(20) DEFAULT NULL,
  `reason_fk` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rel_hpdef_region`
--

CREATE TABLE `rel_hpdef_region` (
  `hpdef_fk` bigint(20) DEFAULT NULL,
  `region_fk` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rel_pat_other_pid`
--

CREATE TABLE `rel_pat_other_pid` (
  `patient_fk` bigint(20) DEFAULT NULL,
  `other_pid_fk` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rel_study_pcode`
--

CREATE TABLE `rel_study_pcode` (
  `study_fk` bigint(20) DEFAULT NULL,
  `pcode_fk` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rel_ups_appcode`
--

CREATE TABLE `rel_ups_appcode` (
  `ups_fk` bigint(20) DEFAULT NULL,
  `appcode_fk` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rel_ups_devclass`
--

CREATE TABLE `rel_ups_devclass` (
  `ups_fk` bigint(20) DEFAULT NULL,
  `devclass_fk` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rel_ups_devloc`
--

CREATE TABLE `rel_ups_devloc` (
  `ups_fk` bigint(20) DEFAULT NULL,
  `devloc_fk` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rel_ups_devname`
--

CREATE TABLE `rel_ups_devname` (
  `ups_fk` bigint(20) DEFAULT NULL,
  `devname_fk` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rel_ups_performer`
--

CREATE TABLE `rel_ups_performer` (
  `ups_fk` bigint(20) DEFAULT NULL,
  `performer_fk` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `user_id` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `roles` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `series`
--

CREATE TABLE `series` (
  `pk` bigint(20) NOT NULL,
  `study_fk` bigint(20) DEFAULT NULL,
  `mpps_fk` bigint(20) DEFAULT NULL,
  `inst_code_fk` bigint(20) DEFAULT NULL,
  `series_iuid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `series_no` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `modality` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `body_part` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `laterality` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `series_desc` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `institution` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `station_name` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `department` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `perf_physician` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `perf_phys_fn_sx` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `perf_phys_gn_sx` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `perf_phys_i_name` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `perf_phys_p_name` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `pps_start` datetime DEFAULT NULL,
  `pps_iuid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `series_custom1` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `series_custom2` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `series_custom3` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `num_instances` int(11) DEFAULT NULL,
  `src_aet` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `ext_retr_aet` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `retrieve_aets` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `fileset_iuid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `fileset_id` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `availability` int(11) NOT NULL,
  `series_status` int(11) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `updated_time` datetime DEFAULT NULL,
  `series_attrs` longblob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `series_req`
--

CREATE TABLE `series_req` (
  `pk` bigint(20) NOT NULL,
  `series_fk` bigint(20) DEFAULT NULL,
  `accno_issuer_fk` bigint(20) DEFAULT NULL,
  `accession_no` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `study_iuid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `req_proc_id` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `sps_id` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `req_service` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `req_physician` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `req_phys_fn_sx` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `req_phys_gn_sx` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `req_phys_i_name` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `req_phys_p_name` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `study`
--

CREATE TABLE `study` (
  `pk` bigint(20) NOT NULL,
  `patient_fk` bigint(20) DEFAULT NULL,
  `accno_issuer_fk` bigint(20) DEFAULT NULL,
  `study_iuid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `study_id` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `study_datetime` datetime DEFAULT NULL,
  `accession_no` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `ref_physician` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `ref_phys_fn_sx` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `ref_phys_gn_sx` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `ref_phys_i_name` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `ref_phys_p_name` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `study_desc` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `study_custom1` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `study_custom2` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `study_custom3` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `study_status_id` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `mods_in_study` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `cuids_in_study` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `num_series` int(11) NOT NULL,
  `num_instances` int(11) NOT NULL,
  `ext_retr_aet` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `retrieve_aets` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `fileset_iuid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `fileset_id` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `availability` int(11) NOT NULL,
  `study_status` int(11) NOT NULL,
  `checked_time` datetime DEFAULT NULL,
  `updated_time` datetime DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `study_attrs` longblob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `studyxusuario`
--

CREATE TABLE `studyxusuario` (
  `studyxusuario_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `study_iuid` varchar(250) NOT NULL,
  `accession_no` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `study_on_fs`
--

CREATE TABLE `study_on_fs` (
  `pk` bigint(20) NOT NULL,
  `study_fk` bigint(20) DEFAULT NULL,
  `filesystem_fk` bigint(20) DEFAULT NULL,
  `access_time` datetime NOT NULL,
  `mark_to_delete` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `study_permission`
--

CREATE TABLE `study_permission` (
  `pk` bigint(20) NOT NULL,
  `study_iuid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `action` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `roles` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiempopromedio`
--

CREATE TABLE `tiempopromedio` (
  `tiempopromedio_id` int(11) NOT NULL,
  `tiempopromedio_fecha` date NOT NULL,
  `tiempopromedio_promedio` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `TIMERS`
--

CREATE TABLE `TIMERS` (
  `TIMERID` varchar(80) NOT NULL,
  `TARGETID` varchar(250) NOT NULL,
  `INITIALDATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `TIMERINTERVAL` bigint(20) DEFAULT NULL,
  `INSTANCEPK` longblob,
  `INFO` longblob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ups`
--

CREATE TABLE `ups` (
  `pk` bigint(20) NOT NULL,
  `patient_fk` bigint(20) DEFAULT NULL,
  `code_fk` bigint(20) DEFAULT NULL,
  `ups_iuid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `ups_tuid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `adm_id` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `adm_id_issuer_id` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `adm_id_issuer_uid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `ups_label` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `uwl_label` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `ups_start_time` datetime NOT NULL,
  `ups_compl_time` datetime DEFAULT NULL,
  `ups_state` int(11) DEFAULT NULL,
  `ups_prior` int(11) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `updated_time` datetime DEFAULT NULL,
  `ups_attrs` longblob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ups_glob_subscr`
--

CREATE TABLE `ups_glob_subscr` (
  `pk` bigint(20) NOT NULL,
  `aet` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `deletion_lock` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ups_rel_ps`
--

CREATE TABLE `ups_rel_ps` (
  `pk` bigint(20) NOT NULL,
  `ups_fk` bigint(20) DEFAULT NULL,
  `sop_iuid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `sop_cuid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ups_repl_ps`
--

CREATE TABLE `ups_repl_ps` (
  `pk` bigint(20) NOT NULL,
  `ups_fk` bigint(20) DEFAULT NULL,
  `sop_iuid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `sop_cuid` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ups_req`
--

CREATE TABLE `ups_req` (
  `pk` bigint(20) NOT NULL,
  `ups_fk` bigint(20) DEFAULT NULL,
  `req_proc_id` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `accession_no` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `confidentiality` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `req_service` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ups_subscr`
--

CREATE TABLE `ups_subscr` (
  `pk` bigint(20) NOT NULL,
  `ups_fk` bigint(20) DEFAULT NULL,
  `aet` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `deletion_lock` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `user_id` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `passwd` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarioxdestino`
--

CREATE TABLE `usuarioxdestino` (
  `usuarioxdestino_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `destino_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarioxstudy`
--

CREATE TABLE `usuarioxstudy` (
  `usuarioxstudy_id` int(11) NOT NULL,
  `usuario_user` varchar(250) NOT NULL,
  `study_iuid` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `verify_observer`
--

CREATE TABLE `verify_observer` (
  `pk` bigint(20) NOT NULL,
  `instance_fk` bigint(20) DEFAULT NULL,
  `verify_datetime` datetime DEFAULT NULL,
  `observer_name` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `observer_fn_sx` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `observer_gn_sx` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `observer_i_name` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `observer_p_name` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ae`
--
ALTER TABLE `ae`
  ADD PRIMARY KEY (`pk`),
  ADD UNIQUE KEY `aet` (`aet`(64)),
  ADD KEY `hostname` (`hostname`(16)),
  ADD KEY `ae_group` (`ae_group`);

--
-- Indices de la tabla `audioxstudy`
--
ALTER TABLE `audioxstudy`
  ADD PRIMARY KEY (`audioxstudy_id`);

--
-- Indices de la tabla `auditaeliminacion`
--
ALTER TABLE `auditaeliminacion`
  ADD PRIMARY KEY (`auditaeliminacion_id`);

--
-- Indices de la tabla `code`
--
ALTER TABLE `code`
  ADD PRIMARY KEY (`pk`),
  ADD UNIQUE KEY `code_value` (`code_value`(64),`code_designator`(64),`code_version`(64));

--
-- Indices de la tabla `confirmado`
--
ALTER TABLE `confirmado`
  ADD PRIMARY KEY (`confirmado_id`);

--
-- Indices de la tabla `content_item`
--
ALTER TABLE `content_item`
  ADD PRIMARY KEY (`pk`),
  ADD KEY `content_item_inst_fk` (`instance_fk`),
  ADD KEY `content_item_name_fk` (`name_fk`),
  ADD KEY `content_item_code_fk` (`code_fk`),
  ADD KEY `content_item_rel_type` (`rel_type`(16)),
  ADD KEY `content_item_text_value` (`text_value`(64));

--
-- Indices de la tabla `destino`
--
ALTER TABLE `destino`
  ADD PRIMARY KEY (`destino_id`);

--
-- Indices de la tabla `device`
--
ALTER TABLE `device`
  ADD PRIMARY KEY (`pk`),
  ADD UNIQUE KEY `dev_station_name` (`station_name`(16));

--
-- Indices de la tabla `files`
--
ALTER TABLE `files`
  ADD PRIMARY KEY (`pk`),
  ADD KEY `instance_fk` (`instance_fk`),
  ADD KEY `filesystem_fk` (`filesystem_fk`),
  ADD KEY `file_tsuid` (`file_tsuid`(64)),
  ADD KEY `md5_check_time` (`md5_check_time`),
  ADD KEY `file_created` (`created_time`),
  ADD KEY `file_status` (`file_status`),
  ADD KEY `filepath` (`filepath`);

--
-- Indices de la tabla `filesystem`
--
ALTER TABLE `filesystem`
  ADD PRIMARY KEY (`pk`),
  ADD UNIQUE KEY `fs_dirpath` (`dirpath`(64)),
  ADD KEY `fs_next_fk` (`next_fk`),
  ADD KEY `fs_group_id` (`fs_group_id`(16)),
  ADD KEY `fs_retrieve_aet` (`retrieve_aet`(16)),
  ADD KEY `fs_availability` (`availability`),
  ADD KEY `fs_status` (`fs_status`);

--
-- Indices de la tabla `gppps`
--
ALTER TABLE `gppps`
  ADD PRIMARY KEY (`pk`),
  ADD UNIQUE KEY `gppps_iuid` (`pps_iuid`),
  ADD KEY `gppps_patient_fk` (`patient_fk`),
  ADD KEY `gppps_pps_start` (`pps_start`);

--
-- Indices de la tabla `gpsps`
--
ALTER TABLE `gpsps`
  ADD PRIMARY KEY (`pk`),
  ADD UNIQUE KEY `gpsps_iuid` (`gpsps_iuid`(64)),
  ADD KEY `gpsps_patient_fk` (`patient_fk`),
  ADD KEY `gpsps_code_fk` (`code_fk`),
  ADD KEY `gpsps_tuid` (`gpsps_tuid`(64)),
  ADD KEY `gpsps_start_time` (`start_datetime`),
  ADD KEY `gpsps_end_time` (`end_datetime`),
  ADD KEY `gpsps_status` (`gpsps_status`),
  ADD KEY `gpsps_prior` (`gpsps_prior`),
  ADD KEY `in_availability` (`in_availability`);

--
-- Indices de la tabla `gpsps_perf`
--
ALTER TABLE `gpsps_perf`
  ADD PRIMARY KEY (`pk`),
  ADD KEY `gpsps_perf_sps_fk` (`gpsps_fk`),
  ADD KEY `gpsps_perf_code_fk` (`code_fk`),
  ADD KEY `gpsps_perf_name` (`human_perf_name`(64)),
  ADD KEY `gpsps_perf_fn_sx` (`hum_perf_fn_sx`(16)),
  ADD KEY `gpsps_perf_gn_sx` (`hum_perf_gn_sx`(16)),
  ADD KEY `gpsps_perf_i_name` (`hum_perf_i_name`(64)),
  ADD KEY `gpsps_perf_p_name` (`hum_perf_p_name`(64));

--
-- Indices de la tabla `gpsps_req`
--
ALTER TABLE `gpsps_req`
  ADD PRIMARY KEY (`pk`),
  ADD KEY `gpsps_req_gpsps_fk` (`gpsps_fk`),
  ADD KEY `gpsps_req_proc_id` (`req_proc_id`),
  ADD KEY `gpsps_req_acc_no` (`accession_no`);

--
-- Indices de la tabla `hp`
--
ALTER TABLE `hp`
  ADD PRIMARY KEY (`pk`),
  ADD UNIQUE KEY `hp_iuid` (`hp_iuid`(64)),
  ADD KEY `hp_user_fk` (`user_fk`),
  ADD KEY `hp_cuid` (`hp_cuid`(64)),
  ADD KEY `hp_name` (`hp_name`(64)),
  ADD KEY `hp_level` (`hp_level`),
  ADD KEY `num_priors` (`num_priors`),
  ADD KEY `num_screens` (`num_screens`);

--
-- Indices de la tabla `hpdef`
--
ALTER TABLE `hpdef`
  ADD PRIMARY KEY (`pk`),
  ADD KEY `hp_fk` (`hp_fk`),
  ADD KEY `hpdef_modality` (`modality`(16)),
  ADD KEY `hpdef_laterality` (`laterality`(16));

--
-- Indices de la tabla `informexstudy`
--
ALTER TABLE `informexstudy`
  ADD PRIMARY KEY (`informexstudy_id`);

--
-- Indices de la tabla `instance`
--
ALTER TABLE `instance`
  ADD PRIMARY KEY (`pk`),
  ADD UNIQUE KEY `sop_iuid` (`sop_iuid`(64)),
  ADD KEY `series_fk` (`series_fk`),
  ADD KEY `srcode_fk` (`srcode_fk`),
  ADD KEY `media_fk` (`media_fk`),
  ADD KEY `sop_cuid` (`sop_cuid`(64)),
  ADD KEY `inst_no` (`inst_no`(16)),
  ADD KEY `content_datetime` (`content_datetime`),
  ADD KEY `sr_complete` (`sr_complete`(16)),
  ADD KEY `sr_verified` (`sr_verified`(16)),
  ADD KEY `inst_custom1` (`inst_custom1`(64)),
  ADD KEY `inst_custom2` (`inst_custom2`(64)),
  ADD KEY `inst_custom3` (`inst_custom3`(64)),
  ADD KEY `ext_retr_aet` (`ext_retr_aet`(16)),
  ADD KEY `commitment` (`commitment`),
  ADD KEY `inst_status` (`inst_status`),
  ADD KEY `inst_created` (`created_time`),
  ADD KEY `inst_archived` (`archived`);

--
-- Indices de la tabla `internado`
--
ALTER TABLE `internado`
  ADD PRIMARY KEY (`internado_id`);

--
-- Indices de la tabla `issuer`
--
ALTER TABLE `issuer`
  ADD PRIMARY KEY (`pk`),
  ADD UNIQUE KEY `entity_id` (`entity_id`(64)),
  ADD UNIQUE KEY `entity_uid` (`entity_uid`(64),`entity_uid_type`(64));

--
-- Indices de la tabla `JBM_COUNTER`
--
ALTER TABLE `JBM_COUNTER`
  ADD PRIMARY KEY (`NAME`);

--
-- Indices de la tabla `JBM_DUAL`
--
ALTER TABLE `JBM_DUAL`
  ADD PRIMARY KEY (`DUMMY`);

--
-- Indices de la tabla `JBM_ID_CACHE`
--
ALTER TABLE `JBM_ID_CACHE`
  ADD PRIMARY KEY (`NODE_ID`,`CNTR`);

--
-- Indices de la tabla `JBM_MSG`
--
ALTER TABLE `JBM_MSG`
  ADD PRIMARY KEY (`MESSAGE_ID`);

--
-- Indices de la tabla `JBM_MSG_REF`
--
ALTER TABLE `JBM_MSG_REF`
  ADD PRIMARY KEY (`MESSAGE_ID`,`CHANNEL_ID`),
  ADD KEY `JBM_MSG_REF_TX` (`TRANSACTION_ID`,`STATE`);

--
-- Indices de la tabla `JBM_POSTOFFICE`
--
ALTER TABLE `JBM_POSTOFFICE`
  ADD PRIMARY KEY (`POSTOFFICE_NAME`,`NODE_ID`,`QUEUE_NAME`);

--
-- Indices de la tabla `JBM_ROLE`
--
ALTER TABLE `JBM_ROLE`
  ADD PRIMARY KEY (`USER_ID`,`ROLE_ID`);

--
-- Indices de la tabla `JBM_TX`
--
ALTER TABLE `JBM_TX`
  ADD PRIMARY KEY (`TRANSACTION_ID`);

--
-- Indices de la tabla `JBM_USER`
--
ALTER TABLE `JBM_USER`
  ADD PRIMARY KEY (`USER_ID`);

--
-- Indices de la tabla `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`pk`),
  ADD UNIQUE KEY `fileset_iuid` (`fileset_iuid`),
  ADD KEY `media_status` (`media_status`);

--
-- Indices de la tabla `mensaje`
--
ALTER TABLE `mensaje`
  ADD PRIMARY KEY (`mensaje_id`);

--
-- Indices de la tabla `mpps`
--
ALTER TABLE `mpps`
  ADD PRIMARY KEY (`pk`),
  ADD UNIQUE KEY `mpps_iuid` (`mpps_iuid`),
  ADD KEY `mpps_patient_fk` (`patient_fk`),
  ADD KEY `mpps_drcode_fk` (`drcode_fk`),
  ADD KEY `mpps_pps_start` (`pps_start`),
  ADD KEY `mpps_station_aet` (`station_aet`(16)),
  ADD KEY `mpps_modality` (`modality`(16)),
  ADD KEY `mpps_accession_no` (`accession_no`(16));

--
-- Indices de la tabla `mwl_item`
--
ALTER TABLE `mwl_item`
  ADD PRIMARY KEY (`pk`),
  ADD UNIQUE KEY `mwl_sps_id` (`sps_id`(16),`req_proc_id`(16)),
  ADD KEY `mwl_patient_fk` (`patient_fk`),
  ADD KEY `sps_status` (`sps_status`),
  ADD KEY `mwl_start_time` (`start_datetime`),
  ADD KEY `mwl_station_aet` (`station_aet`(16)),
  ADD KEY `mwl_station_name` (`station_name`(16)),
  ADD KEY `mwl_modality` (`modality`(16)),
  ADD KEY `mwl_perf_physician` (`perf_physician`(64)),
  ADD KEY `mwl_perf_phys_fn_sx` (`perf_phys_fn_sx`(16)),
  ADD KEY `mwl_perf_phys_gn_sx` (`perf_phys_gn_sx`(16)),
  ADD KEY `mwl_perf_phys_i_nm` (`perf_phys_i_name`(64)),
  ADD KEY `mwl_perf_phys_p_nm` (`perf_phys_p_name`(64)),
  ADD KEY `mwl_req_proc_id` (`req_proc_id`(16)),
  ADD KEY `mwl_accession_no` (`accession_no`(16)),
  ADD KEY `mwl_study_iuid` (`study_iuid`(64));

--
-- Indices de la tabla `oculto`
--
ALTER TABLE `oculto`
  ADD PRIMARY KEY (`oculto_id`);

--
-- Indices de la tabla `ocultoinstance`
--
ALTER TABLE `ocultoinstance`
  ADD PRIMARY KEY (`ocultoinstance_id`);

--
-- Indices de la tabla `ocultoserie`
--
ALTER TABLE `ocultoserie`
  ADD PRIMARY KEY (`ocultoserie_id`);

--
-- Indices de la tabla `other_pid`
--
ALTER TABLE `other_pid`
  ADD PRIMARY KEY (`pk`),
  ADD UNIQUE KEY `other_pat_id` (`pat_id`(64),`pat_id_issuer`(64));

--
-- Indices de la tabla `pacientedatos`
--
ALTER TABLE `pacientedatos`
  ADD PRIMARY KEY (`pacientedatos_id`);

--
-- Indices de la tabla `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`pk`),
  ADD KEY `pat_merge_fk` (`merge_fk`),
  ADD KEY `pat_id` (`pat_id`(64),`pat_id_issuer`(64)),
  ADD KEY `pat_name` (`pat_name`(64)),
  ADD KEY `pat_fn_sx` (`pat_fn_sx`(16)),
  ADD KEY `pat_gn_sx` (`pat_gn_sx`(16)),
  ADD KEY `pat_i_name` (`pat_i_name`(64)),
  ADD KEY `pat_p_name` (`pat_p_name`(64)),
  ADD KEY `pat_birthdate` (`pat_birthdate`(8)),
  ADD KEY `pat_sex` (`pat_sex`(1)),
  ADD KEY `pat_custom1` (`pat_custom1`(64)),
  ADD KEY `pat_custom2` (`pat_custom2`(64)),
  ADD KEY `pat_custom3` (`pat_custom3`(64));

--
-- Indices de la tabla `priv_file`
--
ALTER TABLE `priv_file`
  ADD PRIMARY KEY (`pk`),
  ADD KEY `priv_instance_fk` (`instance_fk`),
  ADD KEY `priv_fs_fk` (`filesystem_fk`);

--
-- Indices de la tabla `priv_instance`
--
ALTER TABLE `priv_instance`
  ADD PRIMARY KEY (`pk`),
  ADD KEY `priv_series_fk` (`series_fk`),
  ADD KEY `priv_inst_type` (`priv_type`),
  ADD KEY `priv_sop_iuid` (`sop_iuid`(64)),
  ADD KEY `priv_inst_created` (`created_time`);

--
-- Indices de la tabla `priv_patient`
--
ALTER TABLE `priv_patient`
  ADD PRIMARY KEY (`pk`),
  ADD KEY `priv_pat_id` (`pat_id`,`pat_id_issuer`(64)),
  ADD KEY `priv_pat_name` (`pat_name`(64)),
  ADD KEY `priv_pat_type` (`priv_type`);

--
-- Indices de la tabla `priv_series`
--
ALTER TABLE `priv_series`
  ADD PRIMARY KEY (`pk`),
  ADD KEY `priv_study_fk` (`study_fk`),
  ADD KEY `priv_series_type` (`priv_type`),
  ADD KEY `priv_series_iuid` (`series_iuid`(64)),
  ADD KEY `priv_ser_src_aet` (`src_aet`(16));

--
-- Indices de la tabla `priv_study`
--
ALTER TABLE `priv_study`
  ADD PRIMARY KEY (`pk`),
  ADD KEY `priv_patient_fk` (`patient_fk`),
  ADD KEY `priv_study_type` (`priv_type`),
  ADD KEY `priv_study_iuid` (`study_iuid`(64)),
  ADD KEY `priv_study_accs_no` (`accession_no`(16));

--
-- Indices de la tabla `published_study`
--
ALTER TABLE `published_study`
  ADD PRIMARY KEY (`pk`),
  ADD KEY `published_study` (`study_fk`),
  ADD KEY `published_study_status` (`status`),
  ADD KEY `repository_uid` (`repository_uid`);

--
-- Indices de la tabla `rel_dev_proto`
--
ALTER TABLE `rel_dev_proto`
  ADD KEY `device_fk` (`device_fk`),
  ADD KEY `prcode_fk` (`prcode_fk`);

--
-- Indices de la tabla `rel_gpsps_appcode`
--
ALTER TABLE `rel_gpsps_appcode`
  ADD KEY `appcode_gpsps_fk` (`gpsps_fk`),
  ADD KEY `gpsps_appcode_fk` (`appcode_fk`);

--
-- Indices de la tabla `rel_gpsps_devclass`
--
ALTER TABLE `rel_gpsps_devclass`
  ADD KEY `devclass_gpsps_fk` (`gpsps_fk`),
  ADD KEY `gpsps_devclass_fk` (`devclass_fk`);

--
-- Indices de la tabla `rel_gpsps_devloc`
--
ALTER TABLE `rel_gpsps_devloc`
  ADD KEY `devloc_gpsps_fk` (`gpsps_fk`),
  ADD KEY `gpsps_devloc_fk` (`devloc_fk`);

--
-- Indices de la tabla `rel_gpsps_devname`
--
ALTER TABLE `rel_gpsps_devname`
  ADD KEY `devname_gpsps_fk` (`gpsps_fk`),
  ADD KEY `gpsps_devname_fk` (`devname_fk`);

--
-- Indices de la tabla `rel_gpsps_gppps`
--
ALTER TABLE `rel_gpsps_gppps`
  ADD KEY `gppps_gpsps_fk` (`gpsps_fk`),
  ADD KEY `gpsps_gppps_fk` (`gppps_fk`);

--
-- Indices de la tabla `rel_hpdef_proc`
--
ALTER TABLE `rel_hpdef_proc`
  ADD KEY `proc_hpdef_fk` (`hpdef_fk`),
  ADD KEY `hpdef_proc_fk` (`proc_fk`);

--
-- Indices de la tabla `rel_hpdef_reason`
--
ALTER TABLE `rel_hpdef_reason`
  ADD KEY `reason_hpdef_fk` (`hpdef_fk`),
  ADD KEY `hpdef_reason_fk` (`reason_fk`);

--
-- Indices de la tabla `rel_hpdef_region`
--
ALTER TABLE `rel_hpdef_region`
  ADD KEY `region_hpdef_fk` (`hpdef_fk`),
  ADD KEY `hpdef_region_fk` (`region_fk`);

--
-- Indices de la tabla `rel_pat_other_pid`
--
ALTER TABLE `rel_pat_other_pid`
  ADD KEY `other_pid_pat_fk` (`patient_fk`),
  ADD KEY `pat_other_pid_fk` (`other_pid_fk`);

--
-- Indices de la tabla `rel_study_pcode`
--
ALTER TABLE `rel_study_pcode`
  ADD KEY `pcode_study_fk` (`study_fk`),
  ADD KEY `study_pcode_fk` (`pcode_fk`);

--
-- Indices de la tabla `rel_ups_appcode`
--
ALTER TABLE `rel_ups_appcode`
  ADD KEY `appcode_ups_fk` (`ups_fk`),
  ADD KEY `ups_appcode_fk` (`appcode_fk`);

--
-- Indices de la tabla `rel_ups_devclass`
--
ALTER TABLE `rel_ups_devclass`
  ADD KEY `devclass_ups_fk` (`ups_fk`),
  ADD KEY `ups_devclass_fk` (`devclass_fk`);

--
-- Indices de la tabla `rel_ups_devloc`
--
ALTER TABLE `rel_ups_devloc`
  ADD KEY `devloc_ups_fk` (`ups_fk`),
  ADD KEY `ups_devloc_fk` (`devloc_fk`);

--
-- Indices de la tabla `rel_ups_devname`
--
ALTER TABLE `rel_ups_devname`
  ADD KEY `devname_ups_fk` (`ups_fk`),
  ADD KEY `ups_devname_fk` (`devname_fk`);

--
-- Indices de la tabla `rel_ups_performer`
--
ALTER TABLE `rel_ups_performer`
  ADD KEY `performer_ups_fk` (`ups_fk`),
  ADD KEY `ups_performer_fk` (`performer_fk`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD KEY `roles_user_id` (`user_id`);

--
-- Indices de la tabla `series`
--
ALTER TABLE `series`
  ADD PRIMARY KEY (`pk`),
  ADD UNIQUE KEY `series_iuid` (`series_iuid`(64)),
  ADD KEY `study_fk` (`study_fk`),
  ADD KEY `series_mpps_fk` (`mpps_fk`),
  ADD KEY `series_inst_code_fk` (`inst_code_fk`),
  ADD KEY `series_no` (`series_no`(16)),
  ADD KEY `modality` (`modality`(16)),
  ADD KEY `body_part` (`body_part`(16)),
  ADD KEY `laterality` (`laterality`(16)),
  ADD KEY `series_desc` (`series_desc`(64)),
  ADD KEY `institution` (`institution`(64)),
  ADD KEY `station_name` (`station_name`(16)),
  ADD KEY `department` (`department`(64)),
  ADD KEY `perf_physician` (`perf_physician`(64)),
  ADD KEY `perf_phys_fn_sx` (`perf_phys_fn_sx`(16)),
  ADD KEY `perf_phys_gn_sx` (`perf_phys_gn_sx`(16)),
  ADD KEY `perf_phys_i_name` (`perf_phys_i_name`(64)),
  ADD KEY `perf_phys_p_name` (`perf_phys_p_name`(64)),
  ADD KEY `series_pps_start` (`pps_start`),
  ADD KEY `series_pps_iuid` (`pps_iuid`(64)),
  ADD KEY `series_custom1` (`series_custom1`(64)),
  ADD KEY `series_custom2` (`series_custom2`(64)),
  ADD KEY `series_custom3` (`series_custom3`(64)),
  ADD KEY `series_src_aet` (`src_aet`(64)),
  ADD KEY `series_status` (`series_status`),
  ADD KEY `series_created` (`created_time`),
  ADD KEY `series_updated` (`updated_time`);

--
-- Indices de la tabla `series_req`
--
ALTER TABLE `series_req`
  ADD PRIMARY KEY (`pk`),
  ADD KEY `ser_req_series_fk` (`series_fk`),
  ADD KEY `ser_req_accno_issuer_fk` (`accno_issuer_fk`),
  ADD KEY `ser_req_accession_no` (`accession_no`(16)),
  ADD KEY `ser_req_study_iuid` (`study_iuid`(64)),
  ADD KEY `ser_req_proc_id` (`req_proc_id`(16)),
  ADD KEY `ser_req_sps_id` (`sps_id`(16)),
  ADD KEY `ser_req_service` (`req_service`(64)),
  ADD KEY `ser_req_phys` (`req_physician`(64)),
  ADD KEY `ser_req_phys_fn_sx` (`req_phys_fn_sx`(16)),
  ADD KEY `ser_req_phys_gn_sx` (`req_phys_gn_sx`(16)),
  ADD KEY `ser_req_phys_i` (`req_phys_i_name`(64)),
  ADD KEY `ser_req_phys_p` (`req_phys_p_name`(64));

--
-- Indices de la tabla `study`
--
ALTER TABLE `study`
  ADD PRIMARY KEY (`pk`),
  ADD UNIQUE KEY `study_iuid` (`study_iuid`(64)),
  ADD KEY `patient_fk` (`patient_fk`),
  ADD KEY `accno_issuer_fk` (`accno_issuer_fk`),
  ADD KEY `study_id` (`study_id`(64)),
  ADD KEY `study_datetime` (`study_datetime`),
  ADD KEY `accession_no` (`accession_no`(16)),
  ADD KEY `ref_physician` (`ref_physician`(64)),
  ADD KEY `ref_phys_fn_sx` (`ref_phys_fn_sx`(16)),
  ADD KEY `ref_phys_gn_sx` (`ref_phys_gn_sx`(16)),
  ADD KEY `ref_phys_i_name` (`ref_phys_i_name`(64)),
  ADD KEY `ref_phys_p_name` (`ref_phys_p_name`(64)),
  ADD KEY `study_desc` (`study_desc`(64)),
  ADD KEY `study_custom1` (`study_custom1`(64)),
  ADD KEY `study_custom2` (`study_custom2`(64)),
  ADD KEY `study_custom3` (`study_custom3`(64)),
  ADD KEY `study_status_id` (`study_status_id`(16)),
  ADD KEY `study_checked` (`checked_time`),
  ADD KEY `study_created` (`created_time`),
  ADD KEY `study_updated` (`updated_time`),
  ADD KEY `study_status` (`study_status`);

--
-- Indices de la tabla `study_on_fs`
--
ALTER TABLE `study_on_fs`
  ADD PRIMARY KEY (`pk`),
  ADD UNIQUE KEY `i_study_on_fs` (`study_fk`,`filesystem_fk`),
  ADD KEY `fs_of_study` (`filesystem_fk`),
  ADD KEY `access_time` (`access_time`),
  ADD KEY `mark_to_delete` (`mark_to_delete`);

--
-- Indices de la tabla `study_permission`
--
ALTER TABLE `study_permission`
  ADD PRIMARY KEY (`pk`),
  ADD UNIQUE KEY `study_perm_idx` (`study_iuid`(64),`action`(1),`roles`(16));

--
-- Indices de la tabla `tiempopromedio`
--
ALTER TABLE `tiempopromedio`
  ADD PRIMARY KEY (`tiempopromedio_id`);

--
-- Indices de la tabla `TIMERS`
--
ALTER TABLE `TIMERS`
  ADD PRIMARY KEY (`TIMERID`,`TARGETID`);

--
-- Indices de la tabla `ups`
--
ALTER TABLE `ups`
  ADD PRIMARY KEY (`pk`),
  ADD UNIQUE KEY `ups_iuid` (`ups_iuid`),
  ADD KEY `ups_patient_fk` (`patient_fk`),
  ADD KEY `ups_code_fk` (`code_fk`),
  ADD KEY `ups_tuid` (`ups_tuid`),
  ADD KEY `ups_adm_id` (`adm_id`),
  ADD KEY `ups_adm_id_issuer_id` (`adm_id_issuer_id`),
  ADD KEY `ups_adm_id_issuer_uid` (`adm_id_issuer_uid`),
  ADD KEY `ups_label` (`ups_label`),
  ADD KEY `uwl_label` (`uwl_label`),
  ADD KEY `ups_start_time` (`ups_start_time`),
  ADD KEY `ups_compl_time` (`ups_compl_time`),
  ADD KEY `ups_state` (`ups_state`),
  ADD KEY `ups_prior` (`ups_prior`),
  ADD KEY `ups_updated_time` (`updated_time`);

--
-- Indices de la tabla `ups_glob_subscr`
--
ALTER TABLE `ups_glob_subscr`
  ADD PRIMARY KEY (`pk`),
  ADD UNIQUE KEY `ups_glob_subscr_aet` (`aet`);

--
-- Indices de la tabla `ups_rel_ps`
--
ALTER TABLE `ups_rel_ps`
  ADD PRIMARY KEY (`pk`),
  ADD KEY `ups_rel_ps_ups_fk` (`ups_fk`),
  ADD KEY `ups_rel_ps_iuid` (`sop_iuid`),
  ADD KEY `ups_rel_ps_cuid` (`sop_cuid`);

--
-- Indices de la tabla `ups_repl_ps`
--
ALTER TABLE `ups_repl_ps`
  ADD PRIMARY KEY (`pk`),
  ADD KEY `ups_repl_ps_ups_fk` (`ups_fk`),
  ADD KEY `ups_repl_ps_iuid` (`sop_iuid`),
  ADD KEY `ups_repl_ps_cuid` (`sop_cuid`);

--
-- Indices de la tabla `ups_req`
--
ALTER TABLE `ups_req`
  ADD PRIMARY KEY (`pk`),
  ADD KEY `ups_req_ups_fk` (`ups_fk`),
  ADD KEY `ups_req_proc_id` (`req_proc_id`),
  ADD KEY `ups_req_acc_no` (`accession_no`),
  ADD KEY `ups_confidentiality` (`confidentiality`),
  ADD KEY `ups_req_service` (`req_service`);

--
-- Indices de la tabla `ups_subscr`
--
ALTER TABLE `ups_subscr`
  ADD PRIMARY KEY (`pk`),
  ADD KEY `ups_subscr_ups_fk` (`ups_fk`),
  ADD KEY `ups_deletion_lock` (`deletion_lock`),
  ADD KEY `ups_subscr_aet` (`aet`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- Indices de la tabla `usuarioxdestino`
--
ALTER TABLE `usuarioxdestino`
  ADD PRIMARY KEY (`usuarioxdestino_id`);

--
-- Indices de la tabla `usuarioxstudy`
--
ALTER TABLE `usuarioxstudy`
  ADD PRIMARY KEY (`usuarioxstudy_id`);

--
-- Indices de la tabla `verify_observer`
--
ALTER TABLE `verify_observer`
  ADD PRIMARY KEY (`pk`),
  ADD KEY `observer_inst_fk` (`instance_fk`),
  ADD KEY `verify_datetime` (`verify_datetime`),
  ADD KEY `observer_name` (`observer_name`(64)),
  ADD KEY `observer_fn_sx` (`observer_fn_sx`(16)),
  ADD KEY `observer_gn_sx` (`observer_gn_sx`(16)),
  ADD KEY `observer_i_name` (`observer_i_name`(64)),
  ADD KEY `observer_p_name` (`observer_p_name`(64));

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ae`
--
ALTER TABLE `ae`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `audioxstudy`
--
ALTER TABLE `audioxstudy`
  MODIFY `audioxstudy_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `auditaeliminacion`
--
ALTER TABLE `auditaeliminacion`
  MODIFY `auditaeliminacion_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `code`
--
ALTER TABLE `code`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `confirmado`
--
ALTER TABLE `confirmado`
  MODIFY `confirmado_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `content_item`
--
ALTER TABLE `content_item`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `destino`
--
ALTER TABLE `destino`
  MODIFY `destino_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `device`
--
ALTER TABLE `device`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `files`
--
ALTER TABLE `files`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=383;
--
-- AUTO_INCREMENT de la tabla `filesystem`
--
ALTER TABLE `filesystem`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `gppps`
--
ALTER TABLE `gppps`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `gpsps`
--
ALTER TABLE `gpsps`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `gpsps_perf`
--
ALTER TABLE `gpsps_perf`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `gpsps_req`
--
ALTER TABLE `gpsps_req`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `hp`
--
ALTER TABLE `hp`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `hpdef`
--
ALTER TABLE `hpdef`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `informexstudy`
--
ALTER TABLE `informexstudy`
  MODIFY `informexstudy_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT de la tabla `instance`
--
ALTER TABLE `instance`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=383;
--
-- AUTO_INCREMENT de la tabla `internado`
--
ALTER TABLE `internado`
  MODIFY `internado_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT de la tabla `issuer`
--
ALTER TABLE `issuer`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `media`
--
ALTER TABLE `media`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `mensaje`
--
ALTER TABLE `mensaje`
  MODIFY `mensaje_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;
--
-- AUTO_INCREMENT de la tabla `mpps`
--
ALTER TABLE `mpps`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `mwl_item`
--
ALTER TABLE `mwl_item`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `oculto`
--
ALTER TABLE `oculto`
  MODIFY `oculto_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `ocultoinstance`
--
ALTER TABLE `ocultoinstance`
  MODIFY `ocultoinstance_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `ocultoserie`
--
ALTER TABLE `ocultoserie`
  MODIFY `ocultoserie_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `other_pid`
--
ALTER TABLE `other_pid`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `pacientedatos`
--
ALTER TABLE `pacientedatos`
  MODIFY `pacientedatos_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `patient`
--
ALTER TABLE `patient`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `priv_file`
--
ALTER TABLE `priv_file`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `priv_instance`
--
ALTER TABLE `priv_instance`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `priv_patient`
--
ALTER TABLE `priv_patient`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `priv_series`
--
ALTER TABLE `priv_series`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `priv_study`
--
ALTER TABLE `priv_study`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `published_study`
--
ALTER TABLE `published_study`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `series`
--
ALTER TABLE `series`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT de la tabla `series_req`
--
ALTER TABLE `series_req`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `study`
--
ALTER TABLE `study`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `study_on_fs`
--
ALTER TABLE `study_on_fs`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `study_permission`
--
ALTER TABLE `study_permission`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `tiempopromedio`
--
ALTER TABLE `tiempopromedio`
  MODIFY `tiempopromedio_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `ups`
--
ALTER TABLE `ups`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `ups_glob_subscr`
--
ALTER TABLE `ups_glob_subscr`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `ups_rel_ps`
--
ALTER TABLE `ups_rel_ps`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `ups_repl_ps`
--
ALTER TABLE `ups_repl_ps`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `ups_req`
--
ALTER TABLE `ups_req`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `ups_subscr`
--
ALTER TABLE `ups_subscr`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `usuarioxdestino`
--
ALTER TABLE `usuarioxdestino`
  MODIFY `usuarioxdestino_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `usuarioxstudy`
--
ALTER TABLE `usuarioxstudy`
  MODIFY `usuarioxstudy_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT de la tabla `verify_observer`
--
ALTER TABLE `verify_observer`
  MODIFY `pk` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `content_item`
--
ALTER TABLE `content_item`
  ADD CONSTRAINT `content_item_code_fk` FOREIGN KEY (`code_fk`) REFERENCES `code` (`pk`),
  ADD CONSTRAINT `content_item_inst_fk` FOREIGN KEY (`instance_fk`) REFERENCES `instance` (`pk`),
  ADD CONSTRAINT `content_item_name_fk` FOREIGN KEY (`name_fk`) REFERENCES `code` (`pk`);

--
-- Filtros para la tabla `files`
--
ALTER TABLE `files`
  ADD CONSTRAINT `filesystem_fk` FOREIGN KEY (`filesystem_fk`) REFERENCES `filesystem` (`pk`),
  ADD CONSTRAINT `instance_fk` FOREIGN KEY (`instance_fk`) REFERENCES `instance` (`pk`);

--
-- Filtros para la tabla `filesystem`
--
ALTER TABLE `filesystem`
  ADD CONSTRAINT `fs_next_fk` FOREIGN KEY (`next_fk`) REFERENCES `filesystem` (`pk`);

--
-- Filtros para la tabla `gppps`
--
ALTER TABLE `gppps`
  ADD CONSTRAINT `gppps_patient_fk` FOREIGN KEY (`patient_fk`) REFERENCES `patient` (`pk`);

--
-- Filtros para la tabla `gpsps`
--
ALTER TABLE `gpsps`
  ADD CONSTRAINT `gpsps_code_fk` FOREIGN KEY (`code_fk`) REFERENCES `code` (`pk`),
  ADD CONSTRAINT `gpsps_patient_fk` FOREIGN KEY (`patient_fk`) REFERENCES `patient` (`pk`);

--
-- Filtros para la tabla `gpsps_perf`
--
ALTER TABLE `gpsps_perf`
  ADD CONSTRAINT `gpsps_perf_code_fk` FOREIGN KEY (`code_fk`) REFERENCES `code` (`pk`),
  ADD CONSTRAINT `gpsps_perf_sps_fk` FOREIGN KEY (`gpsps_fk`) REFERENCES `gpsps` (`pk`);

--
-- Filtros para la tabla `gpsps_req`
--
ALTER TABLE `gpsps_req`
  ADD CONSTRAINT `gpsps_req_gpsps_fk` FOREIGN KEY (`gpsps_fk`) REFERENCES `gpsps` (`pk`);

--
-- Filtros para la tabla `hp`
--
ALTER TABLE `hp`
  ADD CONSTRAINT `hp_user_fk` FOREIGN KEY (`user_fk`) REFERENCES `code` (`pk`);

--
-- Filtros para la tabla `hpdef`
--
ALTER TABLE `hpdef`
  ADD CONSTRAINT `hp_fk` FOREIGN KEY (`hp_fk`) REFERENCES `hp` (`pk`);

--
-- Filtros para la tabla `instance`
--
ALTER TABLE `instance`
  ADD CONSTRAINT `media_fk` FOREIGN KEY (`media_fk`) REFERENCES `media` (`pk`),
  ADD CONSTRAINT `series_fk` FOREIGN KEY (`series_fk`) REFERENCES `series` (`pk`),
  ADD CONSTRAINT `srcode_fk` FOREIGN KEY (`srcode_fk`) REFERENCES `code` (`pk`);

--
-- Filtros para la tabla `mpps`
--
ALTER TABLE `mpps`
  ADD CONSTRAINT `mpps_drcode_fk` FOREIGN KEY (`drcode_fk`) REFERENCES `code` (`pk`),
  ADD CONSTRAINT `mpps_patient_fk` FOREIGN KEY (`patient_fk`) REFERENCES `patient` (`pk`);

--
-- Filtros para la tabla `mwl_item`
--
ALTER TABLE `mwl_item`
  ADD CONSTRAINT `mwl_patient_fk` FOREIGN KEY (`patient_fk`) REFERENCES `patient` (`pk`);

--
-- Filtros para la tabla `patient`
--
ALTER TABLE `patient`
  ADD CONSTRAINT `pat_merge_fk` FOREIGN KEY (`merge_fk`) REFERENCES `patient` (`pk`);

--
-- Filtros para la tabla `priv_file`
--
ALTER TABLE `priv_file`
  ADD CONSTRAINT `priv_fs_fk` FOREIGN KEY (`filesystem_fk`) REFERENCES `filesystem` (`pk`),
  ADD CONSTRAINT `priv_instance_fk` FOREIGN KEY (`instance_fk`) REFERENCES `priv_instance` (`pk`);

--
-- Filtros para la tabla `priv_instance`
--
ALTER TABLE `priv_instance`
  ADD CONSTRAINT `priv_series_fk` FOREIGN KEY (`series_fk`) REFERENCES `priv_series` (`pk`);

--
-- Filtros para la tabla `priv_series`
--
ALTER TABLE `priv_series`
  ADD CONSTRAINT `priv_study_fk` FOREIGN KEY (`study_fk`) REFERENCES `priv_study` (`pk`);

--
-- Filtros para la tabla `priv_study`
--
ALTER TABLE `priv_study`
  ADD CONSTRAINT `priv_patient_fk` FOREIGN KEY (`patient_fk`) REFERENCES `priv_patient` (`pk`);

--
-- Filtros para la tabla `published_study`
--
ALTER TABLE `published_study`
  ADD CONSTRAINT `published_study_ibfk_1` FOREIGN KEY (`study_fk`) REFERENCES `study` (`pk`);

--
-- Filtros para la tabla `rel_dev_proto`
--
ALTER TABLE `rel_dev_proto`
  ADD CONSTRAINT `device_fk` FOREIGN KEY (`device_fk`) REFERENCES `device` (`pk`),
  ADD CONSTRAINT `prcode_fk` FOREIGN KEY (`prcode_fk`) REFERENCES `code` (`pk`);

--
-- Filtros para la tabla `rel_gpsps_appcode`
--
ALTER TABLE `rel_gpsps_appcode`
  ADD CONSTRAINT `appcode_gpsps_fk` FOREIGN KEY (`gpsps_fk`) REFERENCES `gpsps` (`pk`),
  ADD CONSTRAINT `gpsps_appcode_fk` FOREIGN KEY (`appcode_fk`) REFERENCES `code` (`pk`);

--
-- Filtros para la tabla `rel_gpsps_devclass`
--
ALTER TABLE `rel_gpsps_devclass`
  ADD CONSTRAINT `devclass_gpsps_fk` FOREIGN KEY (`gpsps_fk`) REFERENCES `gpsps` (`pk`),
  ADD CONSTRAINT `gpsps_devclass_fk` FOREIGN KEY (`devclass_fk`) REFERENCES `code` (`pk`);

--
-- Filtros para la tabla `rel_gpsps_devloc`
--
ALTER TABLE `rel_gpsps_devloc`
  ADD CONSTRAINT `devloc_gpsps_fk` FOREIGN KEY (`gpsps_fk`) REFERENCES `gpsps` (`pk`),
  ADD CONSTRAINT `gpsps_devloc_fk` FOREIGN KEY (`devloc_fk`) REFERENCES `code` (`pk`);

--
-- Filtros para la tabla `rel_gpsps_devname`
--
ALTER TABLE `rel_gpsps_devname`
  ADD CONSTRAINT `devname_gpsps_fk` FOREIGN KEY (`gpsps_fk`) REFERENCES `gpsps` (`pk`),
  ADD CONSTRAINT `gpsps_devname_fk` FOREIGN KEY (`devname_fk`) REFERENCES `code` (`pk`);

--
-- Filtros para la tabla `rel_gpsps_gppps`
--
ALTER TABLE `rel_gpsps_gppps`
  ADD CONSTRAINT `gppps_gpsps_fk` FOREIGN KEY (`gpsps_fk`) REFERENCES `gpsps` (`pk`),
  ADD CONSTRAINT `gpsps_gppps_fk` FOREIGN KEY (`gppps_fk`) REFERENCES `gppps` (`pk`);

--
-- Filtros para la tabla `rel_hpdef_proc`
--
ALTER TABLE `rel_hpdef_proc`
  ADD CONSTRAINT `hpdef_proc_fk` FOREIGN KEY (`proc_fk`) REFERENCES `code` (`pk`),
  ADD CONSTRAINT `proc_hpdef_fk` FOREIGN KEY (`hpdef_fk`) REFERENCES `hpdef` (`pk`);

--
-- Filtros para la tabla `rel_hpdef_reason`
--
ALTER TABLE `rel_hpdef_reason`
  ADD CONSTRAINT `hpdef_reason_fk` FOREIGN KEY (`reason_fk`) REFERENCES `code` (`pk`),
  ADD CONSTRAINT `reason_hpdef_fk` FOREIGN KEY (`hpdef_fk`) REFERENCES `hpdef` (`pk`);

--
-- Filtros para la tabla `rel_hpdef_region`
--
ALTER TABLE `rel_hpdef_region`
  ADD CONSTRAINT `hpdef_region_fk` FOREIGN KEY (`region_fk`) REFERENCES `code` (`pk`),
  ADD CONSTRAINT `region_hpdef_fk` FOREIGN KEY (`hpdef_fk`) REFERENCES `hpdef` (`pk`);

--
-- Filtros para la tabla `rel_pat_other_pid`
--
ALTER TABLE `rel_pat_other_pid`
  ADD CONSTRAINT `other_pid_pat_fk` FOREIGN KEY (`patient_fk`) REFERENCES `patient` (`pk`),
  ADD CONSTRAINT `pat_other_pid_fk` FOREIGN KEY (`other_pid_fk`) REFERENCES `other_pid` (`pk`);

--
-- Filtros para la tabla `rel_study_pcode`
--
ALTER TABLE `rel_study_pcode`
  ADD CONSTRAINT `pcode_study_fk` FOREIGN KEY (`study_fk`) REFERENCES `study` (`pk`),
  ADD CONSTRAINT `study_pcode_fk` FOREIGN KEY (`pcode_fk`) REFERENCES `code` (`pk`);

--
-- Filtros para la tabla `rel_ups_appcode`
--
ALTER TABLE `rel_ups_appcode`
  ADD CONSTRAINT `appcode_ups_fk` FOREIGN KEY (`ups_fk`) REFERENCES `ups` (`pk`),
  ADD CONSTRAINT `ups_appcode_fk` FOREIGN KEY (`appcode_fk`) REFERENCES `code` (`pk`);

--
-- Filtros para la tabla `rel_ups_devclass`
--
ALTER TABLE `rel_ups_devclass`
  ADD CONSTRAINT `devclass_ups_fk` FOREIGN KEY (`ups_fk`) REFERENCES `ups` (`pk`),
  ADD CONSTRAINT `ups_devclass_fk` FOREIGN KEY (`devclass_fk`) REFERENCES `code` (`pk`);

--
-- Filtros para la tabla `rel_ups_devloc`
--
ALTER TABLE `rel_ups_devloc`
  ADD CONSTRAINT `devloc_ups_fk` FOREIGN KEY (`ups_fk`) REFERENCES `ups` (`pk`),
  ADD CONSTRAINT `ups_devloc_fk` FOREIGN KEY (`devloc_fk`) REFERENCES `code` (`pk`);

--
-- Filtros para la tabla `rel_ups_devname`
--
ALTER TABLE `rel_ups_devname`
  ADD CONSTRAINT `devname_ups_fk` FOREIGN KEY (`ups_fk`) REFERENCES `ups` (`pk`),
  ADD CONSTRAINT `ups_devname_fk` FOREIGN KEY (`devname_fk`) REFERENCES `code` (`pk`);

--
-- Filtros para la tabla `rel_ups_performer`
--
ALTER TABLE `rel_ups_performer`
  ADD CONSTRAINT `performer_ups_fk` FOREIGN KEY (`ups_fk`) REFERENCES `ups` (`pk`),
  ADD CONSTRAINT `ups_performer_fk` FOREIGN KEY (`performer_fk`) REFERENCES `code` (`pk`);

--
-- Filtros para la tabla `roles`
--
ALTER TABLE `roles`
  ADD CONSTRAINT `roles_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Filtros para la tabla `series`
--
ALTER TABLE `series`
  ADD CONSTRAINT `series_inst_code_fk` FOREIGN KEY (`inst_code_fk`) REFERENCES `code` (`pk`),
  ADD CONSTRAINT `series_mpps_fk` FOREIGN KEY (`mpps_fk`) REFERENCES `mpps` (`pk`),
  ADD CONSTRAINT `study_fk` FOREIGN KEY (`study_fk`) REFERENCES `study` (`pk`);

--
-- Filtros para la tabla `series_req`
--
ALTER TABLE `series_req`
  ADD CONSTRAINT `ser_req_accno_issuer_fk` FOREIGN KEY (`accno_issuer_fk`) REFERENCES `issuer` (`pk`),
  ADD CONSTRAINT `ser_req_series_fk` FOREIGN KEY (`series_fk`) REFERENCES `series` (`pk`);

--
-- Filtros para la tabla `study`
--
ALTER TABLE `study`
  ADD CONSTRAINT `accno_issuer_fk` FOREIGN KEY (`accno_issuer_fk`) REFERENCES `issuer` (`pk`),
  ADD CONSTRAINT `patient_fk` FOREIGN KEY (`patient_fk`) REFERENCES `patient` (`pk`);

--
-- Filtros para la tabla `study_on_fs`
--
ALTER TABLE `study_on_fs`
  ADD CONSTRAINT `fs_of_study` FOREIGN KEY (`filesystem_fk`) REFERENCES `filesystem` (`pk`),
  ADD CONSTRAINT `i_study_on_fs` FOREIGN KEY (`study_fk`) REFERENCES `study` (`pk`);

--
-- Filtros para la tabla `ups`
--
ALTER TABLE `ups`
  ADD CONSTRAINT `ups_code_fk` FOREIGN KEY (`code_fk`) REFERENCES `code` (`pk`),
  ADD CONSTRAINT `ups_patient_fk` FOREIGN KEY (`patient_fk`) REFERENCES `patient` (`pk`);

--
-- Filtros para la tabla `ups_rel_ps`
--
ALTER TABLE `ups_rel_ps`
  ADD CONSTRAINT `ups_rel_ps_ups_fk` FOREIGN KEY (`ups_fk`) REFERENCES `ups` (`pk`);

--
-- Filtros para la tabla `ups_repl_ps`
--
ALTER TABLE `ups_repl_ps`
  ADD CONSTRAINT `ups_repl_ps_ups_fk` FOREIGN KEY (`ups_fk`) REFERENCES `ups` (`pk`);

--
-- Filtros para la tabla `ups_req`
--
ALTER TABLE `ups_req`
  ADD CONSTRAINT `ups_req_ups_fk` FOREIGN KEY (`ups_fk`) REFERENCES `ups` (`pk`);

--
-- Filtros para la tabla `ups_subscr`
--
ALTER TABLE `ups_subscr`
  ADD CONSTRAINT `ups_subscr_ups_fk` FOREIGN KEY (`ups_fk`) REFERENCES `ups` (`pk`);

--
-- Filtros para la tabla `verify_observer`
--
ALTER TABLE `verify_observer`
  ADD CONSTRAINT `observer_inst_fk` FOREIGN KEY (`instance_fk`) REFERENCES `instance` (`pk`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
