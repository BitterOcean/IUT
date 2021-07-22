<?php

namespace App\Http\Controllers;

use App\File;
use App\FileRegister;
use App\Subcategory;
use App\Category;
use App\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use \Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class FileController extends Controller
{
    public function upload(Request $request){
        try {
            $user = User::where('remember_token', $request->input('token'))->first();
            $physicalName = Str::random(30).'.'.$request->file('file')->getClientOriginalExtension();
            $new_file = [
                'name' => $request->input('name'),
                'physicalName' => $physicalName,
                'description' => $request->input('description'),
                'price' => $request->input('price'),
                'format' => $request->input('format'),
                'size' => $request->input('size'),
                'author_id' => $user->id,
                'subcategory_id' => $request->input('subcategory_id')
            ];

            //dd($new_file);
            $file = File::create($new_file);

            $request->file('file')->storeAs('files', $physicalName);

            if ($file instanceof File) {
                $newfileRegister = [
                    'file_id' => $file->id,
                    'user_id' => $user->id,
                    'price' => 0,
                ];
                FileRegister::create($newfileRegister);
                return response()->json([
                    'code' => 200,
                    'status' => 'OK'
                ]);
            } else {
                return response()->json([
                    'code' => 409,
                    'status' => 'File Upload Error'
                ]);
            }
        } catch(Exception $ex){
            return response()->json([
                'code' => 500,
                'status' => 'Internal Server Error!'
            ]);
        }
    }

    public function getAll(Request $request){
        try {
            $allfile = File::all();
            if($allfile->isEmpty()){
                return response()->json([
                    'code' => 204,
                    'status' => 'Database Is Empty!'
                ]);
            }
            $i = 0;
            foreach ($allfile as $file) {
                $subcategory = Subcategory::where('id', $file->subcategory_id)->first();
                $resp[$i] = [
                    'id' => $file->id,
                    'name' => $file->name,
                    'price' => $file->price
                ];
                $i++;
            }
            return response()->json($resp);
        } catch(Exception $ex){
            return response()->json([
                'code' => 500,
                'status' => 'Internal Server Error!'
            ]);
        }
    }

    public function getDetail(Request $request){
        try {
            $file = File::where('id', $request->input('id'))->first();
            $subcategory = Subcategory::where('id', $file->subcategory_id)->first();
            $resp = [
                'id' => $file->id,
                'name' => $file->name,
                'description' => $file->description,
                'price' => $file->price,
                'format' => $file->format,
                'size' => $file->size,
                'author_name' => User::find($file->author_id)->name . ' ' . User::find($file->author_id)->family,
                'author_email' => User::find($file->author_id)->email,
                'subcategory' => Subcategory::find($file->subcategory_id)->Name,
                'category' => Category::find($subcategory->category_id)->Name
            ];
            return response()->json($resp);
        } catch(Exception $ex){
            return response()->json([
                'code' => 500,
                'status' => 'Internal Server Error!'
            ]);
        }
    }

    public function register(Request $request){
        try {
            $user = User::where('remember_token', $request->input('token'))->first();
            $fileRegister = FileRegister::where('user_id', $user->id)->where('file_id', $request->input('file_id'))->first();
            if ($fileRegister instanceof FileRegister){
                return response()->json([
                    'code' => 409,
                    'status' => 'register done before'
                ]);
            }
            $file = File::where('id', $request->input('file_id'))->first();
            $author = User::where('id', $file->author_id)->first();
            if ($file->price > $user->wallet) {
                return response()->json([
                    'code' => 400,
                    'status' => 'Not enough money'
                ]);
            }
            $newfileRegister = [
                'file_id' => $file->id,
                'user_id' => $user->id,
                'price' => $file->price,
            ];

            $user->wallet = $user->wallet - $file->price;
            $author->wallet = $author->wallet + $file->price;
            $user->save();
            $author->save();

            FileRegister::create($newfileRegister);
            return response()->json([
                'code' => 200,
                'status' => 'OK'
            ]);
        } catch(Exception $ex){
            return response()->json([
                'code' => 500,
                'status' => 'Internal Server Error!'
            ]);
        }
    }

    public function checkRegister(Request $request){
        try {
            $user = User::where('remember_token', $request->input('token'))->first();
            $fileRegister = FileRegister::where('user_id', $user->id)->where('file_id', $request->input('file_id'))->first();
            if ($fileRegister instanceof FileRegister) {
                return response()->json([
                    'result' => 'true',
                    'code' => 200,
                    'status' => 'OK'
                ]);
            } else {
                return response()->json([
                    'result' => 'false',
                    'code' => 200,
                    'status' => 'OK'
                ]);
            }
        } catch(Exception $ex){
            return response()->json([
                'code' => 500,
                'status' => 'Internal Server Error!'
            ]);
        }
    }

    public function download(Request $request){
        try {
            $user = User::where('remember_token', $request->input('token'))->first();
            $fileRegister = FileRegister::where('user_id', $user->id)->where('file_id', $request->input('file_id'))->first();
            if ($fileRegister instanceof FileRegister) {
                $file = File::where('id', $request->input('file_id'))->first();
                $physicalName = File::find($file->id)->physicalName;
                $name = File::find($file->id)->name;
                $path=storage_path('/app/files/'.$physicalName);
                if (file_exists($path)){
                    $headers = [
                        'Content-Type' => $file->format,
                    ];

                    return response()->download($path,$name,$headers);
                }
                else{
                    return response()->json([
                        'code' => 404,
                        'status' => 'Not Found!'
                    ]);
                }

            } else {
                return response()->json([
                    'code' => 403,
                    'status' => 'Access denied'
                ]);
            }
        } catch(Exception $ex){
            return response()->json([
                'code' => 500,
                'status' => 'Internal Server Error!'
            ]);
        }
    }
}