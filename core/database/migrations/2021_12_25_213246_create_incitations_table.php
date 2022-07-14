<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateIncitationsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('incitations', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('user_id')->unique()->index();
            $table->unsignedBigInteger('report_id')->index();
                $table->foreign('report_id')->references('id')->on('reports')->onDelete('cascade');
            $table->timestamp('created_at');
            $table->unique(['user_id', 'report_id']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('incitations');
    }
}
