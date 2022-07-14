<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Report extends Model
{
    use HasFactory;

    protected $table = 'reports';

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
        'description',
        'global_status',
        'longitude',
        'latitude',
        'location_id',
        'user_id',
    ];

    /**
     * The attributes excluded from the model's JSON form.
     *
     * @var array
     */
    protected $hidden = [
        'location_id',
        'deleted_at',
    ];

    public function location()
    {
        return $this->belongsTo(Location::class, 'location_id');
    }

    public function incidentTypes()
    {
        return $this->belongsToMany(IncidentType::class, 'report_incident_types', 'report_id', 'incidentType_id');
    }

    public function images()
    {
        return $this->belongsToMany(Image::class, 'report_images', 'report_id', 'image_id');
    }
}
