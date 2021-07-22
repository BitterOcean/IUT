<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    protected $table='categories';
    protected $primaryKey='id';
    //protected $fillable=[];
    public $timestamps = false;
    protected $guarded=[
    ];
    protected $hidden = [
    ];
}
