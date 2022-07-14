<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Authoritie extends Model
{
    use HasFactory;

    protected $table = 'authorities';

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
        'name',
        'slug',
        'description',
        'logo',
    ];

    /**
     * The attributes excluded from the model's JSON form.
     *
     * @var array
     */
    protected $hidden = [
        'created_at',
        'updated_at',
        'deleted_at',
    ];

    public function branchs()
    {
        return $this->hasMany(AuthoritieBranch::class, 'authoritie_id');
    }

    public function announces()
    {
        return $this->hasMany(Announce::class, 'authoritie_id');
    }

    public function incidentTypes()
    {
        return $this->hasMany(IncidentType::class, 'authoritie_id');
    }
}
