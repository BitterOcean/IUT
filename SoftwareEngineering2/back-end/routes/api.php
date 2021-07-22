<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::group([
    'prefix'     => '',
    'middleware' => 'cors'
], function() {
    Route::post('/user/signup', 'UserController@signup')->name('user.signup');
    Route::post('/user/login', 'UserController@login')->name('user.login');
    Route::post('/user/logout', 'UserController@logout')->name('user.logout');

    Route::post('file/upload','FileController@upload')->name('file.upload');
    Route::get('file/getAll','FileController@getAll')->name('file.getAll');
    Route::post('file/register','FileController@register')->name('file.register');
    Route::get('file/checkRegister','FileController@checkRegister')->name('file.checkRegister');
    Route::get('file/getDetail','FileController@getDetail')->name('file.getDetail');
    Route::get('file/download','FileController@download')->name('file.download');

    Route::get('category/getAll','CategoryController@getAll')->name('category.getAll');


});

