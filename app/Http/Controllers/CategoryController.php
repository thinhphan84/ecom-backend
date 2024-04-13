<?php

namespace App\Http\Controllers;

use App\Models\Category;
use App\Http\Requests\StoreCategoryRequest;
use App\Http\Requests\UpdateCategoryRequest;

class CategoryController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $categories = Category::all();
        return response($categories, 200);
    }

    //fetch product by category
    public function productsByCategory($id)
    {
        $category = Category::find($id);

        if ($category === null) {
            return response()->json(['message' => 'Category not found'], 404);
        }

        $products = $category->products()->paginate(10);
        return response($products, 200);
    }


    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreCategoryRequest $request)
    {
        //
    }

}
