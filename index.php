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
    ],
];
$app = new \Slim\App($config);

$container = $app->getContainer();

//使用twig template
$container['view'] = function($container){
	$view = new \Slim\Views\Twig(__DIR__.'/templates/', [
		
		]);
	$view->addExtension(new \Slim\Views\TwigExtension(
			$container['router'],
			$container['request']->getUri()
		));
	return $view;
};

$container['AdminController'] = function ($container) {
    return new \AdminController($container);
};
$container['ApiController'] = function ($container) {
    return new \ApiController($container);
};

//管理
$app->group('/admin', function(){
	$this->get('', '\AdminController:index');
});

$app->group('/api', function(){
	$this->post('/login', '\ApiController:login');
});

$app->run();