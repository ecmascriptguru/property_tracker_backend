<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It's a breeze. Simply tell Laravel the URIs it should respond to
| and give it the controller to call when that URI is requested.
|
*/
use App\User;
use Illuminate\Http\Request;
use Illuminate\Http\Response as HttpResponse;

Route::get('/', 'WelcomeController@index');

Route::get('home', 'HomeController@index');

Route::controllers([
	'auth' => 'Auth\AuthController',
	'password' => 'Auth\PasswordController',
]);

Route::group(['prefix' => 'api/'], function() {
	Route::post('signup/', function() {
		$credentials = Input::only('name', 'email', 'password');
		$credentials['password'] = Hash::make($credentials['password']);

		try {
			$user = User::create($credentials);
		} catch (Exception $e) {
			return Response::json(['status' => false, 'message' => 'User already exists.']);
		}

		$token = JWTAuth::fromUser($user);

		return Response::json(
			array('status' => true, 'token' => $token, 'user' => $user)
		);
	});

	Route::post('/signin', function () {
		$credentials = Input::only('email', 'password');

		if ( ! $token = JWTAuth::attempt($credentials)) {
			return Response::json(['status' => false, 'message' => 'Credentials are incorrect.']);
		}

		$user = JWTAuth::toUser($token);

		return Response::json(
			array('status' => true, 'token' => $token, 'user' => $user)
		);
	});

	Route::group(['prefix' => 'items', 'middleware' => ['jwt']], function() {
		Route::post('/', 'Api\ItemsController@index');
	});

	Route::group(['prefix' => 'properties', 'middleware' => ['jwt']], function() {
		Route::post('/', 'Api\PropertiesController@index');
	});
});