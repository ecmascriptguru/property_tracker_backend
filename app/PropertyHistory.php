<?php namespace App;

use Illuminate\Database\Eloquent\Model;

class PropertyHistory extends Model {

	protected $fillable = ['property_id', 'agent_id', 'price', 'currency', 'title', 'address/subtitle', 'features', 'description', 'status', 'created_by', 'updated_by'];
	//
	public function founder()
    {
        return $this->belongsTo('App\User', 'created_by');
    }

	public function agent()
    {
        return $this->belongsTo('App\Agent', 'agent_id');
    }

}
