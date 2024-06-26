<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Cviebrock\EloquentSluggable\Sluggable;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasManyThrough;
use Illuminate\Database\Eloquent\Relations\HasOne;
use App\Models\Product;
use App\Models\Type;

class Category extends Model
{
    use Sluggable;


    protected $table = 'categories';

    public $guarded = [];

    protected $casts = [
        'image' => 'json',
    ];

    protected $appends = ['parent_id', 'translated_languages'];

    /**
     * Get the user's full name.
     *
     * @return string
     */
    public function getParentIdAttribute()
    {
        if (isset($this->attributes['parent'])) {
            return $this->parent;
        }
    }

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


    /**
     * @return BelongsTo
     */
    public function type(): BelongsTo
    {
        return $this->belongsTo(Type::class, 'type_id');
    }

    /**
     * @return BelongsToMany
     */
    public function products(): BelongsToMany
    {
        return $this->belongsToMany(Product::class, 'category_product');
    }

    /**
     * @return HasMany
     */
    public function children()
    {
        return $this->hasMany('\Models\Category', 'parent', 'id')->with('children')->withCount('products');
    }

    /**
     * @return HasMany
     */
    public function subCategories()
    {
        return $this->hasMany('\Models\Category', 'parent', 'id')->with('subCategories', 'parent')->withCount('products');
    }

    /**
     * @return HasOne
     */
    public function parent()
    {
        return $this->hasOne('\Models\Category', 'id', 'parent')->with('parent');
    }

    /**
     * @return HasOne
     */
    public function parentCategory()
    {
        return $this->hasOne('\Models\Category', 'id', 'parent')->with('parentCategory');
    }
    public function getTranslatedLanguagesAttribute()
    {
        return 'translated_languages';
    }
}
