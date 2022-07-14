<?php

namespace App\Http\Controllers;

use Laravel\Lumen\Routing\Controller as BaseController;

use App\Interfaces\WilayaRepositoryInterface;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

use App\Traits\ApiResponser;

use Illuminate\Support\Facades\Validator;

class WilayaController extends BaseController
{
    use ApiResponser;

    private WilayaRepositoryInterface $wilayaRepository;

    public function __construct(WilayaRepositoryInterface $wilayaRepository) 
    {
        $this->wilayaRepository = $wilayaRepository;
    }

    public function index(): JsonResponse 
    {
        return $this->successResponse($this->wilayaRepository->getAllWilayas());
    }

    public function show(Request $request): JsonResponse 
    {
        $validator = Validator::make(['wilaya_id' => $request->route('id')], [
            'wilaya_id' => 'required|integer|exists:wilayas,id',
        ]);

        if($validator->fails()) {  
            return $this->errorResponse($validator->errors(), 422);
        }

        $inputs = $validator->safe();

        return $this->successResponse($this->wilayaRepository->getWilayaById($inputs['wilaya_id']));
    }
}
