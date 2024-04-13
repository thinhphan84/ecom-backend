<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Models\Order;

class PaymentIntent extends Model
{
    use SoftDeletes;

    protected $table = 'payment_intents';

    public $guarded = [];

    protected $casts = [
        'payment_intent_info' => 'json',
    ];

    protected $hidden = [
        'created_at',
        'updated_at',
        'deleted_at'
    ];

    /**
     * @return belongsTo
     */
    public function order(): belongsTo
    {
        return $this->belongsTo(Order::class, 'order_id');
    }
}
