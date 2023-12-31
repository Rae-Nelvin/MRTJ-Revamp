<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Notification extends Model
{
    use HasFactory;

    protected $table = 'notifications';
    public $timestamps = false;

    protected $fillable = [
        'name',
        'email',
        'status',
        'message'
    ];

    public static function make(array $attributes = [])
    {
        return (new static)->forceFill($attributes);
    }
}
