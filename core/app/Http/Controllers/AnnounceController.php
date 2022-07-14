<?php

namespace App\Http\Controllers;

use Laravel\Lumen\Routing\Controller as BaseController;

use App\Interfaces\AnnounceRepositoryInterface;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

use App\Traits\ApiResponser;

use Illuminate\Support\Facades\Validator;

class AnnounceController extends BaseController
{
    use ApiResponser;

    private AnnounceRepositoryInterface $announceRepository;

    public function __construct(AnnounceRepositoryInterface $announceRepository) 
    {
        $this->announceRepository = $announceRepository;
    }

    public function index(): JsonResponse 
    {
        return $this->successResponse($this->announceRepository->getAllAnnouncesWithAuthoritie());
    }

    public function indexWithOutPagination(): JsonResponse 
    {
        return $this->successResponse($this->announceRepository->getAllAnnouncesWithAuthoritieWithOutPagination());
    }

    public function store(Request $request): JsonResponse 
    {
        # Check Permission #
        $authoritieId = ( isset($request->authUser['superadmin']) ? $request->authUser['superadmin'] : ( isset($request->authUser['wilaya']) ? $request->authUser['wilaya'] : ( isset($request->authUser['authoritie']) ? $request->authUser['authoritie'] : 0 ) ) );
        ####################
        
        if(!$authoritieId) {
            return $this->errorResponse('Unauthorized.', 401);
        }

        $validator = Validator::make(array_merge(['authoritie_id' => $authoritieId], $request->all()), [
            'title'                => 'required|string|max:255',
            'authoritie_id'        => 'required|integer|exists:authorities,id',
            'description'          => 'required|string|max:255',
            'file'                 => 'url',
        ]);

        $announceDetails = $request->only([
            'title',
            'authoritie_id',
            'description',
            'file',
        ]);

        return $this->successResponse($this->announceRepository->createAnnounce($announceDetails['authoritie_id'], $announceDetails), Response::HTTP_CREATED);
    }

    public function show(Request $request): JsonResponse 
    {
        $validator = Validator::make(['announce_id' => $request->route('id')], [
            'announce_id' => 'required|integer|exists:announces,id',
        ]);

        if($validator->fails()) {  
            return $this->errorResponse($validator->errors(), 422);
        }

        $inputs = $validator->safe();

        return $this->successResponse($this->announceRepository->getAnnounceWithAuthoritieById($inputs['announce_id']));
    }

    public function showByAuthoritieId(Request $request): JsonResponse 
    {
        $validator = Validator::make(['authoritie_id' => $request->route('id')], [
            'authoritie_id' => 'required|integer|exists:authorities,id',
        ]);

        if($validator->fails()) {  
            return $this->errorResponse($validator->errors(), 422);
        }

        $inputs = $validator->safe();

        return $this->successResponse($this->announceRepository->getAnnouncesByAuthoritieId($inputs['authoritie_id']));
    }

    public function showByAuthoritieIdWithOutPagination(Request $request): JsonResponse 
    {
        $validator = Validator::make(['authoritie_id' => $request->route('id')], [
            'authoritie_id' => 'required|integer|exists:authorities,id',
        ]);

        if($validator->fails()) {  
            return $this->errorResponse($validator->errors(), 422);
        }

        $inputs = $validator->safe();

        return $this->successResponse($this->announceRepository->getAnnouncesByAuthoritieIdWithOutPagination($inputs['authoritie_id']));
    }

    public function update(Request $request): JsonResponse 
    {
        $announceId = $request->route('id');

        $validator = Validator::make(array_merge($request->all(), ['announce_id' => $announceId]), [
            'announce_id'          => 'required|integer|exists:announces,id',
            'title'                => 'required|string|max:255',
            'description'          => 'required|string|max:255',
            'file'                 => 'url',
        ]);

        if($validator->fails()) {  
            return $this->errorResponse($validator->errors(), 422);
        }

        # Check Permission #
        $authoritieId = ( isset($request->authUser['superadmin']) ? $request->authUser['superadmin'] : ( isset($request->authUser['wilaya']) ? $request->authUser['wilaya'] : ( isset($request->authUser['authoritie']) ? $request->authUser['authoritie'] : 0 ) ) );

        if(!$authoritieId) {
            return $this->errorResponse('Unauthorized.', 401);
        }

        if(!isset($request->authUser['superadmin']) && $this->announceRepository->getAnnounceWithAuthoritieById($announceId)->authoritie->id != $authoritieId) {
            return $this->errorResponse('Unauthorized.', 401);
        }
        #####################

        $announceDetails = $request->only([
            'title',
            'description',
            'file',
        ]);

        return $this->successResponse($this->announceRepository->updateAnnounce($announceId, $announceDetails));
    }

    public function destroy(Request $request): JsonResponse 
    {
        $announceId = $request->route('id');

        $validator = Validator::make(['announce_id' => $announceId], [
            'announce_id' => 'required|integer|exists:announces,id',
        ]);

        if($validator->fails()) {  
            return $this->errorResponse($validator->errors(), 422);
        }

        # Check Permission #
        $authoritieId = ( isset($request->authUser['superadmin']) ? $request->authUser['superadmin'] : ( isset($request->authUser['wilaya']) ? $request->authUser['wilaya'] : ( isset($request->authUser['authoritie']) ? $request->authUser['authoritie'] : 0 ) ) );

        if(!$authoritieId) {
            return $this->errorResponse('Unauthorized.', 401);
        }

        if(!isset($request->authUser['superadmin']) && $this->announceRepository->getAnnounceWithAuthoritieById($announceId)->authoritie->id != $authoritieId) {
            return $this->errorResponse('Unauthorized.', 401);
        }
        #####################

        $this->announceRepository->deleteAnnounce($announceId);

        return $this->successResponse(null, Response::HTTP_NO_CONTENT);
    }
}
