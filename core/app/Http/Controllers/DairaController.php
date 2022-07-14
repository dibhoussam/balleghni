<?php

namespace App\Http\Controllers;

use Laravel\Lumen\Routing\Controller as BaseController;

use App\Interfaces\DairaRepositoryInterface;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

use App\Traits\ApiResponser;

use Illuminate\Support\Facades\Validator;

class DairaController extends BaseController
{
    use ApiResponser;

    private DairaRepositoryInterface $dairaRepository;

    public function __construct(DairaRepositoryInterface $dairaRepository) 
    {
        $this->dairaRepository = $dairaRepository;
    }

    public function index(): JsonResponse 
    {
        return $this->successResponse($this->dairaRepository->getAllDairas());
    }

    public function show(Request $request): JsonResponse 
    {
        $validator = Validator::make(['daira_id' => $request->route('id')], [
            'daira_id' => 'required|integer|exists:dairas,id',
        ]);

        if($validator->fails()) {  
            return $this->errorResponse($validator->errors(), 422);
        }

        $inputs = $validator->safe();

        return $this->successResponse($this->dairaRepository->getDairaById($inputs['daira_id']));
    }
}
