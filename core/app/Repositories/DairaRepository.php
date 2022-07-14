<?php

namespace App\Repositories;

use App\Interfaces\DairaRepositoryInterface;
use App\Models\Wilaya;
use App\Models\Daira;
use App\Models\Commune;

class DairaRepository implements DairaRepositoryInterface 
{
    public function getAllDairas()
    {
        return Daira::with([
            'communes'
        ])->orderBy('id')
          ->withRestFilters()
          ->get();
    }

    public function getDairaById($dairaId)
    {
        return Daira::with([
            'communes'
        ])->where('id', $dairaId)
          ->orderBy('id')
          ->get();
    }
}
