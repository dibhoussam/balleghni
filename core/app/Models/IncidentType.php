<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class IncidentType extends Model
{
    use HasFactory;

    protected $table = 'incident_types';

    public $timestamps = false;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'title',
        'slug',
        'description',
        'icon',
        'authoritie_id',
    ];

    /**
     * The attributes excluded from the model's JSON form.
     *
     * @var array
     */
    protected $hidden = [
        'authoritie_id',
    ];

    public function authoritie()
    {
        return $this->belongsTo(Authoritie::class, 'authoritie_id');
    }

    public function reports()
    {
        return $this->belongsToMany(Report::class, 'report_incident_types', 'incidentType_id', 'report_id');
    }
}
