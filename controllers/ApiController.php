<?php

//use Dflydev\FigCookies\Cookie;
//use Slim\Http\Cookies;

class ApiController
{
	protected $ci;

	public function __construct($ci)
	{
		$this->ci = $ci;
	}

	public function login($request, $response, $args)
	{
		$parsedBody = $request->getParsedBody();
		$db = $this->ci->db;
		$sth = $db->prepare("select * from qw_member where user=:user and password=:pwd ");
		$sth->bindParam(':user', $parsedBody['name'], PDO::PARAM_STR);
		$sth->bindParam(':pwd', md5('Q'.$parsedBody['pwd'].'W'), PDO::PARAM_STR);
		$sth->execute();
		$admin = $sth->fetch(PDO::FETCH_ASSOC);
		if($admin)
		{
			setcookie('admin', $parsedBody['name'], time()+3600*24, '/');
			return $response->withJson(
				[
					'status' => 'y',
					'msg' => '登录成功。'
				]
			);
		}
		else
		{
			return $response->withJson([
			'status' => 'n',
			'msg' => '账户或密码错误。'
			]);
		}
	}

	public function changepwd($request, $response, $args)
	{
		$parsedBody = $request->getParsedBody();
		$user = $parsedBody['user'];
		$pwd = $parsedBody['pwd'];
		$db = $this->ci->db;
		$sth = $db->prepare("update qw_member set password=:pwd where user=:name");
		$sth->bindParam(':name', $user, PDO::PARAM_STR);
		$sth->bindParam(':pwd', md5('Q'.$pwd.'W'), PDO::PARAM_STR);
		$sth->execute();
		return $response->withJson(
				[
					'status' => 'y',
					'msg' => '修改成功。'
				]
			);
	}

	public function addAdmin($request, $response, $args)
	{
		$parsedBody = $request->getParsedBody();
		$name = $parsedBody['name'];
		$pwd = $parsedBody['pwd'];
		$phone = $parsedBody['phone'];
		$qq = $parsedBody['qq'];
		$email = $parsedBody['email'];
		$db = $this->ci->db;
		$sth = $db->prepare("insert into qw_member(user, password, phone , qq, email, t) values(:name, :pwd , :phone, :qq,:email,:t)");
		$sth->bindParam(':name', $name, PDO::PARAM_STR);
		$sth->bindParam(':pwd', md5('Q'.$pwd.'W'), PDO::PARAM_STR);
		$sth->bindParam(':phone', $phone, PDO::PARAM_STR);
		$sth->bindParam(':qq', $qq, PDO::PARAM_STR);
		$sth->bindParam(':email', $email, PDO::PARAM_STR);
		$sth->bindParam(':t', time(), PDO::PARAM_INT);
		$sth->execute();
		return $response->withJson(
				[
					'status' => 'y',
					'msg' => '添加成功。'
				]
			);
	}

	public function addStream($request, $response, $args)
	{
	
		$parsedBody = $request->getParsedBody();
		$title = $parsedBody['title'];
		$cate = $parsedBody['cate'];
		$price = $parsedBody['price'];
		$appid = time();
		$roomurl = "http://".$request->getUri()->getHost().":"
				.$request->getUri()->getPort()."/room?id=".$appid."&lssApp=".$appid."&thApp=".$appid."&lssStream=".$appid
				."&thStream=".$appid;
		$db = $this->ci->db;
		$sth = $db->prepare("insert into qw_live(sid, title, keywords,
			description, thumbnail, content, liveurl,liveprice, t, n , r,appid) 
			values(:sid, :title,:title, '','','', :liveurl,:price,:time,0,1,:appid)");
		$sth->bindParam(':sid', $cate, PDO::PARAM_INT);
		$sth->bindParam(':title', $title, PDO::PARAM_STR);
		$sth->bindParam(':liveurl',$roomurl, PDO::PARAM_STR);
		$sth->bindParam(':price', $price, PDO::PARAM_INT);
		$sth->bindParam(':time', time(), PDO::PARAM_INT);
		$sth->bindParam(':appid', $appid, PDO::PARAM_INT);
		$sth->execute();

		$curl = new Curl;
		$curlResp = $curl->post('http://openapi.aodianyun.com/v2/LSS.OpenApp'
			, '{"access_id":"'.ADConf::AccessId.'","access_key":"'.ADConf::AccessKey.'","appid":"'.$appid.'","appname":"'.$title.'"}');

		return $response->withJson(
				[
					'status' => 'y',
					'msg' => '添加成功。'
				]
			);
	}
}