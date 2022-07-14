<?php

namespace App\Http\Controllers;

use Laravel\Lumen\Routing\Controller as BaseController;

use Illuminate\Support\Facades\Validator;

use App\Interfaces\UserServiceInterface;
use App\Interfaces\ReportRepositoryInterface;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

use App\Traits\ApiResponser;

class ReportController extends BaseController
{
    use ApiResponser;
    
    private ReportRepositoryInterface $reportRepository;
    private UserServiceInterface $userService;

    public function __construct(ReportRepositoryInterface $reportRepository, UserServiceInterface $userService) 
    {
        $this->reportRepository = $reportRepository;
        $this->userService = $userService;
    }

    public function index(Request $request): JsonResponse 
    {
        $authUser = $request->authUser;
        if(isset($authUser['token']['wilaya']))
            return $this->successResponse($this->reportRepository->getReportsByWilayasIds(array($authUser['token']['wilaya'])));
        else if(isset($authUser['token']['authoritie']))
            return $this->successResponse($this->reportRepository->getReportsByAuthoritiesIds(array($authUser['token']['authoritie'])));
        else if(isset($authUser['token']['citoyen']))
            return $this->successResponse($this->reportRepository->getReportsByUsersIds(array($authUser['sub'])));
        else if(isset($authUser['token']['superadmin']))
            return $this->successResponse($this->reportRepository->getAllReports());
        return $this->errorResponse('Unauthorized.', 401);
    }

    public function indexWithOutPagination(Request $request): JsonResponse 
    {
        $authUser = $request->authUser;
        if(isset($authUser['token']['wilaya']))
            return $this->successResponse($this->reportRepository->getReportsByWilayasIdsWithOutPagination(array($authUser['token']['wilaya'])));
        else if(isset($authUser['token']['authoritie']))
            return $this->successResponse($this->reportRepository->getReportsByAuthoritiesIdsWithOutPagination(array($authUser['token']['authoritie'])));
        else if(isset($authUser['token']['citoyen']))
            return $this->successResponse($this->reportRepository->getReportsByUsersIdsWithOutPagination(array($authUser['sub'])));
        else if(isset($authUser['token']['superadmin']))
            return $this->successResponse($this->reportRepository->getAllReportsWithOutPagination());
        return $this->errorResponse('Unauthorized.', 401);
    }

    public function indexAll(Request $request): JsonResponse 
    {
        return $this->successResponse($this->reportRepository->getAllReports());
    }

    public function indexAllWithOutPagination(Request $request): JsonResponse 
    {
        return $this->successResponse($this->reportRepository->getAllReportsWithOutPagination());
    }

    public function store(Request $request): JsonResponse 
    {
        $userId = $request->authUser['sub'];

        $this->validate($request, [ 
            'description'               => 'required|string|max:255',
            'longitude'                 => 'required|numeric|max:255',
            'latitude'                  => 'required|numeric|max:255',
            'commune_id'                => 'required|integer|exists:communes,id',
            'daira_id'                  => 'required|integer|exists:dairas,id',
            'wilaya_id'                 => 'required|integer|exists:wilayas,id',
            'address'                   => 'required|string',
            'images'                    => 'required|array|max:3|min:1',
            'images.*.image'            => 'required|url',
            'images.*.delete_image'     => 'required|url',
            'images.*.thumbnail'        => 'required|url',
            'images.*.delete_thumbnail' => 'required|url',
            'incident_types'            => 'array|min:1',
            'incident_types.*'          => 'required|integer|exists:incident_types,id',
        ]);

        $reportDetails = $request->only([
            'description',
            'longitude',
            'latitude',
            'commune_id',
            'address',
            'wilaya_id',
            'daira_id',
            'images',
            'incident_types',
        ]);





        return $this->successResponse($this->reportRepository->createReport($userId, $reportDetails), Response::HTTP_CREATED);





    }

    public function show(Request $request): JsonResponse 
    {
        $validator = Validator::make(['report_id' => $request->route('id')], [
            'report_id' => 'required|integer|exists:reports,id',
        ]);

        if($validator->fails()) {  
            return $this->errorResponse($validator->errors(), 422);
        }

        $inputs = $validator->safe();

        return $this->successResponse($this->reportRepository->getReportById($inputs['report_id']));
    }

    public function showByIncidents(Request $request): JsonResponse 
    {
        $validator = Validator::make($request->all(), [
            'incidentType_id'   => 'required|array|min:1',
            'incidentType_id.*' => 'required|integer|exists:incident_types,id',
        ]);

        if($validator->fails()) {  
            return $this->errorResponse($validator->errors(), 422);
        }

        $inputs = $validator->safe();

        return $this->successResponse($this->reportRepository->getReportsByIncidentTypesIds($inputs['incidentType_id']));
    }

