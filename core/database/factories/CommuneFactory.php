<?php

namespace Database\Factories;

use App\Models\Commune;
use App\Models\Daira;
use Illuminate\Database\Eloquent\Factories\Factory;

class CommuneFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = Commune::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'name' => $this->faker->name,
            'slug' => $this->faker->unique()->name,
            'description' => $this->faker->sentences(2, true),
            'map_link' => $this->faker->url,
            'daira_id' => Daira::all()->random()->id,
        ];
    }
}
