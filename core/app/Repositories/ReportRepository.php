<?php

namespace App\Repositories;

use App\Interfaces\ReportRepositoryInterface;
use App\Models\Report;
use App\Models\Image;
use App\Models\IncidentType;
use App\Models\Location;
use App\Models\Commune;
use App\Models\Daira;
use App\Models\Wilaya;

use App\Events\ReportDeletedEvent;

use Exception;

use Illuminate\Support\Facades\DB;

class ReportRepository implements ReportRepositoryInterface 
{
    public function getAllReports()
    {
        return Report::with([
            'location',
            'location.wilaya',
            'location.daira',
            'location.commune',
            'incidentTypes',
            'incidentTypes.authoritie',
            'images'
        ])->orderBy('created_at', 'DESC')
          ->withRestFilters()
          ->paginate(10);
    }

    public function getAllReportsWithOutPagination()
    {
        return Report::with([
            'location',
            'location.wilaya',
            'location.daira',
            'location.commune',
            'incidentTypes',
            'incidentTypes.authoritie',
            'images'
        ])->orderBy('created_at', 'DESC')
          ->withRestFilters()
          ->get();
    }

    public function getReportById($reportId)
    {
        return Report::with([
            'location',
            'location.wilaya',
            'location.daira',
            'location.commune',
            'incidentTypes',
            'incidentTypes.authoritie',
            'images'
        ])->where('id', $reportId)->first();
    }

    public function getReportsByUsersIds($usersIds)
    {
        return Report::with([
            'location',
            'location.wilaya',
            'location.daira',
            'location.commune',
            'incidentTypes',
            'incidentTypes.authoritie',
            'images'
        ])->whereIn('user_id', $usersIds)
          ->orderBy('created_at', 'DESC')
          ->withRestFilters()
          ->paginate(10);
    }

    public function getReportsByUsersIdsWithOutPagination($usersIds)
    {
        return Report::with([
            'location',
            'location.wilaya',
            'location.daira',
            'location.commune',
            'incidentTypes',
            'incidentTypes.authoritie',
            'images'
        ])->whereIn('user_id', $usersIds)
          ->orderBy('created_at', 'DESC')
          ->withRestFilters()
          ->get();
    }

    public function getReportsByIncidentTypesIds($incidentTypesIds)
    {
        return Report::with([
            'location',
            'location.wilaya',
            'location.daira',
            'location.commune',
            'incidentTypes',
            'incidentTypes.authoritie',
            'images'
        ])->whereHas('incidentTypes', function($q) use($incidentTypesIds) {
            $q->whereIn('incident_types.id', $incidentTypesIds);
        })->orderBy('created_at')
          ->withRestFilters()
          ->paginate(10);
    }

    public function getReportsByIncidentTypesIdsWithOutPagination($incidentTypesIds)
    {
        return Report::with([
            'location',
            'location.wilaya',
            'location.daira',
            'location.commune',
            'incidentTypes',
            'incidentTypes.authoritie',
            'images'
        ])->whereHas('incidentTypes', function($q) use($incidentTypesIds) {
            $q->whereIn('incident_types.id', $incidentTypesIds);
        })->orderBy('created_at')
          ->withRestFilters()
          ->get();
    }

    public function getReportsByAuthoritiesIds($authoritiesIds)
    {
        return Report::with([
            'location',
            'location.wilaya',
            'location.daira',
            'location.commune',
            'incidentTypes',
            'incidentTypes.authoritie',
            'images'
        ])->whereHas('incidentTypes', function($q) use($authoritiesIds) {
            $q->whereIn('authoritie_id', $authoritiesIds);
        })->orderBy('created_at', 'DESC')
          ->withRestFilters()
          ->paginate(10);
    }

    public function getReportsByAuthoritiesIdsWithOutPagination($authoritiesIds)
    {
        return Report::with([
            'location',
            'location.wilaya',
            'location.daira',
            'location.commune',
            'incidentTypes',
            'incidentTypes.authoritie',
            'images'
        ])->whereHas('incidentTypes', function($q) use($authoritiesIds) {
            $q->whereIn('authoritie_id', $authoritiesIds);
        })->orderBy('created_at', 'DESC')
          ->withRestFilters()
          ->get();
    }

