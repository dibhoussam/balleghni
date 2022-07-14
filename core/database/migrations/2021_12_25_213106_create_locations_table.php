<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateLocationsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('locations', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->integer('commune_id')->nullable()->index();
                $table->foreign('commune_id')->references('id')->on('communes')->onDelete('cascade');
            $table->integer('daira_id')->nullable()->index();
                $table->foreign('daira_id')->references('id')->on('dairas')->onDelete('cascade');
            $table->integer('wilaya_id')->index();
                $table->foreign('wilaya_id')->references('id')->on('wilayas')->onDelete('cascade');
            $table->string('address')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('locations');
    }
}
