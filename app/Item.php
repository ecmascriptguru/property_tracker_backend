<?php namespace App;

use Illuminate\Database\Eloquent\Model;

class Item extends Model {

	protected $fillable = ['domain_id', 'ref', 'found_by'];
	//
	public function founder()
    {
        return $this->belongsTo('App\User', 'found_by');
    }

	public function histories() {
		return $this->hasMany('App\History');
	}
}
