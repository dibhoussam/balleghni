<?php

namespace Database\Factories;

use App\Models\Wilaya;
use Illuminate\Database\Eloquent\Factories\Factory;

class WilayaFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = Wilaya::class;

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
            'logo' => $this->faker->imageUrl,
            'map_link' => $this->faker->url,
        ];
    }
}
