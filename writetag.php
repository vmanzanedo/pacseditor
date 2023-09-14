<?php
error_reporting(E_ALL);
ini_set('display_errors', '1');

#
# Write DICOM tags . $new_tags is an array of tags to be written
#
require_once('./class_dicom.php');

$d = new dicom_tag;
$d->file ="/opt/dcm4chee-2.18.1-mysql/server/default/archive/2023/8/15/19/DB6D4722/CCE17ADC/9A92FA5E";

$new_tags = array(
  '0010,0010' => 'SALAS^ELIAS MOD',
  //'0008,0080' => 'DEANLAND, AR'
);


$result = $d->write_tags($new_tags);

if($result) {
  print "$result\n";
}
else {
  system("./get_tags.php " . $d->file);
}

?>
