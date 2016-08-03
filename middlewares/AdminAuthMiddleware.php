<?php
use Dflydev\FigCookies\FigRequestCookies;

class AdminAuthMiddleware
{
	public function __invoke($request, $response, $next)
    {
        $cookie_admin = FigRequestCookies::get($request, 'admin');
        $response = $next($request, $response);
		if(!$cookie_admin->getValue())
		{
			$response->withHeader("Location","/admin");
		}
		else
		{
			$response->withHeader('Location', $request->getUri()->getPath());
		}
        return $response;
    }
}