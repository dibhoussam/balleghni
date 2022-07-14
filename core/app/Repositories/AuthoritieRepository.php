<?php

namespace App\Repositories;

use Illuminate\Database\Eloquent\Builder;

use App\Events\AuthoritieCreatedEvent;
use App\Events\AuthoritieDeletedEvent;
use Illuminate\Support\Facades\Event;

use App\Interfaces\AuthoritieRepositoryInterface;
use App\Models\Authoritie;
use App\Models\AuthoritieBranch;
use App\Models\AuthoritieBranchPhone;
use App\Models\Location;
use App\Models\Wilaya;
use App\Models\Daira;
use App\Models\Commune;

use Illuminate\Support\Facades\DB;

class AuthoritieRepository implements AuthoritieRepositoryInterface 
{
    public function getAllAuthorities() 
    {
        return Authoritie::with([
            'branchs',
            'branchs.location',
            'branchs.location.wilaya',
            'branchs.location.daira',
            'branchs.location.commune',
            'branchs.phones',
            'announces' => function($query) {
                return $query->orderBy('created_at');
            },
            'incidentTypes',
        ])->orderBy('name')
          ->withRestFilters()
          ->paginate(10);
    }

    public function getAllAuthoritiesWithOutPagination() 
    {
        return Authoritie::with([
            'branchs',
            'branchs.location',
            'branchs.location.wilaya',
            'branchs.location.daira',
            'branchs.location.commune',
            'branchs.phones',
            'announces' => function($query) {
                return $query->orderBy('created_at');
            },
            'incidentTypes',
        ])->orderBy('name')
          ->withRestFilters()
          ->get();
    }

    public function getAllAuthoritiesBranchs() 
    {
        return AuthoritieBranch::with([
            'location',
            'location.wilaya',
            'location.daira',
            'location.commune',
            'phones',
        ])->orderBy('id')
          ->withRestFilters()
          ->paginate(10);
    }

    public function getAllAuthoritiesBranchsWithoutPagination() 
    {
        return AuthoritieBranch::with([
            'location',
            'location.wilaya',
            'location.daira',
            'location.commune',
            'phones',
        ])->orderBy('id')
          ->withRestFilters()
          ->get();
    }

    public function getAuthoritieById($authoritieId) 
    {
        return Authoritie::with([
            'branchs',
            'branchs.location',
            'branchs.location.wilaya',
            'branchs.location.daira',
            'branchs.location.commune',
            'branchs.phones',
            'announces' => function($query) {
                return $query->orderBy('created_at');
            },
        ])->findOrFail($authoritieId);
    }

    public function getAuthoritiesByWilayaIds($wilayaIds)
    {
        $result = [ 'wilayas' => [] ];
        foreach($wilayaIds as $wilayaId) {
            $wilayaName = Wilaya::select('name')->where('id', $wilayaId)->first()['name'];
            $wilayaIdInTable = [$wilayaId];
            $result['wilayas'] += [
                ''. $wilayaName .'' => Authoritie::with([
                    'branchs' => function($query) use($wilayaIdInTable) {
                        return $query->whereHas('location.wilaya', function($query) use($wilayaIdInTable) {
                            return $query->whereIn('id', $wilayaIdInTable);
                        });
                    },
                    'branchs.location',
                    'branchs.location.wilaya',
                    'branchs.location.daira',
                    'branchs.location.commune',
                    'branchs.phones',
                    'announces' => function($query) {
                        return $query->orderBy('created_at');
                    },
                ])->whereHas('branchs', function($query) use($wilayaIdInTable) {
                    return $query->whereHas('location.wilaya', function($query) use($wilayaIdInTable) {
                        return $query->whereIn('id', $wilayaIdInTable);
                    });
                })->get()
            ];
        }
        return $result;
    }

    public function getAuthoritiesByDairaIds($dairaIds)
    {
        $result = [ 'dairas' => [] ];
        foreach($dairaIds as $dairaId) {
            $dairaName = Daira::select('name')->where('id', $dairaId)->first()['name'];
            $dairaIdInTable = [$dairaId];
            $result['dairas'] += [
                ''. $dairaName .'' => Authoritie::with([
                    'branchs' => function($query) use($dairaIdInTable) {
                        return $query->whereHas('location.daira', function($query) use($dairaIdInTable) {
                            return $query->whereIn('id', $dairaIdInTable);
                        });
                    },
                    'branchs.location',
                    'branchs.location.wilaya',
                    'branchs.location.daira',
                    'branchs.location.commune',
                    'branchs.phones',
                    'announces' => function($query) {
                        return $query->orderBy('created_at');
                    },
                ])->whereHas('branchs', function($query) use($dairaIdInTable) {
                    return $query->whereHas('location.daira', function($query) use($dairaIdInTable) {
                        return $query->whereIn('id', $dairaIdInTable);
                    });
                })->get()
            ];
        }
        return $result;
    }

