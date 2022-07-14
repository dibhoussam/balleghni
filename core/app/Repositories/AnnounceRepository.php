<?php

namespace App\Repositories;

use App\Interfaces\AnnounceRepositoryInterface;
use App\Models\Announce;
use App\Models\Authoritie;

class AnnounceRepository implements AnnounceRepositoryInterface 
{
    public function getAllAnnouncesWithAuthoritie()
    {
        return Announce::with([
            'authoritie',
        ])->orderBy('created_at', 'DESC')
          ->withRestFilters()
          ->paginate(10);
    }

    public function getAllAnnouncesWithAuthoritieWithOutPagination()
    {
        return Announce::with([
            'authoritie',
        ])->orderBy('created_at', 'DESC')
          ->withRestFilters()
          ->get();
    }

    public function getAnnounceWithAuthoritieById($announceId)
    {
        return Announce::with([
            'authoritie',
        ])->findOrFail($announceId);
    }

    public function getAnnouncesByAuthoritieId($authoritieId)
    {
        return Announce::with([
            'authoritie',
        ])->where('authoritie_id', $authoritieId)
          ->orderBy('created_at')
          ->paginate(10);
    }

    public function getAnnouncesByAuthoritieIdWithOutPagination($authoritieId)
    {
        return Announce::with([
            'authoritie',
        ])->where('authoritie_id', $authoritieId)
          ->orderBy('created_at')
          ->get();
    }

    public function deleteAnnounce($announceId)
    {
        Announce::destroy($announceId);
    }

    public function createAnnounce($authoritieId, array $announceDetails)
    {
        //$announceDetails = array_merge($announceDetails, [ 'authoritie_id' => $authoritieId]);
        return Announce::create($announceDetails);
    }

    public function updateAnnounce($announceId, array $newDetails)
    {
        return Announce::whereId($announceId)->update($newDetails);
    }
}
