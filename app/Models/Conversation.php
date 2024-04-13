<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Support\Facades\Auth;

class Conversation extends Model
{

    public $guarded = [];

    protected $appends = [
        'latest_message',
        'unseen',
    ];

    /**
     * @return belongsTo
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    /**
     * @return belongsTo
     */
    public function shop(): BelongsTo
    {
        return $this->belongsTo(Shop::class, 'shop_id');
    }

    /**
     * @return hasMany
     */
    public function messages(): HasMany
    {
        return $this->hasMany(Message::class, 'conversation_id');
    }

    /**
     * Get all of the conversations participants.
     */
    public function participants()
    {
        return $this->hasMany(Participant::class, 'conversation_id');
    }

    /**
     * Returns the latest message from a conversation.
     *
     * @return Message
     */
    public function getLatestMessageAttribute()
    {
        return $this->messages()->latest()->first();
    }

    public function getUnseenAttribute()
    {
        $participant = $this->participants()->where('user_id', Auth::id())->first();

        if ($participant) {
            return $this->messages()->where('created_at', '>', $participant->last_read)->count();
        }

        return 0;
    }
}
