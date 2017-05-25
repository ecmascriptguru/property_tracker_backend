<?php namespace App;

use Illuminate\Database\Eloquent\Model;

class Domain extends Model {

	//
	protected $fillable = ['name'];

	public function properties() {
		return $this->hasMany('App\Property', 'domain_id');
	}
}
