<?php

namespace App\Listeners;

use App\Events\AuthoritieDeletedEvent;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Queue\InteractsWithQueue;
use App\Interfaces\StatServiceInterface;

class AuthoritieDeletedListener
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
     * @param  \App\Events\AuthoritieDeletedEvent  $event
     * @return void
     */
    public function handle(AuthoritieDeletedEvent $event)
    {
        $this->statService->deleteDashboard($event->authoritie);
    }
}
