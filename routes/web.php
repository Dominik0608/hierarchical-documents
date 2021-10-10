<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\CategoryController;

Auth::routes();

Route::get('/', [CategoryController::class, 'index']);
Route::post('/', [CategoryController::class, 'fileUpload']);