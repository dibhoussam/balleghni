<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAuthoritieBranchsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('authoritie_branchs', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('authoritie_id')->index();
                $table->foreign('authoritie_id')->references('id')->on('authorities')->onDelete('cascade');
            $table->unsignedBigInteger('location_id');
                $table->foreign('location_id')->references('id')->on('locations');
            $table->string('email')->nullable();
            $table->string('map_link')->nullable();
            $table->boolean('dg')->default(false);
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('authoritie_branchs');
    }
}