    public function getAuthoritiesByCommuneIds($communeIds)
    {
        $result = [ 'communes' => [] ];
        foreach($communeIds as $communeId) {
            $communeName = Commune::select('name')->where('id', $communeId)->first()['name'];
            $communeIdInTable = [$communeId];
            $result['communes'] += [
                ''. $communeName .'' => Authoritie::with([
                    'branchs' => function($query) use($communeIdInTable) {
                        return $query->whereHas('location.commune', function($query) use($communeIdInTable) {
                            return $query->whereIn('id', $communeIdInTable);
                        });
                    },
                    'branchs.location',
                    'branchs.location.wilaya',
                    'branchs.location.daira',
                    'branchs.location.commune',
                    'branchs.phones',
                    'announces' => function($query) {
                        return $query->orderBy('created_at');
                    },
                ])->whereHas('branchs', function($query) use($communeIdInTable) {
                    return $query->whereHas('location.commune', function($query) use($communeIdInTable) {
                        return $query->whereIn('id', $communeIdInTable);
                    });
                })->get()
            ];
        }
        return $result;
    }

    public function getAuthoritieBranchsByWilayaIds($authoritieId, $wilayaIds)
    {
        $result = [ 'wilayas' => [] ];
        foreach($wilayaIds as $wilayaId) {
            $wilayaName = Wilaya::select('name')->where('id', $wilayaId)->first()['name'];
            $wilayaIdInTable = [$wilayaId];
            $result['wilayas'] += [
                ''. $wilayaName .'' => AuthoritieBranch::with([
                    'location' => function($query) use($wilayaIdInTable) {
                        return $query->whereIn('wilaya_id', $wilayaIdInTable);
                    },
                    'location.wilaya',
                    'location.daira',
                    'location.commune',
                    'phones',
                ])->where('authoritie_id', $authoritieId)
                  ->whereHas('location', function($query) use($wilayaIdInTable) {
                    return $query->whereIn('wilaya_id', $wilayaIdInTable);
                })->get()
            ];
        }
        return $result;
    }

    public function getAuthoritieBranchsByDairaIds($authoritieId, $dairaIds)
    {
        $result = [ 'dairas' => [] ];
        foreach($dairaIds as $dairaId) {
            $dairaName = Daira::select('name')->where('id', $dairaId)->first()['name'];
            $dairaIdInTable = [$dairaId];
            $result['dairas'] += [
                ''. $dairaName .'' => AuthoritieBranch::with([
                    'location' => function($query) use($dairaIdInTable) {
                        return $query->whereIn('daira_id', $dairaIdInTable);
                    },
                    'location.wilaya',
                    'location.daira',
                    'location.commune',
                    'phones',
                ])->where('authoritie_id', $authoritieId)
                  ->whereHas('location', function($query) use($dairaIdInTable) {
                    return $query->whereIn('daira_id', $dairaIdInTable);
                })->get()
            ];
        }
        return $result;
    }

    public function getAuthoritieBranchsByCommuneIds($authoritieId, $communeIds)
    {
        $result = [ 'communes' => [] ];
        foreach($communeIds as $communeId) {
            $communeName = Commune::select('name')->where('id', $communeId)->first()['name'];
            $communeIdInTable = [$communeId];
            $result['communes'] += [
                ''. $communeName .'' => AuthoritieBranch::with([
                    'location' => function($query) use($communeIdInTable) {
                        return $query->whereIn('commune_id', $communeIdInTable);
                    },
                    'location.wilaya',
                    'location.daira',
                    'location.commune',
                    'phones',
                ])->where('authoritie_id', $authoritieId)
                  ->whereHas('location', function($query) use($communeIdInTable) {
                    return $query->whereIn('commune_id', $communeIdInTable);
                })->get()
            ];
        }
        return $result;
    }

