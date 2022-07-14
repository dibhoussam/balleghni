<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;

use App\Interfaces\ImageServiceInterface;

use App\Services\ImageService;

class ImageServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        $this->app->bind(ImageServiceInterface::class, ImageService::class);
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
