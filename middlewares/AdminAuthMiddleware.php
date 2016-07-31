<?php
use Dflydev\FigCookies\FigRequestCookies;

class AdminAuthMiddleware
{
	public function __invoke($request, $response, $next)
    {
        $cookie_admin = FigRequestCookies::get($request, 'admin');
		if(!$cookie_admin->getValue())
		{
			return $response->withHeader("Location","/admin");
		}
		else
		{
			return $response->withHeader('Location', $request->getUri()->getPath());
		}
        
    }
}