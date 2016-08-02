<?php

class UploadController
{
	protected $ci;

	public function __construct($ci)
	{
		$this->ci = $ci;
	}

	public function index($request, $response, $args)
	{
		$width = $request->getQueryParams()['Width'];
		$height = $request->getQueryParams()['Height'];
		$backcall = $request->getQueryParams()['BackCall'];
		$img = $request->getQueryParams()['Img'];
		return $this->ci->view->render($response, '/upload/index.html', [
				'Width' => $width,
				'Height' => $height,
				'BackCall' => $backcall,
				'Img' => $img
			]);
	}

	public function upload($request, $response, $args)
	{
		$file = $request->getUploadedFiles()['img'];
        $destination_folder='themes/attached/'.date('Ym').'/'; //上传文件路径

        if(!file_exists($destination_folder)){
            mkdir($destination_folder);
        }
        $destination = $destination_folder.time().".jpg";
        $file->moveTo($destination);
        //return "/".$destination;
        $width = $_POST['Width'];
		$height = $_POST['Height'];
		$backcall = $_POST['BackCall'];
		$Img = "http://".$request->getUri()->getHost().":"
				.$request->getUri()->getPort()."/".$destination;

        return $this->ci->view->render($response, '/upload/index.html', [
				'Width' => $width,
				'Height' => $height,
				'BackCall' => $backcall,
				'Img' => $Img
			]);
	}
}