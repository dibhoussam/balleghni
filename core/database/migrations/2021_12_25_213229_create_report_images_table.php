<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateReportImagesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('report_images', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('report_id')->index();
                $table->foreign('report_id')->references('id')->on('reports')->onDelete('cascade');
            $table->unsignedBigInteger('image_id');
                $table->foreign('image_id')->references('id')->on('images')->onDelete('cascade');

            $table->unique(['report_id', 'image_id']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('report_images');
    }
}
