<?php

namespace Database\Factories;

use App\Models\AuthoritieBranch;
use App\Models\AuthoritieBranchPhone;
use Illuminate\Database\Eloquent\Factories\Factory;

class AuthoritieBranchPhoneFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = AuthoritieBranchPhone::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'authoritieBranch_id' => AuthoritieBranch::all()->random()->id,
            'phone' => $this->faker->sentence,
            'description' => $this->faker->phoneNumber,
        ];
    }

}
