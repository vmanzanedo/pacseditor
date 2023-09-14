<?php
error_reporting(E_ALL);
ini_set('display_errors', '1');

require_once('class_dicom.php');


$file = "/opt/dcm4chee-2.18.1-mysql/server/default/archive/2023/8/25/15/3221D873/25C108C7/1E2BB335";

$d = new dicom_tag($file);
//$d->load_tags();

//print_r($d->tags);

echo "Patient Comments: ";
print_r($d->get_tag('0010', '4000'));

echo "<br>";

echo "Study Comments: ";
print_r($d->get_tag('0032', '4000'));


//$name = $d->get_tag('0010', '0010');
//print "Name: $name\n";