    public function getReportsByWilayasIds($wilayaIds)
    {
        return Report::with([
            'location',
            'location.wilaya',
            'location.daira',
            'location.commune',
            'incidentTypes',
            'incidentTypes.authoritie',
            'images'
        ])->whereHas('location', function($q) use($wilayaIds) {
            $q->whereIn('wilaya_id', $wilayaIds);
        })->orderBy('created_at', 'DESC')
          ->withRestFilters()
          ->paginate(10);
    }

    public function getReportsByWilayasIdsWithOutPagination($wilayaIds)
    {
        return Report::with([
            'location',
            'location.wilaya',
            'location.daira',
            'location.commune',
            'incidentTypes',
            'incidentTypes.authoritie',
            'images'
        ])->whereHas('location', function($q) use($wilayaIds) {
            $q->whereIn('wilaya_id', $wilayaIds);
        })->orderBy('created_at', 'DESC')
          ->withRestFilters()
          ->get();
    }

    public function getReportsNearBy($latitude, $longitude)
    {
        $reports = Report::get();
        $long_p1 = $longitude;
        $lat_p1 = $latitude;
        $reports_ids = [];

        foreach($reports as $report) {
            $long_p2 = $report->longitude;
            $lat_p2 = $report->latitude;

            if( 20 > atan(sqrt((cos($lat_p2)*sin(abs($long_p1 - $long_p2)))^2+(cos($lat_p1)*sin($lat_p2) - sin($lat_p1)*cos($lat_p2)*cos(abs($long_p1 - $long_p2)))^2)/(sin($lat_p1)*sin($lat_p2)+cos($lat_p1)*cos($lat_p2)*cos(abs($long_p1 - $long_p2)))) )
                $reports_ids = array_merge($reports_ids, [ $report->id ]);
        }

        return Report::with([
            'location',
            'location.wilaya',
            'location.daira',
            'location.commune',
            'incidentTypes',
            'incidentTypes.authoritie',
            'images'
        ])->whereIn('id', $reports_ids)
          ->get();
    }

    public function deleteReport($reportId)
    {
        $report = Report::with(['images'])->findOrFail($reportId);

        $report->images = $report->images()->get();

        event(new ReportDeletedEvent($report));

        Report::destroy($reportId);
    }

    public function createReport($userId, array $reportDetails)
    {
        // *** ATOMIC BEGIN ***
        try {
            DB::beginTransaction();

            if($reportDetails['wilaya_id'] != Commune::where('id', $reportDetails['commune_id'])->first()->daira()->first()->wilaya()->first()->id
                ||
               $reportDetails['wilaya_id'] != Daira::where('id', $reportDetails['daira_id'])->first()->wilaya()->first()->id
                ||
               $reportDetails['daira_id'] != Commune::where('id', $reportDetails['commune_id'])->first()->daira()->first()->id
            ) {





                throw new Exception('unknown error');
            


            
            
            }
            
            $location = Location::firstOrCreate([
                'wilaya_id'    => $reportDetails['wilaya_id'],
                'daira_id'     => $reportDetails['daira_id'],
                'commune_id'   => $reportDetails['commune_id'],
                'address'      => $reportDetails['address'],
            ]);

            $report = Report::firstOrCreate([
                'user_id'           => $userId,
                'location_id'       => $location->id,
                'description'       => $reportDetails['description'],
                'longitude'         => $reportDetails['longitude'],
                'latitude'          => $reportDetails['latitude'],
            ]);
            
            $report->incidentTypes()->saveMany(
                IncidentType::whereIn('id', $reportDetails['incident_types'])->get()
            );
            
            foreach($reportDetails['images'] as $image) {
                $report->images()->attach(Image::create($image));
            }
            
            DB::commit();
        } catch (Throwable $e) {
            report($e);            
            DB::rollBack();   
        }
        // *** ATOMIC END ***

        return $report;
    }

    public function updateReport($reportId, array $newDetails)
    {
        $report = Report::findOrFail($reportId);

        if(isset($newDetails['comment']) && $newDetails['comment'] != "" && !str_contains($newDetails['comment'], "\n~رد الوكالة المعنية~\n")) {
            if(str_contains($report->description, "\n~رد الوكالة المعنية~\n"))
                $report->description = explode("\n~رد الوكالة المعنية~\n", $report->description)[0];
            $report->description = $report->description . "\n~رد الوكالة المعنية~\n" . $newDetails['comment'];
        }

        unset($newDetails['comment']);
        $newDetails['description'] = $report->description;

        return Report::whereId($reportId)->update($newDetails);
    }
}
