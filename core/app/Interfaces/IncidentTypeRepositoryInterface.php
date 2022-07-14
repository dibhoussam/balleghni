<?php

namespace App\Interfaces;

interface IncidentTypeRepositoryInterface 
{
    public function getAllIncidentTypes();

    public function getIncidentTypeById($incidentTypeId);

    public function deleteIncidentType($incidentTypeId);
    
    public function createIncidentType(array $incidentTypeDetails);
    
    public function updateIncidentType($IncidentTypeId, array $newDetails);
}