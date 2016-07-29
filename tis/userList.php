<?php
class UserListApi{
	private $s_key;
	private $host = 'http://api.dms.aodianyun.com';
	public function __construct($s_key) {
		$this->s_key = $s_key;
	}
	public function userList($param){
		if(empty($param["topic"])){
			return array(
				'Flag'=>101,
				'FlagString'=>'参数错误'
			);
		}
    	$skip = 0;
		$num = 100;
    	if(!empty($param['skip'])){
			$skip=$param['skip'];
		}
		if(!empty($param['num'])){
			$num=$param['num'];
		}
		return $this->curl("/v1/topics/".$param["topic"]."/users?skip=".$skip."&num=".$num);
	}
	private function curl($path,$method="GET",$content="",$timeout=60) {
		$ch = curl_init();
		$query_url = $this->host.$path;
   
		curl_setopt($ch,CURLOPT_URL,$query_url);
		curl_setopt($ch,CURLOPT_HEADER,false);
		curl_setopt($ch,CURLOPT_AUTOREFERER,true);
		curl_setopt($ch,CURLOPT_FOLLOWLOCATION,true);
		curl_setopt($ch,CURLOPT_FRESH_CONNECT,true);
		curl_setopt($ch,CURLOPT_CONNECTTIMEOUT,$timeout);
		curl_setopt($ch,CURLOPT_TIMEOUT,$timeout);
		curl_setopt($ch,CURLOPT_RETURNTRANSFER,true);
		curl_setopt($ch,CURLOPT_BINARYTRANSFER,true);
		curl_setopt($ch,CURLOPT_CUSTOMREQUEST,$method);
		if($method == 'POST') {
			curl_setopt($ch,CURLOPT_POST,true);
			curl_setopt($ch,CURLOPT_POSTFIELDS,$content);
		}
		$authorization = 'Authorization: dms '.$this->s_key;
		$header = array($authorization,'Content-Type: application/json');
		curl_setopt($ch,CURLOPT_HTTPHEADER, $header);

		$response = curl_exec($ch);
		$response_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
		curl_close($ch);

		if($response_code == 200 || $response_code == 201 || $response_code == 204) {
			$rst = json_decode(trim($response),true);
		} else {
			$rr = json_decode(trim($response),true);
			if($rr) {
				$rst = $rr;
			} else {
				$rst = array(
					'Flag'=>$response_code,
					'FlagString'=>trim($response)
				);
			}
		}
		return $rst;
	}
}
require '../conf.php';
$api = new UserListApi($dmsSkey);
$method = $_REQUEST['method'];
$rst = $api->$method($_REQUEST);
echo json_encode($rst);
?>