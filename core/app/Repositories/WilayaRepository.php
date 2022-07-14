<?php

namespace App\Repositories;

use App\Interfaces\WilayaRepositoryInterface;
use App\Models\Wilaya;
use App\Models\Daira;
use App\Models\Commune;

class WilayaRepository implements WilayaRepositoryInterface 
{
    public function getAllWilayas()
    {
        return Wilaya::with([
            'dairas',
            'dairas.communes'
        ])->orderBy('id')
          ->withRestFilters()
          ->get();
    }

    public function getWilayaById($wilayaId)
    {
        return Wilaya::with([
            'dairas',
            'dairas.communes'
        ])->where('id', $wilayaId)
          ->orderBy('id')
          ->get();
    }
}
