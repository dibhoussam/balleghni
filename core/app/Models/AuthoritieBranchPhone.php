<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AuthoritieBranchPhone extends Model
{
    use HasFactory;

    protected $table = 'authoritie_branch_phones';

    public $timestamps = false;
    
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'authoritieBranch_id',
        'phone',
        'description',
    ];

    /**
     * The attributes excluded from the model's JSON form.
     *
     * @var array
     */
    protected $hidden = [
        'authoritieBranch_id',
    ];


    public function branch()
    {
        return $this->belongsTo(AuthoritieBranch::class, 'authoritieBranch_id');
    }
}
