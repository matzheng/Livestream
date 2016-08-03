<?php
if(empty($_FILES['doc'])){
	echo '<script type="text/javascript">window.parent.loadDocList("未选择文件")</script>';
	exit;
}
/*
if(strpos($_FILES['pic']['type'], 'ppt') === false){
	
}*/
$size = $_FILES['doc']['size']/(pow(1024, 2));
if($size > 100){
	echo '<script type="text/javascript">window.parent.loadDocList("文件过大")</script>';
	exit;
}
$fileName = $_FILES['doc']['name'];
$doc = $_FILES['doc']['tmp_name'];
$picType = $_FILES['doc']['type'];

if(is_uploaded_file($doc)){ 
	require '../conf.php';
	require 'wis.php';
	$api = new WisApi($accessId,$accessKey);
	$handle = fopen($doc, "r");
    $contents = fread($handle, filesize ($doc));
    fclose($handle);
	$fileData = base64_encode($contents);
	$rst = $api->UploadDoc(array("fileName"=>$fileName,"fileData"=>$fileData));
	echo '<script type="text/javascript">window.parent.loadDocList("'.$rst['FlagString'].'")</script>';
	exit;
} else {
	echo '<script type="text/javascript">window.parent.loadDocList("请选择正确的文件")</script>';
	exit;
}
?>
			