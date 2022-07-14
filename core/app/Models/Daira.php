<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Daira extends Model
{
    use HasFactory;

    protected $table = 'dairas';

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
        'map_link',
        'wilaya_id',
    ];

    /**
     * The attributes excluded from the model's JSON form.
     *
     * @var array
     */
    protected $hidden = [
        //'wilaya_id',
    ];

    public function wilaya()
    {
        return $this->belongsTo(Wilaya::class, 'wilaya_id');
    }

    public function communes()
    {
        return $this->hasMany(Commune::class, 'daira_id');
    }
}
