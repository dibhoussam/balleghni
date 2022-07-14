<?php

namespace Database\Factories;

use App\Models\AuthoritieBranchPhone;
use App\Models\AuthoritieBranch;
use App\Models\Authoritie;
use App\Models\Location;
use Illuminate\Database\Eloquent\Factories\Factory;

class AuthoritieBranchFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = AuthoritieBranch::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'location_id' => Location::factory()->create()->id,
            'authoritie_id' => Authoritie::all()->random()->id,
            'email' => $this->faker->safeEmail,
            'map_link' => $this->faker->url,
            'dg' => $this->faker->boolean,
        ];
    }

    /**
     * Configure the model factory.
     *
     * @return $this
     */
    public function configure()
    {
        return $this->afterMaking(function (AuthoritieBranch $branch) {
            //
        })->afterCreating(function (AuthoritieBranch $branch) {
            $phones = AuthoritieBranchPhone::factory()->count(2)->create();
            $branch->phones()->saveMany($phones);
        });
    }
}