    public function getAuthoritieBranchById($authoritieBranchId)
    {
        return AuthoritieBranch::with([
            'authoritie',
            'location',
            'location.wilaya',
            'location.daira',
            'location.commune',
            'phones',
        ])->findOrFail($authoritieBranchId);
    }

    public function deleteAuthoritie($authoritieId)
    {
        $authoritie = Authoritie::findOrFail($authoritieId);
        
        Authoritie::destroy($authoritieId);

        event(new AuthoritieDeletedEvent($authoritie));
    }

    public function deleteAuthoritieBranch($authoritieBranchId)
    {
        AuthoritieBranch::destroy($authoritieBranchId);
    }

    public function createAuthoritie(array $authoritieDetails)
    {
        $authoritie = Authoritie::create($authoritieDetails);

        event(new AuthoritieCreatedEvent($authoritie));

        return $authoritie;
    }

    public function createAuthoritieBranchForAuthoritie($authoritieId, array $authoritieBranchDetails)
    {
        // *** ATOMIC BEGIN ***
        try {
            DB::beginTransaction();

            if($authoritieBranchDetails['wilaya_id'] != Commune::where('id', $authoritieBranchDetails['commune_id'])->first()->daira()->first()->wilaya()->first()->id) {
                




                throw new Exception('unknown error');
            


            
            
            }
            
            $location = Location::firstOrCreate([
                'wilaya_id'    => $authoritieBranchDetails['wilaya_id'],
                'daira_id'     => $authoritieBranchDetails['daira_id'],
                'commune_id'   => $authoritieBranchDetails['commune_id'],
                'address'      => $authoritieBranchDetails['address'],
            ]);

            $authoritieBranch = AuthoritieBranch::create([
                'authoritie_id'     => $authoritieId,
                'location_id'       => $location->id,
                'dg'                => $authoritieBranchDetails['dg'],
                'map_link'          => $authoritieBranchDetails['map_link'],
                'email'             => $authoritieBranchDetails['email'],
            ]);
            
            if(isset($authoritieBranchDetails['phones']))
                foreach($authoritieBranchDetails['phones'] as $phone) {
                    $phone = array_merge($phone, ['authoritieBranch_id' => $authoritieBranch->id]);
                    $authoritieBranch->phones()
                                        ->save(AuthoritieBranchPhone::create($phone));
                }
            
            $this->getAuthoritieById($authoritieId)
                    ->branchs()
                        ->save($authoritieBranch);
            
            DB::commit();
        } catch (Throwable $e) {
            report($e);            
            DB::rollBack();   
        }
        // *** ATOMIC END ***

        return $authoritieBranch;
    }

    public function updateAuthoritie($authoritieId, array $newDetails)
    {
        return Authoritie::whereId($authoritieId)->update($newDetails);
    }

    public function updateAuthoritieBranch($authoritieBranchId, array $newDetails)
    {
        // *** ATOMIC BEGIN ***
        try {
            DB::beginTransaction();

            if($newDetails['wilaya_id'] != Commune::where('id', $newDetails['commune_id'])->first()->daira()->first()->wilaya()->first()->id) {
                throw new Exception('unknown error');
            }
            
            $location = Location::whereId(AuthoritieBranch::where('id', $authoritieBranchId)->first()['location_id'])->update([
                'wilaya_id'    => $newDetails['wilaya_id'],
                'daira_id'     => $newDetails['daira_id'],
                'commune_id'   => $newDetails['commune_id'],
                'address'      => $newDetails['address'],
            ]);

            $authoritieBranch = AuthoritieBranch::whereId($authoritieBranchId)->update([
                'dg'                => $newDetails['dg'],
                'map_link'          => $newDetails['map_link'],
                'email'             => $newDetails['email'],
            ]);

            $authoritieBranch = AuthoritieBranch::whereId($authoritieBranchId)->first();
            
            $authoritieBranch->phones()->delete();

            foreach($newDetails['phones'] as $phone) {
                $phone = array_merge($phone, ['authoritieBranch_id' => $authoritieBranch->id]);
                $authoritieBranch->phones()
                                    ->save(AuthoritieBranchPhone::create($phone));
            }
            
            $this->getAuthoritieById($authoritieBranch->authoritie_id)
                    ->branchs()
                        ->save($authoritieBranch);
            
            DB::commit();
        } catch (Throwable $e) {
            report($e);            
            DB::rollBack();   
        }
        // *** ATOMIC END ***

        return $authoritieBranch;
    }
}
