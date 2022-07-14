<?php

namespace App\Traits;

trait ApiResponser
{
    /**
     * Success Response
     * @param $data
     * @param int $code
     * @return $this
     */
    public function successResponse($data, $code = \Illuminate\Http\Response::HTTP_OK)
    {
        return response()->json(['success' => true, 'data' => $data, 'code' => $code], $code);
    }

    public function errorResponse($message, $code)
    {
        return response()->json(['success' => false, 'error' => $message, 'code' => $code], $code);
    }

    public function errorMessage($message, $code)
    {
        return response($message, $code)->header('Content-Type', 'application/json');
    }
}