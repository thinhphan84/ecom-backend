<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use App\Models\Shop;

class Balance extends Model
{
    protected $table = 'balances';

    public $guarded = [];

    protected $casts = [
        'payment_info' => 'json',
    ];

    /**
     * @return BelongsTo
     */
    public function shop(): BelongsTo
    {
        return $this->belongsTo(Shop::class, 'shop_id');
    }
}
