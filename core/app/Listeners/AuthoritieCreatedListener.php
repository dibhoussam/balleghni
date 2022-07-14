<?php

namespace App\Listeners;

use App\Events\AuthoritieCreatedEvent;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Queue\InteractsWithQueue;
use App\Interfaces\StatServiceInterface;

class AuthoritieCreatedListener
{
    protected $statService;
    /**
     * Create the event listener.
     *
     * @return void
     */
    public function __construct(StatServiceInterface $statService)
    {
        $this->statService = $statService;
    }

    /**
     * Handle the event.
     *
     * @param  \App\Events\AuthoritieCreatedEvent  $event
     * @return void
     */
    public function handle(AuthoritieCreatedEvent $event)
    {
        if($event->authoritie->id > 100)
            $this->statService->createAuthoritieDashboard($event->authoritie);
        else
            $this->statService->createWilayaDashboard($event->authoritie);
    }
}
