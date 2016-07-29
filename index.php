<?php

require_once __DIR__.'/vendor/autoload.php';
require_once __DIR__.'/controllers/ApiController.php';
require_once __DIR__.'/controllers/AdminController.php';
$config = [
    'settings' => [
        'displayErrorDetails' => true,

        'logger' => [
            'name' => 'slim-app',
            'level' => Monolog\Logger::DEBUG,
            'path' => __DIR__ . '/logs/app.log',
        ],

        'db' => [
        	'host' => 'localhost',
        	'user' => 'root',
        	'pass' => '123456',
        	'dbname' => 'live'
        ],
    ],
];
$app = new \Slim\App($config);

$container = $app->getContainer();

/**
 * 使用twig template
 */
$container['view'] = function($container){
	$view = new \Slim\Views\Twig(__DIR__.'/templates/', [
		
		]);
	$view->addExtension(new \Slim\Views\TwigExtension(
			$container['router'],
			$container['request']->getUri()
		));
	return $view;
};

/**
 * db
 */
$container['db'] = function($container){
	$db = $container['settings']['db'];
	$pdo = new PDO("mysql:host=".$db['host'].";dbname=".$db['dbname'], $db['user'], $db['pass']);
};

/**
 * controler 绑定
 */
$container['AdminController'] = function ($container) {
    return new \AdminController($container);
};
$container['ApiController'] = function ($container) {
    return new \ApiController($container);
};


/**
 * Routes
 * 管理
 * api
 */
$app->group('/admin', function(){
	$this->get('', '\AdminController:index');
});

$app->group('/api', function(){
	$this->post('/login', '\ApiController:login');
});

/**
 * 启动
 */
$app->run();