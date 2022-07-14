<?php

namespace App\Interfaces;

interface AuthoritieRepositoryInterface 
{
    public function getAllAuthorities();
    public function getAllAuthoritiesWithOutPagination();
    public function getAllAuthoritiesBranchs();
    public function getAllAuthoritiesBranchsWithoutPagination();
    public function getAuthoritieById($authoritieId);

    public function getAuthoritiesByWilayaIds($wilayaIds);
    public function getAuthoritiesByDairaIds($dairaIds);
    public function getAuthoritiesByCommuneIds($communeIds);

    public function getAuthoritieBranchsByWilayaIds($authoritieId, $wilayaIds);
    public function getAuthoritieBranchsByDairaIds($authoritieId, $dairaIds);
    public function getAuthoritieBranchsByCommuneIds($authoritieId, $dairaIds);

    public function getAuthoritieBranchById($authoritieBranchId);

    public function deleteAuthoritie($authoritieId);
    public function deleteAuthoritieBranch($authoritieBranchId);
    
    public function createAuthoritie(array $authoritieDetails);
    public function createAuthoritieBranchForAuthoritie($authoritieId, array $authoritieBranchDetails);
    
    public function updateAuthoritie($authoritieId, array $newDetails);
    public function updateAuthoritieBranch($authoritieBranchId, array $newDetails);
}
