<?php namespace App\Http\Controllers\Api;

use App\Http\Requests;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Domain;
use App\Item;
use App\History;

class ItemsController extends Controller {

	public function __construct() {
		
	}
	/**
	 * Display a listing of the resource.
	 *
	 * @return Response
	 */
	public function index(Request $request)
	{
		$ref = $request->input("ref");
		$domain = $request->input('host');
		$title = $request->input('title');
		$price = $request->input('price');
		$bidders = $request->input('bidders');
		$description = $request->input('description');

		$domain_id = Domain::firstOrCreate(['name' => $domain])->id;
		$item = Item::firstOrNew(['domain_id' => $domain_id, 'ref' => $ref]);

		if (!$item->found_by) {
			$user = $request->input('user');
			$item->found_by = $user->id;
			$item->save();
		}

		$history = History::FirstOrCreate([
			'item_id' => $item->id,
			'price' => $price,
			'bidders' => $bidders,
			'title' => $title,
			'description' => $description
		]);

		return Response()->json(array('status'=> true, 'histories' => $item->histories));
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
