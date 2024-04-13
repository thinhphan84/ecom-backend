<?php

namespace App\Http\Controllers;

use App\Models\PaymentIntent;
use App\Http\Requests\StorePaymentIntentRequest;
use App\Http\Requests\UpdatePaymentIntentRequest;

class PaymentIntentController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
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
    public function store(StorePaymentIntentRequest $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(PaymentIntent $paymentIntent)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(PaymentIntent $paymentIntent)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdatePaymentIntentRequest $request, PaymentIntent $paymentIntent)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(PaymentIntent $paymentIntent)
    {
        //
    }
}
