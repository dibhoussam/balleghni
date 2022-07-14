<?php

namespace App\Interfaces;

interface UserServiceInterface
{
    public function obtainUser($token);
}
