<?php

namespace App\Interfaces;

interface StatServiceInterface
{
    public function createAuthoritieDashboard($authoritie);
    public function createWilayaDashboard($authoritie);
    public function deleteDashboard($authoritie);
}
