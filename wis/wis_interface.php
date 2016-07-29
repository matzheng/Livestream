<?php
require '../conf.php';
require 'wis.php';
$api = new WisApi($accessId,$accessKey);

$method = $_REQUEST['method'];
if($method == "AllowDraw"){
	echo json_encode(array("Flag"=>100));
	exit();
}

$rst = $api->$method($_REQUEST);

echo json_encode($rst);
?>