<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Commune extends Model
{
    use HasFactory;

    protected $table = 'communes';

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
        'name',
        'ar_name',
        'description',
        'map_link',
        'daira_id',
    ];

    /**
     * The attributes excluded from the model's JSON form.
     *
     * @var array
     */
    protected $hidden = [
        //'daira_id',
    ];

    public function daira()
    {
        return $this->belongsTo(Daira::class, 'daira_id');
    }
}
