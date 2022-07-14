<?php

namespace App\Services;

use App\Interfaces\UserServiceInterface;

use App\Traits\ConsumeExternalService;

class UserService implements UserServiceInterface
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
        $this->baseUri = config('services.users.base_uri');
        //$this->secret = config('services.users.secret');
    }

    /**
     * Get a single user data
     */
    public function obtainUser($token)
    {
        $this->secret = $token;
        return $this->performRequest('GET', "/auth/realms/ballighni/protocol/openid-connect/userinfo");
    }
}