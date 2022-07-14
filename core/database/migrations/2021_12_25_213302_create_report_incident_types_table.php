<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateReportIncidentTypesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('report_incident_types', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('report_id')->index();
                $table->foreign('report_id')->references('id')->on('reports')->onDelete('cascade');
            $table->unsignedBigInteger('incidentType_id')->index();
                $table->foreign('incidentType_id')->references('id')->on('incident_types')->onDelete('cascade');
            $table->unique(['report_id', 'incidentType_id']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('report_incident_types');
    }
}
