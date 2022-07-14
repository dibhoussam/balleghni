<?php

namespace App\Interfaces;

interface CommuneRepositoryInterface 
{
    public function getAllCommunes();

    public function getCommuneById($communeId);
}
