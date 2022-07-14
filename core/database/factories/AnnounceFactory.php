<?php

namespace Database\Factories;

use App\Models\Announce;
use App\Models\Authoritie;
use Illuminate\Database\Eloquent\Factories\Factory;

class AnnounceFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = Announce::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'title' => $this->faker->name,
            'description' => $this->faker->sentences(4, true),
            'file' => $this->faker->imageUrl,
            'authoritie_id' => Authoritie::all()->random()->id,
        ];
    }
}
