<?php

namespace App\Http\Controllers;

use Laravel\Lumen\Routing\Controller as BaseController;

use App\Interfaces\AuthoritieRepositoryInterface;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

use App\Traits\ApiResponser;

use Illuminate\Support\Facades\Validator;

class AuthoritieBranchController extends BaseController
{
    use ApiResponser;

    private AuthoritieRepositoryInterface $authoritieRepository;

    public function __construct(AuthoritieRepositoryInterface $authoritieRepository) 
    {
        $this->authoritieRepository = $authoritieRepository;
    }

    public function index(): JsonResponse 
    {
        return $this->successResponse($this->authoritieRepository->getAllAuthoritiesBranchs());
    }

    public function indexWithOutPagination(): JsonResponse 
    {
        return $this->successResponse($this->authoritieRepository->getAllAuthoritiesBranchsWithoutPagination());
    }
    

    public function store(Request $request): JsonResponse 
    {

        $validator = Validator::make(array_merge($request->all()), [
            'authoritie_id'             => 'required|integer|exists:authorities,id',
            'dg'                        => 'boolean',
            'map_link'                  => 'url',
            'email'                     => 'email',
            'communes.id'               => 'required|integer|exists:communes,id',
            'dairas.id'                 => 'required|integer|exists:dairas,id',
            'wilayas.id'                => 'required|integer|exists:wilayas,id',
            'address'                   => 'required|string',
            'phones'                    => 'array|max:4',
            'phones.*.phone'            => 'starts_with:0|digits:10',
            'phones.*.description'      => 'string',
        ]);

        if($validator->fails()) {  
            return $this->errorResponse($validator->errors(), 422);
        }

        $authoritieBranchDetails = $request->only([
            'authoritie_id',
            'communes.id',
            'dairas.id',
            'wilayas.id',
            'address',
            'email',
            'map_link',
            'dg',
            'phones',
        ]);

        if(!isset($authoritieBranchDetails['dg']))
            $authoritieBranchDetails['dg'] = false;

        $authoritieBranchDetails['commune_id'] = $authoritieBranchDetails['communes']['id'];
        $authoritieBranchDetails['daira_id'] = $authoritieBranchDetails['dairas']['id'];
        $authoritieBranchDetails['wilaya_id'] = $authoritieBranchDetails['wilayas']['id'];
            
        return $this->successResponse($this->authoritieRepository->createAuthoritieBranchForAuthoritie($authoritieBranchDetails['authoritie_id'], $authoritieBranchDetails), Response::HTTP_CREATED);
    }

    public function show(Request $request): JsonResponse 
    {
        $validator = Validator::make(['authoritieBranch_id' => $request->route('id')], [
            'authoritieBranch_id' => 'required|integer|exists:authoritie_branchs,id',
        ]);

        if($validator->fails()) {  
            return $this->errorResponse($validator->errors(), 422);
        }

        $inputs = $validator->safe();

        return $this->successResponse($this->authoritieRepository->getAuthoritieBranchById($inputs['authoritieBranch_id']));
    }

    public function update(Request $request): JsonResponse 
    {
        $authoritieBranchId = $request->route('id');
        
        $validator = Validator::make(array_merge($request->all(), ['authoritieBranch_id' => $authoritieBranchId]), [
            'authoritieBranch_id'       => 'required|integer|exists:authoritie_branchs,id',
            'dg'                        => 'required|boolean',
            'map_link'                  => 'url',
            'email'                     => 'email',
            'commune_id'                => 'required|integer|exists:communes,id',
            'daira_id'                  => 'required|integer|exists:dairas,id',
            'wilaya_id'                 => 'required|integer|exists:wilayas,id',
            'address'                   => 'string',
            'phones'                    => 'array|max:4',
            'phones.*.phone'            => 'starts_with:0|digits:10',
            'phones.*.description'      => 'string',
        ]);

        if($validator->fails()) {  
            return $this->errorResponse($validator->errors(), 422);
        }

        $authoritieBranchDetails = $request->only([
            'commune_id',
            'daira_id',
            'wilaya_id',
            'address',
            'email',
            'map_link',
            'dg',
            'phones',
        ]);

        return $this->successResponse($this->authoritieRepository->updateAuthoritieBranch($authoritieBranchId, $authoritieBranchDetails));
    }

    public function destroy(Request $request): JsonResponse 
    {
        $authoritieBranchId = $request->route('id');

        $validator = Validator::make(['authoritieBranch_id' => $authoritieBranchId], [
            'authoritieBranch_id' => 'required|integer|exists:authoritie_branchs,id',
        ]);

        if($validator->fails()) {  
            return $this->errorResponse($validator->errors(), 422);
        }

        $this->authoritieRepository->deleteAuthoritieBranch($authoritieBranchId);

        return $this->successResponse(null, Response::HTTP_NO_CONTENT);
    }
}
