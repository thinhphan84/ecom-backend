<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class DigitalFile extends Model
{
    protected $table = 'digital_files';

    public $guarded = [];

    protected $hidden = [
        'url'
    ];

    /**
     * Get the parent fileable model (user or post).
     */
    public function fileable()
    {
        return $this->morphTo(__FUNCTION__, 'fileable_type', 'fileable_id');
    }
}
