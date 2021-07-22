<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class File extends Model
{
    protected $table='files';
    protected $primaryKey='id';
    //protected $fillable=[];
    public $timestamps = false;
    protected $guarded=[
        //
    ];
    protected $hidden = [
        'physicalName'
    ];
}
