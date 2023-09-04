<?php
shell_exec("sh /opt/dcm4chee-2.18.1-mysql/bin/twiddle.sh -s localhost -u admin -p Agsrvc2ls82 invoke 'dcm4chee.web:service=ContentEditService' moveStudyToTrash $_REQUEST[study_iuid] true");
