<?php

namespace Database\Factories;

use App\Models\Location;
use App\Models\Daira;
use App\Models\Commune;
use Illuminate\Database\Eloquent\Factories\Factory;

class LocationFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = Location::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        $commune = Commune::all()->random();
        $daira_id = $commune->daira_id;
        $wilaya_id = Daira::where('id', $daira_id)->first()->wilaya_id;
        return [
            'commune_id' => $commune->id,
            'daira_id' => $daira_id,
            'wilaya_id' => $wilaya_id,
            'address' => $this->faker->sentences(1, true),
        ];
    }
}
