<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;

use App\Interfaces\AuthoritieRepositoryInterface;
use App\Interfaces\AnnounceRepositoryInterface;
use App\Interfaces\IncidentTypeRepositoryInterface;
use App\Interfaces\ReportRepositoryInterface;
use App\Interfaces\WilayaRepositoryInterface;
use App\Interfaces\DairaRepositoryInterface;
use App\Interfaces\CommuneRepositoryInterface;

use App\Repositories\AuthoritieRepository;
use App\Repositories\AnnounceRepository;
use App\Repositories\IncidentTypeRepository;
use App\Repositories\ReportRepository;
use App\Repositories\WilayaRepository;
use App\Repositories\DairaRepository;
use App\Repositories\CommuneRepository;

class RepositoryServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        $this->app->bind(AuthoritieRepositoryInterface::class, AuthoritieRepository::class);
        $this->app->bind(AnnounceRepositoryInterface::class, AnnounceRepository::class);
        $this->app->bind(IncidentTypeRepositoryInterface::class, IncidentTypeRepository::class);
        $this->app->bind(ReportRepositoryInterface::class, ReportRepository::class);
        $this->app->bind(WilayaRepositoryInterface::class, WilayaRepository::class);
        $this->app->bind(DairaRepositoryInterface::class, DairaRepository::class);
        $this->app->bind(CommuneRepositoryInterface::class, CommuneRepository::class);
    }
}
