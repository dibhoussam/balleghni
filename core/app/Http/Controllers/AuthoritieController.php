<?php

namespace App\Http\Controllers;

use Laravel\Lumen\Routing\Controller as BaseController;

use App\Interfaces\AuthoritieRepositoryInterface;
use App\Interfaces\AnnounceRepositoryInterface;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

use App\Traits\ApiResponser;

use Illuminate\Support\Facades\Validator;

class AuthoritieController extends BaseController
{
    use ApiResponser;

    private AuthoritieRepositoryInterface $authoritieRepository;
    private AnnounceRepositoryInterface $announceRepository;

    public function __construct(AuthoritieRepositoryInterface $authoritieRepository, AnnounceRepositoryInterface $announceRepository) 
    {
        $this->authoritieRepository = $authoritieRepository;
        $this->announceRepository = $announceRepository;
    }

    public function index(Request $request): JsonResponse 
    {
        $validator = Validator::make($request->all(), [
            'wilaya_id'     => 'array',
            'wilaya_id.*'   => 'required|integer|exists:wilayas,id',
            'daira_id'      => 'array',
            'daira_id.*'    => 'required|integer|exists:dairas,id',
            'commune_id'    => 'array',
            'commune_id.*'  => 'required|integer|exists:communes,id',
        ]);

        if($validator->fails()) {
            return $this->errorResponse($validator->errors(), 422);
        }

        $inputs = $validator->safe();

        //$result = $this->getAndFilterAuthorities($inputs);
        //return response($result, 200)
        //            ->header('Content-Type', 'application/json')
        //            ->header('Content-Range', 'authorities 0-10/'.count($result));
        return $this->successResponse($this->getAndFilterAuthorities($inputs));
    }

