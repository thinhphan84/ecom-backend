<?php

namespace App\Models;

use Cviebrock\EloquentSluggable\Sluggable;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use App\Models\Product;

class Author extends Model
{
    use Sluggable;

    protected $table = 'authors';

    public $guarded = [];

    public $appends = ['products_count', 'translated_languages'];

    protected $casts = [
        'image'   => 'json',
        'cover_image' => 'json',
        'socials' => 'json',
    ];



    /**
     * Return the sluggable configuration array for this model.
     *
     * @return array
     */
    public function sluggable(): array
    {
        return [
            'slug' => [
                'source' => 'name'
            ]
        ];
    }

    public function scopeWithUniqueSlugConstraints(Builder $query, Model $model): Builder
    {
        return $query->where('language', $model->language);
    }

    public function getProductsCountAttribute()
    {
        return $this->products()->count();
    }


    /**
     * @return HasMany
     */
    public function products(): HasMany
    {
        return $this->hasMany(Product::class, 'author_id');
    }
}
