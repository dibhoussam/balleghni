<?php

namespace App\Http\Controllers;

use Laravel\Lumen\Routing\Controller as BaseController;

use App\Interfaces\CommuneRepositoryInterface;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

use App\Traits\ApiResponser;

use Illuminate\Support\Facades\Validator;

class CommuneController extends BaseController
{
    use ApiResponser;

    private CommuneRepositoryInterface $communeRepository;

    public function __construct(CommuneRepositoryInterface $communeRepository) 
    {
        $this->communeRepository = $communeRepository;
    }

    public function index(): JsonResponse 
    {
        return $this->successResponse($this->communeRepository->getAllCommunes());
    }

    public function show(Request $request): JsonResponse 
    {
        $validator = Validator::make(['commune_id' => $request->route('id')], [
            'commune_id' => 'required|integer|exists:communes,id',
        ]);

        if($validator->fails()) {  
            return $this->errorResponse($validator->errors(), 422);
        }

        $inputs = $validator->safe();

        return $this->successResponse($this->communeRepository->getCommuneById($inputs['commune_id']));
    }
}
