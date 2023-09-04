<?php
require_once '../modelo/pacs.php';
$pacs = new Pacs();

shell_exec("sh /opt/dcm4chee-2.18.1-mysql/bin/twiddle.sh -s localhost -u admin -p Agsrvc2ls82 invoke 'dcm4chee.web:service=ContentEditService' moveInstanceToTrash $_REQUEST[sop_iuid] true");
$pacs->AuditaEliminacion($_REQUEST['sop_iuid'],3);