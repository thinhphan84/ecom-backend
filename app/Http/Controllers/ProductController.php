<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreProductRequest;
use App\Http\Requests\UpdateProductRequest;
use App\Models\Order;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Database\RecordsNotFoundException;
use Symfony\Component\Routing\Exception\ResourceNotFoundException;

class ProductController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $products = Product::paginate();
        return response($products, 200);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreProductRequest $request)
    {
        //
    }

    /**
     * popularProducts
     *
     * @param  Request $request
     * @return object
     */
    public function popularProducts(Request $request)
    {
        $orders = Order::all();
        $productIds = [];
        foreach ($orders as $order) {
            foreach ($order->products as $product) {
                $productIds[] = $product->id;
            }
        }

        $productCounts = array_count_values($productIds);
        arsort($productCounts);

        $productCounts = array_count_values($productIds);
        arsort($productCounts);

        $popularProductIds = array_slice(array_keys($productCounts), 0, 10);
        $popularProducts = Product::whereIn('id', $popularProductIds)->orderByRaw('FIELD(id, ' . implode(',', $popularProductIds) . ')')->get();

        return response($popularProducts, 200);
    }
    /**
     * Display the specified resource.
     */
    public function show(Product $product)
    {
//        if ($product != null) {
//            return response("Not Found", 404);
//        } else {
        return response($product, 200);
//        }
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Product $product)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateProductRequest $request, Product $product)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Product $product)
    {
        //
    }
}
