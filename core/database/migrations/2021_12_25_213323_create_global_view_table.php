<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateGlobalViewTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        DB::statement("CREATE VIEW global_view AS (
            SELECT reports.id as reports_id , 
            authorities.id as authoritie_id , wilayas.id as wilaya_id, dairas.id as daira_id,reports.created_at as created_at,global_status,title,authorities.name as authorities_name ,wilayas.ar_name as wilaya_arname , dairas.ar_name as daira_ar_name, communes.ar_name as commune_ar_name,location_id ,user_id   
            FROM report_incident_types
            INNER JOIN reports ON report_incident_types.id = reports.id
            INNER JOIN locations ON reports.location_id = locations.id
            INNER JOIN communes ON locations.commune_id = communes.id
            INNER JOIN dairas ON locations.daira_id = dairas.id
            INNER JOIN wilayas ON locations.wilaya_id = wilayas.id
            INNER JOIN incident_types ON report_incident_types.incidentType_id = incident_types.id
            INNER JOIN authorities ON incident_types.authoritie_id = authorities.id
            )");
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        DB::statement("DROP IF EXISTS VIEW global_view");
    }
}
