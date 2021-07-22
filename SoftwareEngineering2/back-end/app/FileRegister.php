<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class FileRegister extends Model
{
    protected $table='fileRegisters';
    protected $primaryKey='id';
    //protected $fillable=[];
    protected $guarded=[
        //
    ];
    protected $hidden = [
    ];
}
