<?php

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
		//var_dump($request->getQueryParams());
		$id = $request->getQueryParams()['id'];

		$db = $this->ci->db;
		$sth = $db->prepare("select * from qw_live where t=:t ");
		$sth->bindParam(':t', $id, PDO::PARAM_INT);
		$sth->execute();
		$live = $sth->fetch(PDO::FETCH_ASSOC);
		return $this->ci->view->render($response, '/live/index.html', [
				'live' => $live
			]);
	}	

	public function room($request, $response, $args)
	{
		return $this->ci->view->render($response, '/live/room.html', []);
	}
}