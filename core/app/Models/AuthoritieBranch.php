<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AuthoritieBranch extends Model
{
    use HasFactory;

    protected $table = 'authoritie_branchs';

    /**
     * The attributes that are dates.
     *
     * @var array
     */
    protected $dates = [
        'created_at',
        'updated_at',
        'deleted_at',
    ];

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'authoritie_id',
        'location_id',
        'email',
        'map_link',
        'dg',
    ];

    /**
     * The attributes excluded from the model's JSON form.
     *
     * @var array
     */
    protected $hidden = [
        //'authoritie_id',
        'location_id',
        'created_at',
        'updated_at',
        'deleted_at',
    ];


    public function authoritie()
    {
        return $this->belongsTo(Authoritie::class, 'authoritie_id');
    }

    public function location()
    {
        return $this->belongsTo(Location::class, 'location_id');
    }

    public function phones()
    {
        return $this->hasMany(AuthoritieBranchPhone::class, 'authoritieBranch_id');
    }
}
