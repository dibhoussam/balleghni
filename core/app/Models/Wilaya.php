<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Wilaya extends Model
{
    use HasFactory;

    protected $table = 'wilayas';

    public $timestamps = false;

    /**
     * The attributes that are dates.
     *
     * @var array
     */
    protected $dates = [
    ];

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'id',
        'name',
        'ar_name',
        'slug',
        'description',
        'logo',
        'map_link'
    ];

    /**
     * The attributes excluded from the model's JSON form.
     *
     * @var array
     */
    protected $hidden = [
    ];

    public function dairas()
    {
        return $this->hasMany(Daira::class, 'wilaya_id');
    }

    public function locations()
    {
        return $this->hasMany(Location::class, 'wilaya_id');
    }
}
