<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Announce extends Model
{
    use HasFactory;

    protected $table = 'announces';

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
        'title',
        'description',
        'file',
        'authoritie_id',
    ];

    /**
     * The attributes excluded from the model's JSON form.
     *
     * @var array
     */
    protected $hidden = [
        //'authoritie_id',
        'updated_at',
        'deleted_at',
    ];

    public function authoritie()
    {
        return $this->belongsTo(Authoritie::class, 'authoritie_id');
    }
}
