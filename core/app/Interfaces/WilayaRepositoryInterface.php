<?php

namespace App\Interfaces;

interface WilayaRepositoryInterface 
{
    public function getAllWilayas();

    public function getWilayaById($wilayaId);
}
