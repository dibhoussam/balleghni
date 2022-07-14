<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Image extends Model
{
    use HasFactory;

    protected $table = 'images';

    public $timestamps = false;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'image',
        'delete_image',
        'thumbnail',
        'delete_thumbnail',
    ];

    /**
     * The attributes excluded from the model's JSON form.
     *
     * @var array
     */
    protected $hidden = [
        //'delete_image',
        //'delete_thumbnail',
    ];

    public function reports()
    {
        return $this->belongsToMany(Report::class, 'report_images', 'image_id', 'report_id');
    }
}
