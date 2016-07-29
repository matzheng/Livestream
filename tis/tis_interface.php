<?php
require '../conf.php';
$accessId = ADConf::AccessId;
$accessKey = ADConf::AccessKey;
require 'tis.php';
$api = new TisApi($accessId,$accessKey);
$method = $_REQUEST['method'];

$rst = $api->$method($_REQUEST,$tisId);
echo json_encode($rst);
?>