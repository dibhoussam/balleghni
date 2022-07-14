<?php

namespace Database\Factories;

use App\Models\Authoritie;
use Illuminate\Database\Eloquent\Factories\Factory;

class AuthoritieFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = Authoritie::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'name' => $this->faker->name,
            'slug' => $this->faker->unique()->slug,
            'description' => $this->faker->sentences(4, true),
            'logo' => $this->faker->imageUrl,
        ];
    }
}
