<?php

namespace App\Http\Controllers;

use Laravel\Lumen\Routing\Controller as BaseController;

use App\Interfaces\IncidentTypeRepositoryInterface;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

use App\Traits\ApiResponser;

use Illuminate\Support\Facades\Validator;

class IncidentTypeController extends BaseController
{
    use ApiResponser;

    private IncidentTypeRepositoryInterface $incidentTypeRepository;

    public function __construct(IncidentTypeRepositoryInterface $incidentTypeRepository) 
    {
        $this->incidentTypeRepository = $incidentTypeRepository;
    }

    public function index(): JsonResponse 
    {
        return $this->successResponse($this->incidentTypeRepository->getAllIncidentTypes());
    }

    public function store(Request $request): JsonResponse 
    {
        # Check Permission #
        $authoritieId = ( isset($request->authUser['superadmin']) ? $request->authUser['superadmin'] : ( isset($request->authUser['wilaya']) ? $request->authUser['wilaya'] : ( isset($request->authUser['authoritie']) ? $request->authUser['authoritie'] : 0 ) ) );
        ####################

        if(!$authoritieId) {
            return $this->errorResponse('Unauthorized.', 401);
        }

        $this->validate($request, [
            'title'                => 'required|string|max:255',
            'slug'                 => 'required|alpha_dash|unique:incident_types,slug',
            'description'          => 'required|string|max:255',
            'icon'                 => 'url',
            'authoritie_id'        => 'required|integer|exists:authorities,id',
        ]);

        $incidentTypeDetails = $request->only([
            'title',
            'slug',
            'description',
            'icon',
            'authoritie_id',
        ]);

        return $this->successResponse($this->incidentTypeRepository->createIncidentType($incidentTypeDetails), Response::HTTP_CREATED);
    }

    public function show(Request $request): JsonResponse 
    {
        $validator = Validator::make(['incidentType_id' => $request->route('id')], [
            'incidentType_id' => 'required|integer|exists:incident_types,id',
        ]);

        if($validator->fails()) {  
            return $this->errorResponse($validator->errors(), 422);
        }

        $inputs = $validator->safe();

        return $this->successResponse($this->incidentTypeRepository->getIncidentTypeById($inputs['incidentType_id']));
    }

    public function update(Request $request): JsonResponse 
    {
        $incidentTypeId = $request->route('id');
        
        $validator = Validator::make(array_merge($request->all(), ['incidentType_id' => $incidentTypeId]), [
            'incidentType_id'          => 'required|integer|exists:incident_types,id',
            'title'                    => 'required|string|max:255',
            'description'              => 'string|max:255',
            'icon'                     => 'url',
            'authoritie_id'            => 'integer|exists:authorities,id',
        ]);

        if($validator->fails()) {  
            return $this->errorResponse($validator->errors(), 422);
        }

        # Check Permission #
        $authoritieId = ( isset($request->authUser['superadmin']) ? $request->authUser['superadmin'] : ( isset($request->authUser['wilaya']) ? $request->authUser['wilaya'] : ( isset($request->authUser['authoritie']) ? $request->authUser['authoritie'] : 0 ) ) );

        if(!$authoritieId) {
            return $this->errorResponse('Unauthorized.', 401);
        }

        if(!isset($request->authUser['superadmin']) && $this->incidentTypeRepository->getIncidentTypeById($incidentTypeId)->authoritie->id != $authoritieId) {
            return $this->errorResponse('Unauthorized.', 401);
        }
        #####################

        $incidentTypeDetails = $request->only([
            'title',
            'description',
            'icon',
            'authoritie_id',
        ]);

        return $this->successResponse($this->incidentTypeRepository->updateIncidentType($incidentTypeId, $incidentTypeDetails));
    }

    public function destroy(Request $request): JsonResponse 
    {
        $incidentTypeId = $request->route('id');

        $validator = Validator::make(['incidentType_id' => $incidentTypeId], [
            'incidentType_id' => 'required|integer|exists:incident_types,id',
        ]);

        if($validator->fails()) {  
            return $this->errorResponse($validator->errors(), 422);
        }

        # Check Permission #
        $authoritieId = ( isset($request->authUser['superadmin']) ? $request->authUser['superadmin'] : ( isset($request->authUser['wilaya']) ? $request->authUser['wilaya'] : ( isset($request->authUser['authoritie']) ? $request->authUser['authoritie'] : 0 ) ) );

        if(!$authoritieId) {
            return $this->errorResponse('Unauthorized.', 401);
        }

        if(!isset($request->authUser['superadmin']) && !isset($request->authUser['wilaya']) && $this->incidentTypeRepository->getIncidentTypeById($incidentTypeId)->authoritie->id != $authoritieId) {
            return $this->errorResponse('Unauthorized.', 401);
        }
        #####################

        $this->incidentTypeRepository->deleteIncidentType($incidentTypeId);

        return $this->successResponse(null, Response::HTTP_NO_CONTENT);
    }
}
