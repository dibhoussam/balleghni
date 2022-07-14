<?php

namespace Database\Factories;

use App\Models\Report;
use App\Models\Citoyen;
use App\Models\Location;
use App\Models\Image;
use App\Models\IncidentType;
use Illuminate\Database\Eloquent\Factories\Factory;

class ReportFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = Report::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'description' => $this->faker->sentence,
            'global_status' => $this->faker->boolean,
            'longitude' => $this->faker->randomFloat(1, 0, 1),
            'latitude' => $this->faker->randomFloat(1, 0, 1),
            'location_id' => Location::factory()->create()->id,
            'user_id' => $this->faker->sentence,
        ];
    }

    /**
     * Configure the model factory.
     *
     * @return $this
     */
    public function configure()
    {
        return $this->afterMaking(function (Report $report) {
            //
        })->afterCreating(function (Report $report) {
            $incidentTypes = IncidentType::all()->random(rand(1, 6));
            $report->incidentTypes()->attach($incidentTypes);

            $images = Image::factory(rand(1, 4))->create();
            $report->images()->attach($images);
        });
    }
}
