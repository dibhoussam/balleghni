<?php

namespace Database\Factories;

use App\Models\IncidentType;
use App\Models\Authoritie;
use Illuminate\Database\Eloquent\Factories\Factory;

class IncidentTypeFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = IncidentType::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'title' => $this->faker->name,
            'slug' => $this->faker->unique()->slug,
            'description' => $this->faker->sentences(4, true),
            'icon' => $this->faker->imageUrl,
            'authoritie_id' => Authoritie::all()->random()->id,
        ];
    }
}
