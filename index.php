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
        	'pass' => null,
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

//检测是否移动端
$container['ismobile'] = function($container){
     // 如果有HTTP_X_WAP_PROFILE则一定是移动设备
    if (isset ($_SERVER['HTTP_X_WAP_PROFILE']))
        return true;
    
    //此条摘自TPM智能切换模板引擎，适合TPM开发
    if(isset ($_SERVER['HTTP_CLIENT']) &&'PhoneClient'==$_SERVER['HTTP_CLIENT'])
        return true;
    //如果via信息含有wap则一定是移动设备,部分服务商会屏蔽该信息
    if (isset ($_SERVER['HTTP_VIA']))
        //找不到为flase,否则为true
        return stristr($_SERVER['HTTP_VIA'], 'wap') ? true : false;
    //判断手机发送的客户端标志,兼容性有待提高
    if (isset ($_SERVER['HTTP_USER_AGENT'])) {
        $clientkeywords = array(
            'nokia','sony','ericsson','mot','samsung','htc','sgh','lg','sharp','sie-','philips','panasonic','alcatel','lenovo','iphone','ipod','blackberry','meizu','android','netfront','symbian','ucweb','windowsce','palm','operamini','operamobi','openwave','nexusone','cldc','midp','wap','mobile'
        );
        //从HTTP_USER_AGENT中查找手机浏览器的关键字
        if (preg_match("/(" . implode('|', $clientkeywords) . ")/i", strtolower($_SERVER['HTTP_USER_AGENT']))) {
            return true;
        }
    }
    //协议法，因为有可能不准确，放到最后判断
    if (isset ($_SERVER['HTTP_ACCEPT'])) {
        // 如果只支持wml并且不支持html那一定是移动设备
        // 如果支持wml和html但是wml在html之前则是移动设备
        if ((strpos($_SERVER['HTTP_ACCEPT'], 'vnd.wap.wml') !== false) && (strpos($_SERVER['HTTP_ACCEPT'], 'text/html') === false || (strpos($_SERVER['HTTP_ACCEPT'], 'vnd.wap.wml') < strpos($_SERVER['HTTP_ACCEPT'], 'text/html')))) {
            return true;
        }
    }
    return false;
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
$app->get('/test', '\LiveController:test');
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