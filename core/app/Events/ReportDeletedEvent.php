<?php

namespace App\Events;

use App\Models\Report;

class ReportDeletedEvent extends Event
{
    /**
     * The order instance.
     *
     * @var \App\Models\Report
     */
    public $report;
 
    /**
     * Create a new event instance.
     *
     * @param  \App\Models\Report  $report
     * @return void
     */
    public function __construct(Report $report)
    {
        $this->report = $report;
    }
}
