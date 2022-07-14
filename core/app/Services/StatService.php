<?php

namespace App\Services;

use App\Interfaces\StatServiceInterface;

use App\Traits\ConsumeExternalService;

class StatService implements StatServiceInterface
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

    public function createAuthoritieDashboard($authoritie)
    {
        $this->performCreateAuthoritieDashboardRequest($authoritie, 'POST', "/api/v1/dashboard/import/");
        return 1;
    }

    public function createWilayaDashboard($authoritie)
    {
        $this->performCreateWilayaDashboardRequest($authoritie, 'POST', "/api/v1/dashboard/import/");
        return 1;
    }

    public function deleteDashboard($authoritie)
    {
        $this->performDeleteDashboardRequest($authoritie, 'POST', "/api/v1/dashboard/import/");
        return 1;
    }
}