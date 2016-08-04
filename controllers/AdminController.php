<?php

use Dflydev\FigCookies\FigRequestCookies;

class AdminController
{
	protected $ci;

	public function __construct($ci)
	{
		$this->ci = $ci;
	}

	/**
	 * 登录
	 */
	public function index($request, $response, $args)
	{
		//var_dump(md5('Q'.'jingkuna'.'W'));
		$cookie_admin = FigRequestCookies::get($request, 'admin');
		if($cookie_admin->getValue())
			return $response->withRedirect('/admin/main');
		return $this->ci->view->render($response, '/admin/index.html', []);
	}	

	/**
	 * 主节目
	 */
	public function main($request, $response, $args)
	{
		//管理员
		$db = $this->ci->db;
		$sth = $db->prepare("select count(*) as admincount from qw_member ");
		$sth->execute();
		$admincount = $sth->fetch(PDO::FETCH_ASSOC);

		//用户
		$sth = $db->prepare("select count(*) as usercount from qw_h_user ");
		$sth->execute();
		$usercount = $sth->fetch(PDO::FETCH_ASSOC);

		//订单数
		$sth = $db->prepare("select count(*) as ordercount from qw_live_orders ");
		$sth->execute();
		$ordercount = $sth->fetch(PDO::FETCH_ASSOC);
		//直播间
		$sth = $db->prepare("select count(*) as livecount from qw_live where sid=7 ");
		$sth->execute();
		$livecount = $sth->fetch(PDO::FETCH_ASSOC);

		//点播
		$sth = $db->prepare("select count(*) as vodcount from qw_live where sid=8 ");
		$sth->execute();
		$vodcount = $sth->fetch(PDO::FETCH_ASSOC);

		$cookie_admin = FigRequestCookies::get($request, 'admin');
		return $this->ci->view->render($response, '/admin/main.html', [
			'user' => $cookie_admin->getValue(),
			'admincount' => $admincount['admincount'],
			'usercount' => $usercount['usercount'],
			'ordercount' => $ordercount['ordercount'],
			'commentcount' => 0,
			'livecount' => $livecount['livecount'],
			'vodcount' => $vodcount['vodcount']
			]);
	}

	/**
	 * 退出
	 */
	public function logout($request, $response, $args)
	{
		setcookie('admin', null,time()-3600,'/');
		return $response->withRedirect('/admin');
	}

	/**
	 * 改密码
	 */
	public function profile($request, $response, $args)
	{
		$cookie_admin = FigRequestCookies::get($request, 'admin');
		return $this->ci->view->render($response, '/admin/profile.html', [
			'user' => $cookie_admin->getValue()
			]);
	}

	/**
	 * 管理员列表
	 */
	public function adminlist($request, $response, $args)
	{
		$db = $this->ci->db;
		$sth = $db->prepare("select * from qw_member");
		$sth->execute();
		$admins = $sth->fetchAll(PDO::FETCH_ASSOC);

		$cookie_admin = FigRequestCookies::get($request, 'admin');
		return $this->ci->view->render($response, '/admin/adminlist.html', [
			'user' => $cookie_admin->getValue(),
			'admins' => $admins
			]);
	}

	/**
	 * 直播间列表
	 */
	public function streams($request, $response, $args)
	{
		//列表
		$db = $this->ci->db;
		$sth = $db->prepare("select * from qw_live where sid=7");
		$sth->execute();
		$lives = $sth->fetchAll(PDO::FETCH_ASSOC);

		//分类
		$db = $this->ci->db;
		$sth = $db->prepare("select * from qw_livecate where id=8");
		$sth->execute();
		$cates = $sth->fetchAll(PDO::FETCH_ASSOC);

		$cookie_admin = FigRequestCookies::get($request, 'admin');
		return $this->ci->view->render($response, '/admin/streams.html', [
			'user' => $cookie_admin->getValue(),
			'uin' => ADConf::Uin,
			'lives' => $lives,
			'cates' => $cates
			]);
	}

