<?php

namespace App\Http\Middleware;

use Closure;

class Cors
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next) {

//        return $next($request)
//            ->header('Access-Control-Allow-Origin', 'http://localhost:3000')
//            ->header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS')
//            ->header('Access-Control-Allow-Headers', 'Content-Type, X-Auth-Token, Authorization, Origin, Access-Control-Allow-Headers');
        $handle = $next($request);

        if(method_exists($handle, 'header'))
        {
            $handle->header('Access-Control-Allow-Origin' , 'http://localhost:3000')
                ->header('Access-Control-Allow-Methods', 'POST, GET, OPTIONS, PUT, DELETE')
                ->header('Access-Control-Allow-Headers', 'Content-Type, Accept, X-Auth-Token, Authorization, Origin, Access-Control-Allow-Headers, X-Requested-With, Application');
        }

        return $handle;
    }

}
