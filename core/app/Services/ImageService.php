<?php

namespace App\Services;

use App\Interfaces\ImageServiceInterface;

use App\Traits\ConsumeExternalService;

class ImageService implements ImageServiceInterface
{
    use ConsumeExternalService;

    /**
     * The base uri to consume users service
     * @var string
     */
    public $baseUri;

    /**
     * Authorization secret to pass to user api
     * @var string
     */
    public $secret;

    public function __construct()
    {
        $this->baseUri = config('services.stats.base_uri');
        //$this->secret = config('services.users.secret');
    }

    public function deleteImages($images)
    {
        $this->performDeleteImageRequest($images);
        return 1;
    }
}