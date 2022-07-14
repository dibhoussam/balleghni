<?php

namespace App\Repositories;

use App\Interfaces\CommuneRepositoryInterface;
use App\Models\Wilaya;
use App\Models\Daira;
use App\Models\Commune;

class CommuneRepository implements CommuneRepositoryInterface 
{
    public function getAllCommunes()
    {
        return Commune::orderBy('id')
          ->withRestFilters()
          ->get();
    }

    public function getCommuneById($communeId)
    {
        return Commune::where('id', $communeId)
          ->orderBy('id')
          ->get();
    }
}
