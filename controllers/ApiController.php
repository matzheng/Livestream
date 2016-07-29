<?php

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
		return $response->withJson([
			'status' => 'y',
			'body' => $parsedBody['name'],
			'pwd' => $parsedBody['pwd']
			]);
	}
}