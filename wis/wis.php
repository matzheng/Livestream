<?php 

class WisApi{
	private $accessId;
	private $host = 'http://api.dms.aodianyun.com:80';
	private $accessKey;
	public function __construct($accessId,$accessKey) {
		$this->accessKey = $accessKey;
		$this->accessId = $accessId;
	}
	public function Sign($str){
		$signature = $this->accessId.":".base64_encode(hash_hmac("sha1", $str, $this->accessKey, true));
		return $signature;
	}

	public function History($param){
		if(empty($param['wisId'])){
			return array(
				'Flag'=>101,
				'FlagString'=>'参数错误'
			);
		}
		return $this->curl("/v1/wis/".$param['wisId']."/history");
	}
	public function PageInfo($param){
		if(empty($param['docId']) || empty($param['page'])){
			return array(
				'Flag'=>101,
				'FlagString'=>'参数错误'
			);
		}
		return $this->curl("/v1/wis/docs/".$param['docId']."/pages/".$param['page']);
	}
	public function WisInfo($param){
		if(empty($param['wisId']) ){
			return array(
				'Flag'=>101,
				'FlagString'=>'参数错误'
			);
		}
		return $this->curl("/v1/wis/".$param['wisId']);
	}
	public function DelDoc($param){
		if(empty($param['docId']) ){
			return array(
				'Flag'=>101,
				'FlagString'=>'参数错误'
			);
		}
		return $this->curl("/v1/wis/docs/".$param['docId'],"DELETE");
	}
	public function DocInfo($param){
		if(empty($param['docId']) ){
			return array(
				'Flag'=>101,
				'FlagString'=>'参数错误'
			);
		}
		return $this->curl("/v1/wis/docs/".$param['docId']);
	}
	public function SyncDraw($param){
		if(empty($param['wisId']) || empty($param['content'])){
			return array(
				'Flag'=>101,
				'FlagString'=>'参数错误'
			);
		}
		return $this->curl("/v1/wis/".$param['wisId']."/draw","POST",json_encode(array('body' =>  $param['content'])));
	}
	public function SyncPage($param){
		if(empty($param['wisId']) || empty($param['page'])){
			return array(
				'Flag'=>101,
				'FlagString'=>'参数错误'
			);
		}
		return $this->curl("/v1/wis/".$param['wisId']."/syncPage","POST",json_encode(array('page' =>  intval($param['page']))));
	}
	public function CustomMessage($param){
		if(empty($param['wisId']) || empty($param['content'])){
			return array(
				'Flag'=>101,
				'FlagString'=>'参数错误'
			);
		}
		return $this->curl("/v1/wis/".$param['wisId']."/custom","POST",json_encode(array('body' =>  $param['content'])));
	}
	public function CreateWis($param){
		if(empty($param['dmsSecKey']) || empty($param['desc'])){
			return array(
				'Flag'=>101,
				'FlagString'=>'参数错误'
			);
		}
		return $this->curl("/v1/wis/auto","POST",json_encode($param));
	}
	public function ChoseDoc($param){
		if(empty($param['wisId']) || empty($param['docId'])){
			return array(
				'Flag'=>101,
				'FlagString'=>'参数错误'
			);
		}
		return $this->curl("/v1/wis/".$param['wisId']."/chose","POST",json_encode(array('docId' =>  $param['docId'])));
	}
	public function DocList($param) {
		$skip = 0;
		$num = 10;
		if(!empty($param['skip'])){
			$skip = $param['skip'];
		}
		if(!empty($param['num'])){
			$num = $param['num'];
		}
		return $this->curl("/v1/wis/docs?skip=".$skip."&num=".$num);
	}
	public function UploadDoc($param){
		if(empty($param['fileName']) ||empty($param['fileData'])){
			return array(
				'Flag'=>101,
				'FlagString'=>'参数错误'
			);
		}
		$content = json_encode(array('fileName' =>  $param['fileName'],'data'=>$param['fileData']));
		//print_r($content);exit;
		return $this->curl("/v1/wis/docs/auto","POST",$content);
	}
	private function curl($path,$method="GET",$content="",$expire=3600,$timeout=60){
		$ch = curl_init();
		$expire = time() + $expire;
		if($method == "POST" && !empty($content)){
			$contentMd5 = md5($content);
			$str = $method."\n".$path."\n".$expire."\n".$contentMd5."\n";
		}else{
			$str = $method."\n".$path."\n".$expire."\n";
		}
		$query_url = $this->host.$path;
   
		curl_setopt($ch,CURLOPT_URL,$query_url);
		curl_setopt($ch,CURLOPT_HEADER,false);
		
		curl_setopt($ch,CURLOPT_AUTOREFERER,true);
		curl_setopt($ch,CURLOPT_FOLLOWLOCATION,true);
		curl_setopt($ch,CURLOPT_FRESH_CONNECT,true);
		curl_setopt($ch,CURLOPT_CONNECTTIMEOUT,$timeout);
		curl_setopt($ch,CURLOPT_TIMEOUT,$timeout);
		//	curl_setopt($ch,CURLOPT_USERAGENT,$useragent);
		curl_setopt($ch,CURLOPT_RETURNTRANSFER,true);
		curl_setopt($ch,CURLOPT_BINARYTRANSFER,true);
		curl_setopt($ch,CURLOPT_CUSTOMREQUEST,$method);
	       // curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
		if($method == 'POST') {
			curl_setopt($ch,CURLOPT_POST,true);
			curl_setopt($ch,CURLOPT_POSTFIELDS,$content);
		}
		$authorization = 'Authorization: wis '.$this->Sign($str);
		//print_r($authorization);exit();
		$header = array($authorization,'AD-Expire: '.$expire,'Content-Type: application/json');
		curl_setopt($ch,CURLOPT_HTTPHEADER, $header);
		//execute post
		$response = curl_exec($ch);
		//get response code
		$response_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
		//close connection 
		curl_close($ch);
		//return result
		
		if($response_code == 200 || $response_code == 201 || $response_code == 204) {
			
			$rst = array(
				'Flag'=>100,
				'FlagString'=>'success',
				'Info'=>json_decode(trim($response),true)
			);
		} else {
			$rr = json_decode(trim($response),true);
			$rst = array(
				'Flag'=>$rr['code'],
				'FlagString'=>$rr['error']
			);
		}
		return $rst;
	}
}
?>