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
		
}
