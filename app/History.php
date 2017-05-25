<?php namespace App;

use Illuminate\Database\Eloquent\Model;

class History extends Model {

	protected $fillable = ['item_id', 'price', 'bidders', 'title', 'description'];
	//
	public function item() {
		return $this->belongsTo('App\Item');
	}
}
