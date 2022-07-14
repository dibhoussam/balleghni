<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Location extends Model
{
    use HasFactory;

    protected $table = 'locations';

    public $timestamps = false;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'commune_id',
        'daira_id',
        'wilaya_id',
        'address',
    ];

    /**
     * The attributes excluded from the model's JSON form.
     *
     * @var array
     */
    protected $hidden = [
        'commune_id',
        'daira_id',
        'wilaya_id',
    ];

    public function branchs()
    {
        return $this->hasMany(AuthoritieBranch::class, 'location_id');
    }

    public function reports()
    {
        return $this->hasMany(Report::class, 'location_id');
    }

    public function commune()
    {
        return $this->belongsTo(Commune::class, 'commune_id');
    }

    public function daira()
    {
        return $this->belongsTo(Daira::class, 'daira_id');
    }

    public function wilaya()
    {
        return $this->belongsTo(Wilaya::class, 'wilaya_id');
    }
}
