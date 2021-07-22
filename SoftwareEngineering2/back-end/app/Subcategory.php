<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Subcategory extends Model
{
    protected $table='subcategories';
    protected $primaryKey='id';
    //protected $fillable=[];
    public $timestamps = false;
    protected $guarded=[
    ];
    protected $hidden = [
    ];
}
