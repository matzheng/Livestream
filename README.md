# Livestream

a management system for Anku company

## Tools
1. Slim
2. Mysql


```php
$app->get('/', function ($request, $response){
    $response->getBody()->write("<h1>安酷后台管理系统</h1><p><a href='/admin'>登录</a></p>");

    return $response;
});
```
