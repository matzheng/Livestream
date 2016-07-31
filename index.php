<?php

require_once __DIR__.'/vendor/autoload.php';
require_once __DIR__.'/controllers/ApiController.php';
require_once __DIR__.'/controllers/AdminController.php';
require_once __DIR__.'/controllers/LiveController.php';
require_once __DIR__.'/middlewares/AdminAuthMiddleware.php';
require_once __DIR__.'/vendor/shuber/curl/curl.php';
require_once __DIR__.'/conf.php';
$config = [
    'settings' => [
        'displayErrorDetails' => true,

        'logger' => [
            'name' => 'slim-app',
            'level' => Monolog\Logger::DEBUG,
            'path' => __DIR__ . '/logs/app.log',
        ],

        'db' => [
        	'host' => '127.0.0.1',
        	'user' => 'root',
        	'pass' => null,
        	'dbname' => 'jxnews'
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
 
$container['db'] = function($container){
	$db = $container['settings']['db'];
	$pdo = new PDO("mysql:host=".$db['host'].";dbname=".$db['dbname'].";charset=utf8", $db['user'], $db['pass']);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    return $pdo;
};

/**
 * controler 绑定
 */
$container['AdminController'] = function ($ci) {
    return new \AdminController($ci);
};
$container['ApiController'] = function ($ci) {
    return new \ApiController($ci);
};
$container['LiveController'] = function ($ci) {
    return new \LiveController($ci);
};

/**
 * 直播间
 */
$app->get('/live', '\LiveController:index');
/**
 * Routes
 * 管理
 * api
 */
$app->group('/admin', function(){
	$this->get('', '\AdminController:index');
    $this->get('/main', '\AdminController:main');
    $this->get('/profile','\AdminController:profile');
    $this->get('/logout', '\AdminController:logout');
    $this->get('/adminlist', '\AdminController:adminlist');
    $this->get('/streams', '\AdminController:streams');
    $this->get('/orders', '\AdminController:orders');
    $this->get('/users', '\AdminController:users');
});

$app->group('/api', function(){
	$this->post('/login', '\ApiController:login');
    $this->post('/changepwd', '\ApiController:changepwd');
    $this->post('/addAdmin', '\ApiController:addAdmin');
    $this->post('/addStream', '\ApiController:addStream');
});

/**
 * 启动
 */
$app->run();