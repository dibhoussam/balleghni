<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;

use App\Interfaces\StatServiceInterface;

use App\Services\StatService;

class StatServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        $this->app->bind(StatServiceInterface::class, StatService::class);
    }

    /**
     * Boot the authentication services for the application.
     *
     * @return void
     */
    public function boot()
    {
    }
}
