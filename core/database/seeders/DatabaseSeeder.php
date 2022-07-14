<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $this->call(WilayaSeeder::class);
        $this->call(DairaSeeder::class);
        $this->call(CommuneSeeder::class);
        $this->call(AuthoritieSeeder::class);
        $this->call(AuthoritieSeeder::class);
        $this->call(AuthoritieSeeder::class);
        $this->call(AnnounceSeeder::class);
        $this->call(IncidentTypeSeeder::class);
        $this->call(AuthoritieBranchSeeder::class);
        $this->call(ReportSeeder::class);
    }
}
