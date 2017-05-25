<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreatePropertyHistoriesTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('property_histories', function(Blueprint $table)
		{
			$table->increments('id');
			$table->integer('property_id')->unsigned();
			$table->foreign('property_id')->references('id')->on('properties');
			$table->integer('agent_id')->unsigned();
			$table->foreign('agent_id')->references('id')->on('agents');
			$table->string('price', 20);
			$table->string('currency', 3);
			$table->string('price_data', 50);
			$table->string('title', 255);
			$table->string('address/subtitle', 255);
			$table->text('features');
			$table->text('description');
			$table->string('status', 10);
			$table->integer('created_by')->unsigned();
			$table->foreign('created_by')->references('id')->on('users');
			$table->integer('updated_by')->unsigned();
			$table->foreign('updated_by')->references('id')->on('users');
			$table->timestamps();
		});
	}

	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::drop('property_histories');
	}

}
