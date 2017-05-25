<?php namespace App;

use Illuminate\Database\Eloquent\Model;

class Agent extends Model {

	protected $fillable = ['name', 'address', 'phone'];
	//
	public function founder()
    {
        return $this->belongsTo('App\User', 'found_by');
    }

	public function properties() {
		return $this->hasMany('App\Property', 'agent_id');
	}
}
