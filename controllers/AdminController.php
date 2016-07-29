<?php
class AdminController
{
	protected $ci;

	public function __construct($ci)
	{
		$this->ci = $ci;
	}

	public function index($request, $response, $args)
	{
		return $this->ci->view->render($response, '/admin/index.html', []);
	}	
}