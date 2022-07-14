<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAuthoritieBranchPhonesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('authoritie_branch_phones', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('authoritieBranch_id')->index();
                $table->foreign('authoritieBranch_id')->references('id')->on('authoritie_branchs')->onDelete('cascade');
            $table->string('phone');
            $table->string('description')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('authoritie_branch_phones');
    }
}
