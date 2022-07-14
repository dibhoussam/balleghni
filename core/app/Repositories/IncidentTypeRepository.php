<?php

namespace App\Repositories;

use App\Interfaces\IncidentTypeRepositoryInterface;
use App\Models\IncidentType;
use App\Models\Authoritie;

class IncidentTypeRepository implements IncidentTypeRepositoryInterface 
{
    public function getAllIncidentTypes()
    {
        return IncidentType::with('authoritie')->orderBy('title')->withRestFilters()
        ->get();
    }

    public function getIncidentTypeById($incidentTypeId)
    {
        return IncidentType::with('authoritie')->where('id', $incidentTypeId)->orderBy('title')->first();
    }

    public function deleteIncidentType($incidentTypeId)
    {
        IncidentType::destroy($incidentTypeId);
    }

    public function createIncidentType(array $incidentTypeDetails)
    {
        return IncidentType::create($incidentTypeDetails);
    }

    public function updateIncidentType($incidentTypeId, array $newDetails)
    {
        return IncidentType::whereId($incidentTypeId)->update($newDetails);
    }
}
