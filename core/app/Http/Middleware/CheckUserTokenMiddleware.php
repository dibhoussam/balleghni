<?php

namespace App\Http\Middleware;

use App\Interfaces\UserServiceInterface;

use App\Traits\ApiResponser;
use Closure;

class CheckUserTokenMiddleware
{
    use ApiResponser;
    protected $userService;

    public function __construct(UserServiceInterface $userService)
    {
        $this->userService = $userService;
    }

    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        if ($request->header('Authorization')) {
            $user = $this->userService->obtainUser($request->header('Authorization'));
            if($user) {
                $tokenParts = explode(".", $request->header('Authorization'));  
                //$tokenHeader = base64_decode($tokenParts[0]);
                $tokenPayload = base64_decode($tokenParts[1]);
                //$jwtHeader = json_decode($tokenHeader);
                $request->authUser = json_decode($user, true);

                $request->authUser = array_merge($request->authUser, ['token' => json_decode($tokenPayload, true)]);
                
                return $next($request);
            }
        }
        return $this->errorResponse('Unauthorized.', 401);
    }
}
