<?php

namespace Database\Factories;

use App\Models\Daira;
use App\Models\Wilaya;
use Illuminate\Database\Eloquent\Factories\Factory;

class DairaFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = Daira::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'code' => $this->faker->unique()->name,
            'name' => $this->faker->name,
            'slug' => $this->faker->unique()->name,
            'description' => $this->faker->sentences(2, true),
            'map_link' => $this->faker->url,
            'wilaya_id' => Wilaya::all()->random()->id,
        ];
    }
}
