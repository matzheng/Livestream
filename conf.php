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
	const   Uin = "22279";
	const 	TisId = "48d30a7c9dd14bc9ef0525ef2b547443";
	const 	DmsSKey = "s_5821e7e771de130c24d5d86fdc393d0d";
}
class DBConf
{
	const host = "127.0.0.1";
	const user = "root";
	const password = '123456';
	const dbname = "jxnews";
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