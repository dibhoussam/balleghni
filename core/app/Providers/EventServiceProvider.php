<?php

namespace App\Providers;

use App\Events\AuthoritieCreatedEvent;
use App\Listeners\AuthoritieCreatedListener;

use App\Events\AuthoritieDeletedEvent;
use App\Listeners\AuthoritieDeletedListener;

use App\Events\ReportDeletedEvent;
use App\Listeners\ReportDeletedListener;

use Laravel\Lumen\Providers\EventServiceProvider as ServiceProvider;

class EventServiceProvider extends ServiceProvider
{
    /**
     * The event listener mappings for the application.
     *
     * @var array
     */
    protected $listen = [
        AuthoritieCreatedEvent::class => [
            AuthoritieCreatedListener::class,
        ],
        AuthoritieDeletedEvent::class => [
            AuthoritieDeletedListener::class,
        ],
        ReportDeletedEvent::class => [
            ReportDeletedListener::class,
        ]
    ];

    /**
     * Register any other events for your application.
     */
    public function boot()
    {
        parent::boot();
    }
}
