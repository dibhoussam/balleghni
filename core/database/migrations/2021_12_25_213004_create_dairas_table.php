<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDairasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('dairas', function (Blueprint $table) {
            $table->integer('id')->unique()->index();
            $table->string('name');
            $table->string('ar_name');
            $table->string('slug')->unique()->index();
            $table->string('description')->nullable();
            $table->string('map_link')->nullable();
            $table->integer('wilaya_id')->index();
                $table->foreign('wilaya_id')->references('id')->on('wilayas')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('authorities');
    }
}
