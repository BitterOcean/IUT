<?php

namespace App\Http\Controllers;


use App\Category;
use App\Subcategory;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class CategoryController extends Controller
{
    public function getAll(Request $request){
        try {
            $allsubcat = Subcategory::all();
            $i = 0;
            foreach ($allsubcat as $subcat) {
                $resp[$i] = [
                    'id' => $subcat->id,
                    'subcategory' => $subcat->Name,
                    'category' => Category::find($subcat->category_id)->Name
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
}
