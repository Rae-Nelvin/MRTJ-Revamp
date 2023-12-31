<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTicketingsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('ticketings', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('email');
            $table->string('tap_in_id');
            $table->dateTime('tap_in_time');
            $table->string('tap_in_latitude');
            $table->string('tap_in_longitude');
            $table->string('tap_in_station');
            $table->string('tap_out_id')->nullable();
            $table->dateTime('tap_out_time')->nullable();
            $table->string('tap_out_latitude')->nullable();
            $table->string('tap_out_longitude')->nullable();
            $table->string('tap_out_station')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('ticketings');
    }
}
