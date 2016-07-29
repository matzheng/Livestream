<?php
class ADConf {
	/*
	const	AccessId = "021416177777";
	const	AccessKey = "028kC7nY3gW5cZ4s3MBq5D0A1a7uzKrl";
	const 	TisId = "c80e8f83ae41fc26545e7700a62a8a0e";
	const 	DmsSKey = "s_6abe5f1e6c809ad3bff8c6759c53db6b";
	*/
	const	AccessId = "713612033992";
	const	AccessKey = "0BiJ9ZqDsQFTFNcPP0hW09zBJ0lehlCz";
	const 	TisId = "1238dcb6cbb6d62a10a3e785265dfcab";
	const 	DmsSKey = "s_91f4b0a3993c642f657febc027e78507";
}
$accessId = ADConf::AccessId;
$accessKey = ADConf::AccessKey;
$dmsSkey = ADConf::DmsSKey;
if(!empty($_REQUEST["tisId"])){
	$tisId = $_REQUEST["tisId"];
} else {
	$tisId = ADConf::TisId;
}
?>