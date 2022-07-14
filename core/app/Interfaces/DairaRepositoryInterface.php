<?php

namespace App\Interfaces;

interface DairaRepositoryInterface 
{
    public function getAllDairas();

    public function getDairaById($dairaId);
}
