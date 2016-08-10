<?php
use Dflydev\FigCookies\FigRequestCookies;

class LiveController
{
	protected $ci;

	public function __construct($ci)
	{
		$this->ci = $ci;
	}

	/**
	 * 直播间
	 */
	public function index($request, $response, $args)
	{
		$id = $request->getQueryParams()['id'];

		$db = $this->ci->db;
		$sth = $db->prepare("select * from qw_live where appid=:t ");
		$sth->bindParam(':t', $id, PDO::PARAM_INT);
		$sth->execute();
		$live = $sth->fetch(PDO::FETCH_ASSOC);
		return $this->ci->view->render($response, '/live/index.html', [
				'live' => $live
			]);
	}	

	public function room($request, $response, $args)
	{
		$id = $request->getQueryParams()['id'];

		
		$cookie_appids = FigRequestCookies::get($request, 'appids');
		if(!$cookie_appids->getValue())
		{
			$response->getBody()->write("<body onload='location.href=\"http://www.safecoo.com/index.php/home/Live/index\"'><h1>您未付费，请付费后观看!</h2><a href='http://www.safecoo.com/index.php/home/Live/index'>返回</a></h2></body>");
			return $response;   
		}
		if($cookie_appids->getValue() && strpos($cookie_appids->getValue(), $id) === false)
		{	
			//$response->getBody()->write("<h1>您未付费，请付费后观看!</h2><a href='http://www.safecoo.com/index.php/home/Live/index'>返回</a></h2>");
			$response->getBody()->write("<body onload='location.href=\"http://www.safecoo.com/index.php/home/Live/index\"'><h1>您未付费，请付费后观看!</h2><a href='http://www.safecoo.com/index.php/home/Live/index'>返回</a></h2></body>");
			return $response;
		}
		

		$db = $this->ci->db;
		$sth = $db->prepare("select * from qw_live where appid=:t ");
		$sth->bindParam(':t', $id, PDO::PARAM_INT);
		$sth->execute();
		$live = $sth->fetch(PDO::FETCH_ASSOC);
		
		if($this->ci->ismobile)
		{
			return $this->ci->view->render($response, '/live/room-mobile.html', [
				'live' => $live
			]);
		}
		else
		{
			return $this->ci->view->render($response, '/live/room.html', [
				'live' => $live
			]);
		
		}
	}

	public function test($request, $response, $args)
	{
		return $this->ci->view->render($response, '/live/test.html',[]);
	}

	public function vod($request, $response, $args)
	{
		/*
		$cookie_appids = FigRequestCookies::get($request, 'appids');
		if(!$cookie_appids->getValue())
		{
			$response->getBody()->write("您未付费，请付费后观看!<a href='http://www.safecoo.com/index.php/home/Live/index'>返回</a>");
			return $response;   
		}
		if($cookie_appids->getValue() && strpos($cookie_appids->getValue(), $id) === false)
		{	
			$response->getBody()->write("您未付费，请付费后观看!<a href='http://www.safecoo.com/index.php/home/Live/index'>返回</a>");
			return $response;
		}
		*/

		$id = $request->getQueryParams()['id'];
		$curl = new Curl;
		$curlResp = $curl->post('http://openapi.aodianyun.com/v2/DVR.GetDvrList'
			, '{"access_id":"'.ADConf::AccessId.'","access_key":"'.ADConf::AccessKey.'","app":"'.$id.'"}');

		$json = json_decode($curlResp->body);
		if($json->Flag == 101)
		{
			$response->getBody()->write("没有相关的点播视频。");
			return $response;   
		}

		$db = $this->ci->db;
		$sth = $db->prepare("select * from qw_live where appid=:t and sid=8");
		$sth->bindParam(':t', $id, PDO::PARAM_INT);
		$sth->execute();
		$live = $sth->fetch(PDO::FETCH_ASSOC);

		return $this->ci->view->render($response, '/live/vod.html',[
				'List' => $json->List,
				'Live' => $live,
				'ismobile' => $this->ci->ismobile
			]);
	}

	public function uploadvod($request, $response, $args)
	{
		$curl = new Curl;
		$curlResp = $curl->post('http://openapi.aodianyun.com/v2/VOD.GetUploadVodList'
			, '{"access_id":"'.ADConf::AccessId.'","access_key":"'.ADConf::AccessKey.'"}');

		$json = json_decode($curlResp->body);
		if($json->Flag == 101)
		{
			$response->getBody()->write("没有相关的点播视频。");
			return $response;   
		}

		return $this->ci->view->render($response, '/live/uploadvod.html',[
				'List' => $json->List,
				'ismobile' => $this->ci->ismobile
			]);
	}

}