    public function indexWithOutPagination(Request $request): JsonResponse 
    {
        $validator = Validator::make($request->all(), [
            'wilaya_id'     => 'array',
            'wilaya_id.*'   => 'required|integer|exists:wilayas,id',
            'daira_id'      => 'array',
            'daira_id.*'    => 'required|integer|exists:dairas,id',
            'commune_id'    => 'array',
            'commune_id.*'  => 'required|integer|exists:communes,id',
        ]);

        if($validator->fails()) {
            return $this->errorResponse($validator->errors(), 422);
        }

        $inputs = $validator->safe();

        //$result = $this->getAndFilterAuthorities($inputs);
        //return response($result, 200)
        //            ->header('Content-Type', 'application/json')
        //            ->header('Content-Range', 'authorities 0-10/'.count($result));
        return $this->successResponse($this->getAndFilterAuthoritiesWithOutPagination($inputs));
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
            'name'        => 'required|string|max:255',
            'slug'        => 'required|alpha_dash|unique:authorities,slug',
            'description' => 'required|string|max:255',
            'logo'        => 'required|url',
        ]);

        $authoritieDetails = $request->only([
            'name',
            'slug',
            'description',
            'logo',
        ]);

        return $this->successResponse($this->authoritieRepository->createAuthoritie($authoritieDetails), Response::HTTP_CREATED);
    }

    public function show(Request $request): JsonResponse 
    {
        $validator = Validator::make(array_merge($request->all(), ['authoritie_id' => $request->route('id')]), [
            'authoritie_id' => 'required|integer|exists:authorities,id',
            'wilaya_id'     => 'array',
            'wilaya_id.*'   => 'required|integer|exists:wilayas,id',
            'daira_id'      => 'array',
            'daira_id.*'    => 'required|integer|exists:dairas,id',
            'commune_id'    => 'array',
            'commune_id.*'  => 'required|integer|exists:communes,id',
        ]);

        if($validator->fails()) {  
            return $this->errorResponse($validator->errors(), 422);
        }

        $inputs = $validator->safe();

        return $this->successResponse($this->getAndFilterAuthoritie($inputs));
    }

    public function update(Request $request): JsonResponse 
    {
        $targetAuthoritieId = $request->route('id');
        
        $validator = Validator::make(array_merge($request->all(), ['authoritie_id' => $targetAuthoritieId]), [
            'authoritie_id' => 'required|integer|exists:authorities,id',
            'name'          => 'required|string|max:255',
            'description'   => 'required|string|max:255',
            'logo'          => 'required|url',
        ]);

        if($validator->fails()) {  
            return $this->errorResponse($validator->errors(), 422);
        }

        # Check Permission #
        $authoritieId = ( isset($request->authUser['superadmin']) ? $request->authUser['superadmin'] : ( isset($request->authUser['wilaya']) ? $request->authUser['wilaya'] : ( isset($request->authUser['authoritie']) ? $request->authUser['authoritie'] : 0 ) ) );

        if(!$authoritieId) {
            return $this->errorResponse('Unauthorized.', 401);
        }

        if(!isset($request->authUser['superadmin']) && !isset($request->authUser['wilaya']) && $targetAuthoritieId != $authoritieId) {
            return $this->errorResponse('Unauthorized.', 401);
        }
        #####################

        $authoritieDetails = $request->only([
            'name',
            'description',
            'logo',
        ]);

        return $this->successResponse($this->authoritieRepository->updateAuthoritie($targetAuthoritieId, $authoritieDetails));
    }

    public function destroy(Request $request): JsonResponse 
    {
        $targetAuthoritieId = $request->route('id');

        $validator = Validator::make(['authoritie_id' => $targetAuthoritieId], [
            'authoritie_id' => 'required|integer|exists:authorities,id',
        ]);

        if($validator->fails()) {  
            return $this->errorResponse($validator->errors(), 422);
        }

        # Check Permission #
        $authoritieId = ( isset($request->authUser['superadmin']) ? $request->authUser['superadmin'] : ( isset($request->authUser['wilaya']) ? $request->authUser['wilaya'] : ( isset($request->authUser['authoritie']) ? $request->authUser['authoritie'] : 0 ) ) );

        if(!$authoritieId) {
            return $this->errorResponse('Unauthorized.', 401);
        }

        if(!isset($request->authUser['superadmin']) && !isset($request->authUser['wilaya']) && $targetAuthoritieId != $authoritieId) {
            return $this->errorResponse('Unauthorized.', 401);
        }
        #####################

        $inputs = $validator->safe();

        $this->authoritieRepository->deleteAuthoritie($targetAuthoritieId);

        return $this->successResponse(null, Response::HTTP_NO_CONTENT);
    }

    private function getAndFilterAuthorities($inputs)
    {
        $result = [];

        if(isset($inputs['wilaya_id'])) {
            $result += $this->authoritieRepository->getAuthoritiesByWilayaIds($inputs['wilaya_id']);
        }
        
        if(isset($inputs['daira_id'])) {
            $result += $this->authoritieRepository->getAuthoritiesByDairaIds($inputs['daira_id']);
        }
        
        if(isset($inputs['commune_id'])) {
            $result += $this->authoritieRepository->getAuthoritiesByCommuneIds($inputs['commune_id']);
        }

        if(empty($result)) {
            $result = $this->authoritieRepository->getAllAuthorities();
        }

        return $result;
    }

    private function getAndFilterAuthoritiesWithOutPagination($inputs)
    {
        $result = [];

        if(isset($inputs['wilaya_id'])) {
            $result += $this->authoritieRepository->getAuthoritiesByWilayaIds($inputs['wilaya_id']);
        }
        
        if(isset($inputs['daira_id'])) {
            $result += $this->authoritieRepository->getAuthoritiesByDairaIds($inputs['daira_id']);
        }
        
        if(isset($inputs['commune_id'])) {
            $result += $this->authoritieRepository->getAuthoritiesByCommuneIds($inputs['commune_id']);
        }

        if(empty($result)) {
            $result = $this->authoritieRepository->getAllAuthoritiesWithOutPagination();
        }

        return $result;
    }

    private function getAndFilterAuthoritie($inputs)
    {
        $result = $this->authoritieRepository->getAuthoritieById($inputs['authoritie_id'])->makeHidden('branchs');

        if(isset($inputs['wilaya_id'])) {
            if(!isset($result['_branchs'])) {
                $result['_branchs'] = collect();
            }

            $result['_branchs']->push($this->authoritieRepository->getAuthoritieBranchsByWilayaIds($inputs['authoritie_id'], $inputs['wilaya_id']));
        }
        
        if(isset($inputs['daira_id'])) {
            if(!isset($result['_branchs'])) {
                $result['_branchs'] = collect();
            }

            $result['_branchs']->push($this->authoritieRepository->getAuthoritieBranchsByDairaIds($inputs['authoritie_id'], $inputs['daira_id']));
        }
        
        if(isset($inputs['commune_id'])) {
            if(!isset($result['_branchs'])) {
                $result['_branchs'] = collect();
            }

            $result['_branchs']->push($this->authoritieRepository->getAuthoritieBranchsByCommuneIds($inputs['authoritie_id'], $inputs['commune_id']));
        }

        if(!isset($result['_branchs'])) {
            $result->makeVisible('branchs');
        }

        return $result;
    }
}
