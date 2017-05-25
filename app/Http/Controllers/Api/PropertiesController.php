<?php namespace App\Http\Controllers\Api;

use App\Http\Requests;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Domain;
use App\Agent;
use App\Property;
use App\PropertyHistory;

class PropertiesController extends Controller {

	public function __construct() {
		
	}
	/**
	 * Display a listing of the resource.
	 *
	 * @return Response
	 */
	public function index(Request $request)
	{
        //  Global
        $user = $request->input('user');


        //  For Domain
		$domain = $request->input('host');

        //  For Agent
        $agent_name = $request->input('agent');
        $agent_address = $request->input('agent_address');
        $agent_phone = $request->input('agent_phone');

        //  For property
        $ref = $request->input("number");

        //  For history
		$title = $request->input('title');
		$price = $request->input('price');
		$address = $request->input("address/subtitle");
        $features = $request->input('features');
		$description = $request->input('description');

        //  Create or search domain
        $domain_id = Domain::firstOrCreate(['name' => $domain])->id;

        //  Create or search agent
        $agent = Agent::firstOrNew([
            'name' => $agent_name,
            'address' => $agent_address,
            'phone' => $agent_phone
        ]);

        if (!$agent->found_by) {
            $agent->found_by = $user->id;
            $agent->save();
        }

        //  create or search Property
        $property = Property::firstOrNew([
            'domain_id' => $domain_id,
            'ref' => $ref
        ]);

        if (!$property->created_by) {
            $property->created_by = $user->id;
            $property->updated_by = $user->id;

            $property->save();
        }

        //  For Property history
        $history = PropertyHistory::firstOrNew([
            'property_id' => $property->id,
            'agent_id' => $agent->id,
            'price' => $price,
            'title' => $title,
            'address/subtitle' => $address,
            'features' => $features,
            'description' => $description
        ]);

        if (!$history->created_by) {
            $history->created_by = $user->id;
            $history->updated_by = $user->id;

            $history->save();
        }

		return Response()->json(array('status'=> true, 'histories' => $property->histories, 'user' => $user));
	}

	/**
	 * Show the form for creating a new resource.
	 *
	 * @return Response
	 */
	public function create()
	{
		//
	}
}
