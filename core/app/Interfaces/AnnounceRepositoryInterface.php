<?php

namespace App\Interfaces;

interface AnnounceRepositoryInterface 
{
    public function getAllAnnouncesWithAuthoritie();
    public function getAllAnnouncesWithAuthoritieWithOutPagination();

    public function getAnnounceWithAuthoritieById($announceId);
    public function getAnnouncesByAuthoritieId($authoritieId);
    public function getAnnouncesByAuthoritieIdWithOutPagination($authoritieId);

    public function deleteAnnounce($announceId);
    
    public function createAnnounce($authoritieId, array $announceDetails);
    
    public function updateAnnounce($announceId, array $newDetails);
}