    public function showByIncidentsWithOutPagination(Request $request): JsonResponse 
    {
        $validator = Validator::make($request->all(), [
            'incidentType_id'   => 'required|array|min:1',
            'incidentType_id.*' => 'required|integer|exists:incident_types,id',
        ]);

        if($validator->fails()) {  
            return $this->errorResponse($validator->errors(), 422);
        }

        $inputs = $validator->safe();

        return $this->successResponse($this->reportRepository->getReportsByIncidentTypesIdsWithOutPagination($inputs['incidentType_id']));
    }

    public function showByAuthorities(Request $request): JsonResponse 
    {
        $validator = Validator::make($request->all(), [
            'authoritie_id'   => 'required|array|min:1',
            'authoritie_id.*' => 'required|integer|exists:authorities,id'
        ]);

        if($validator->fails()) {  
            return $this->errorResponse($validator->errors(), 422);
        }

        $inputs = $validator->safe();

        return $this->successResponse($this->reportRepository->getReportsByAuthoritiesIds($inputs['authoritie_id']));
    }

    public function showByAuthoritiesWithOutPagination(Request $request): JsonResponse 
    {
        $validator = Validator::make($request->all(), [
            'authoritie_id'   => 'required|array|min:1',
            'authoritie_id.*' => 'required|integer|exists:authorities,id'
        ]);

        if($validator->fails()) {  
            return $this->errorResponse($validator->errors(), 422);
        }

        $inputs = $validator->safe();

        return $this->successResponse($this->reportRepository->getReportsByAuthoritiesIdsWithOutPagination($inputs['authoritie_id']));
    }

    public function showNearBy(Request $request): JsonResponse 
    {
        $validator = Validator::make($request->all(), [
            'longitude'                 => 'required|numeric|max:255',
            'latitude'                  => 'required|numeric|max:255',
        ]);

        if($validator->fails()) {  
            return $this->errorResponse($validator->errors(), 422);
        }

        $inputs = $validator->safe();

        return $this->successResponse($this->reportRepository->getReportsNearBy($inputs['latitude'], $inputs['longitude']));
    }

    public function update(Request $request): JsonResponse 
    {
        $reportId = $request->route('id');
        
        $validator = Validator::make(array_merge($request->all(), ['report_id' => $reportId]), [
            'report_id'                 => 'required|integer|exists:reports,id',
            'global_status'             => 'required|integer|min:0|max:3',
            'comment'                   => 'string|max:255',
        ]);

        if($validator->fails()) {  
            return $this->errorResponse($validator->errors(), 422);
        }

        # Check Permission #
        $authoritieId = ( isset($request->authUser['superadmin']) ? $request->authUser['superadmin'] : ( isset($request->authUser['wilaya']) ? $request->authUser['wilaya'] : ( isset($request->authUser['authoritie']) ? $request->authUser['authoritie'] : 0 ) ) );

        if(!$authoritieId) {
            return $this->errorResponse('Unauthorized.', 401);
        }

        #if(isset($request->authUser['citoyen']) && $this->reportRepository->getReportById($reportId)->user_id != $request->authUser['sub']) {
        #    return $this->errorResponse('Unauthorized.', 401);
        #}
        if(!isset($request->authUser['superadmin']) && $this->reportRepository->getReportById($reportId)->incidentTypes()->first()->authoritie->id != $authoritieId) {
            return $this->errorResponse('Unauthorized.', 401);
        }
        #####################

        $reportDetails = $request->only([
            'global_status',
            'comment'
        ]);

        return $this->successResponse($this->reportRepository->updateReport($reportId, $reportDetails));
    }

    public function destroy(Request $request): JsonResponse 
    {
        $reportId = $request->route('id');

        $validator = Validator::make(['report_id' => $reportId], [
            'report_id' => 'required|integer|exists:reports,id',
        ]);

        if($validator->fails()) {  
            return $this->errorResponse($validator->errors(), 422);
        }

        # Check Permission #
        $authoritieId = ( isset($request->authUser['superadmin']) ? $request->authUser['superadmin'] : ( isset($request->authUser['wilaya']) ? $request->authUser['wilaya'] : ( isset($request->authUser['authoritie']) ? $request->authUser['authoritie'] : ( isset($request->authUser['citoyen']) ? $request->authUser['citoyen'] : 0 ) ) ) );

        if(!$authoritieId) {
            return $this->errorResponse('Unauthorized.', 401);
        }

        if(isset($request->authUser['citoyen']) && $this->reportRepository->getReportById($reportId)->user_id != $request->authUser['sub']) {
            return $this->errorResponse('Unauthorized.', 401);
        }
        else if(!isset($request->authUser['superadmin']) && $this->reportRepository->getReportById($reportId)->incidentTypes()->first()->authoritie->id != $authoritieId) {
            return $this->errorResponse('Unauthorized.', 401);
        }
        #####################

        $this->reportRepository->deleteReport($reportId);

        return $this->successResponse(null, Response::HTTP_NO_CONTENT);
    }
}