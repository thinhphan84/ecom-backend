<?php

use App\Http\Controllers\AttachmentController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\OrderController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\ReviewController;
use App\Http\Controllers\ShopController;
use App\Http\Controllers\TagController;
use App\Http\Controllers\TypeController;
use Illuminate\Support\Facades\Request;
use Illuminate\Support\Facades\Route;

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('/home', [HomeController::class, 'index'])->name('home');

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::post('/logout', [AuthController::class, 'logout']);

Route::get('/products', [ProductController::class, 'index']);
Route::apiResource('attachments', AttachmentController::class, [
    'only' => ['index', 'show'],
]);
Route::apiResource('tags', TagController::class, [
    'only' => ['index', 'show'],
]);
//Route::group(['middleware' => ['can:' . Permission::CUSTOMER, 'auth:sanctum',]], function () {
Route::get('/categories', [CategoryController::class, 'index']);
Route::get('/categories/{id}', [CategoryController::class, 'productsByCategory']);
Route::apiResource('shops', ShopController::class);
Route::get('/products/{id}', [ProductController::class, 'show']);
//});
Route::get('/categories', [CategoryController::class, 'index']);
Route::get('/categories/{id}', [CategoryController::class, 'productsByCategory']);
Route::apiResource('shops', ShopController::class);
Route::get('/products/{id}', [ProductController::class, 'show']);
//});

//Route::group(['middleware' => ['can:' . Permission::BASIC, 'auth:sanctum',]], function () {
Route::get('/categories', [CategoryController::class, 'index']);
Route::get('/categories/{id}', [CategoryController::class, 'productsByCategory']);
Route::get('/popular-products', [ProductController::class, 'popularProducts']);
//});

Route::apiResource('types', TypeController::class);
Route::apiResource('reviews', ReviewController::class);
Route::apiResource('tags', TagController::class);

Route::apiResource('products', ProductController::class);
Route::apiResource('shops', ShopController::class);
Route::apiResource('orders', OrderController::class);
Route::group(['middleware' => ['auth:sanctum']], function () {
});