	public function streamdetail($request, $response, $args)
	{
		//分类
		$db = $this->ci->db;
		$sth = $db->prepare("select * from qw_livecate where id=7");
		$sth->execute();
		$cates = $sth->fetchAll(PDO::FETCH_ASSOC);

		//直播详情
		$sth = $db->prepare("select * from qw_live where aid=:id");
		$sth->bindParam(':id', $request->getQueryParams()['id'], PDO::PARAM_INT);
		$sth->execute();
		$stream = $sth->fetch(PDO::FETCH_ASSOC);

		$cookie_admin = FigRequestCookies::get($request, 'admin');
		return $this->ci->view->render($response, '/admin/streamdetail.html', [
				'user' => $cookie_admin->getValue(),
				'cates' => $cates,
				'stream' => $stream
			]);
	}
	/**
	 * 订单列表
	 */
	public function orders($request, $response, $args)
	{
		//列表
		$db = $this->ci->db;
		$sth = $db->prepare("SELECT a.*,b.username FROM qw_live_orders a inner join qw_h_user b on a.uid=b.uid");
		$sth->execute();
		$orders = $sth->fetchAll(PDO::FETCH_ASSOC);

		$cookie_admin = FigRequestCookies::get($request, 'admin');
		return $this->ci->view->render($response, '/admin/orders.html', [
			'user' => $cookie_admin->getValue(),
			'orders' => $orders
			]);
	}

	/**
	 * 用户列表
	 */
	public function users($request, $response, $args)
	{
		//列表
		$db = $this->ci->db;
		$sth = $db->prepare("SELECT * FROM qw_h_user");
		$sth->execute();
		$users = $sth->fetchAll(PDO::FETCH_ASSOC);

		$cookie_admin = FigRequestCookies::get($request, 'admin');
		return $this->ci->view->render($response, '/admin/users.html', [
			'user' => $cookie_admin->getValue(),
			'users' => $users
			]);
	}

	/**
	 * 点播
	 */
	public function vod($request, $response, $args)
	{
		//列表
		$db = $this->ci->db;
		$sth = $db->prepare("select * from qw_live where sid=8");
		$sth->execute();
		$lives = $sth->fetchAll(PDO::FETCH_ASSOC);

		//分类
		$sth = $db->prepare("select * from qw_livecate where id=8");
		$sth->execute();
		$cates = $sth->fetchAll(PDO::FETCH_ASSOC);

		//appids
		$sth = $db->prepare("select * from qw_live where sid=7");
		$sth->execute();
		$appids = $sth->fetchAll(PDO::FETCH_ASSOC);

		$cookie_admin = FigRequestCookies::get($request, 'admin');
		return $this->ci->view->render($response, '/admin/vod.html', [
			'user' => $cookie_admin->getValue(),
			'uin' => ADConf::Uin,
			'lives' => $lives,
			'cates' => $cates,
			'appids' => $appids
			]);
	}

	/**
	 * 点播详情
	 */
	public function voddetail($request, $response, $args)
	{
		//分类
		$db = $this->ci->db;
		$sth = $db->prepare("select * from qw_livecate where id=8");
		$sth->execute();
		$cates = $sth->fetchAll(PDO::FETCH_ASSOC);

		//直播详情
		$sth = $db->prepare("select * from qw_live where aid=:id");
		$sth->bindParam(':id', $request->getQueryParams()['id'], PDO::PARAM_INT);
		$sth->execute();
		$stream = $sth->fetch(PDO::FETCH_ASSOC);

		//appids
		$sth = $db->prepare("select * from qw_live where sid=7");
		$sth->execute();
		$appids = $sth->fetchAll(PDO::FETCH_ASSOC);

		$cookie_admin = FigRequestCookies::get($request, 'admin');
		return $this->ci->view->render($response, '/admin/voddetail.html', [
				'user' => $cookie_admin->getValue(),
				'cates' => $cates,
				'stream' => $stream,
				'appids' => $appids
			]);
	}
}