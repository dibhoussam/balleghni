<?php

namespace App\Interfaces;

interface ReportRepositoryInterface 
{
    public function getAllReports();
    public function getAllReportsWithOutPagination();

    public function getReportById($reportId);
    public function getReportsByIncidentTypesIds($incidentTypesIds);
    public function getReportsByIncidentTypesIdsWithOutPagination($incidentTypesIds);
    public function getReportsByAuthoritiesIds($authoritiesIds);
    public function getReportsByAuthoritiesIdsWithOutPagination($authoritiesIds);
    public function getReportsByUsersIds($userId);
    public function getReportsByUsersIdsWithOutPagination($userId);
    public function getReportsByWilayasIds($wilayaIds);
    public function getReportsByWilayasIdsWithOutPagination($wilayaIds);
    public function getReportsNearBy($latitude, $longitude);

    public function deleteReport($reportId);
    
    public function createReport($userId, array $reportDetails);
    
    public function updateReport($reportId, array $newDetails);
}
