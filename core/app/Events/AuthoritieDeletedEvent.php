<?php

namespace App\Events;

use App\Models\Authoritie;

class AuthoritieDeletedEvent extends Event
{
    /**
     * The order instance.
     *
     * @var \App\Models\Authoritie
     */
    public $authoritie;
 
    /**
     * Create a new event instance.
     *
     * @param  \App\Models\Authoritie  $authoritie
     * @return void
     */
    public function __construct(Authoritie $authoritie)
    {
        $this->authoritie = $authoritie;
    }
}
