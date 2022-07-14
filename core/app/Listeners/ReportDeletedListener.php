<?php

namespace App\Listeners;

use App\Events\ReportDeletedEvent;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Queue\InteractsWithQueue;
use App\Interfaces\ImageServiceInterface;

class ReportDeletedListener
{
    protected $imageService;
    /**
     * Create the event listener.
     *
     * @return void
     */
    public function __construct(ImageServiceInterface $imageService)
    {
        $this->imageService = $imageService;
    }

    /**
     * Handle the event.
     *
     * @param  \App\Events\ReportDeletedEvent  $event
     * @return void
     */
    public function handle(ReportDeletedEvent $event)
    {
        $this->imageService->deleteImages($event->report->images);
    }
}
