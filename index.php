<?php

require_once __DIR__.'/vendor/autoload.php';
require_once __DIR__.'/controllers/ApiController.php';
require_once __DIR__.'/controllers/AdminController.php';
require_once __DIR__.'/controllers/LiveController.php';
require_once __DIR__.'/controllers/UploadController.php';
require_once __DIR__.'/middlewares/AdminAuthMiddleware.php';
require_once __DIR__.'/vendor/shuber/curl/curl.php';
require_once __DIR__.'/conf.php';
require_once __DIR__.'/wis/wis.php';

$config = [
    'settings' => [
        'displayErrorDetails' => true,

        'logger' => [
            'name' => 'slim-app',
            'level' => Monolog\Logger::DEBUG,
            'path' => __DIR__ . '/logs/app.log',
        ],
/*
        'db' => [
        	'host' => '127.0.0.1',
        	'user' => 'root',
        	'pass' => '123456',
        	'dbname' => 'jxnews'
        ],
*/
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
	$pdo = new PDO("mysql:host=".DBConf::host.";dbname=".DBConf::dbname.";charset=utf8", DBConf::user, DBConf::password);
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
$container['UploadController'] = function ($ci) {
    return new \UploadController($ci);
};

/**
 * 直播间
 */
$app->get('/live', '\LiveController:index');
$app->get('/room', '\LiveController:room');
$app->get('/upload','\UploadController:index');
$app->post('/upload','\UploadController:upload');
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
    $this->get('/streamdetail', '\AdminController:streamdetail');
    $this->get('/orders', '\AdminController:orders');
    $this->get('/users', '\AdminController:users');
});

/**
 * API
 */
$app->group('/api', function(){
	$this->post('/login', '\ApiController:login');
    $this->post('/changepwd', '\ApiController:changepwd');
    $this->post('/addAdmin', '\ApiController:addAdmin');
    $this->post('/addStream', '\ApiController:addStream');
    $this->post('/editStream', '\ApiController:editStream');
    $this->post('/deleteStream', '\ApiController:deleteStream');
});

/**
 * 启动
 */
$app->run();