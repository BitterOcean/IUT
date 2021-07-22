<?php

namespace App\Http\Controllers;

use App\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;


class UserController extends Controller
{
    public function signup(Request $request){
        try {
            $new_user_data = [
                'name' => $request->input('name'),
                'family' => $request->input('family'),
                'email' => $request->input('email'),
                'password' => $request->input('password'),
                'phone' => $request->input('phone'),
                'wallet' => '50000'
            ];

            $users = User::where('email', '=', $request->input('email'))->first();
            if ($users === null) {
                $new_user_obj = User::create($new_user_data);
                if ($new_user_obj instanceof User) {
                    return response()->json([
                        'code' => 200,
                        'status' => 'OK'
                    ]);
                }
            } else {
                return response()->json([
                    'code' => 409,
                    'status' => 'User With This Email Already Exists'
                ]);
            }
        } catch(Exception $ex){
            return response()->json([
                'code' => 500,
                'status' => 'Internal Server Error!'
            ]);
        }
    }

    public function login(Request $request){
        try {
            $login_info = [
                'email' => $request->input('email'),
                'password' => $request->input('password')
            ];

            if (Auth::attempt($login_info, 1)) {
                return response()->json([
                    'code' => 200,
                    'status' => 'OK',
                    'token' => Auth::user()['remember_token']
                ]);
            } else {
                return response()->json([
                    'code' => 403,
                    'status' => 'Wrong Username Or Password'
                ]);
            }
        } catch(Exception $ex){
            return response()->json([
                'code' => 500,
                'status' => 'Internal Server Error!'
            ]);
        }
    }

    public function logout(Request $request){
        try {
            $user = User::where('remember_token', $request->input('token'))->first();
            //$user=User::query()->where('remember_token','=',$request->input('token'))->first();
            $user->remember_token = '';
            $user->save();

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
}
