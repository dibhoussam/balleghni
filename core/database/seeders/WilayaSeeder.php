<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Wilaya;

class WilayaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $Wilayaitems = [
            [ 'id' => '01', 'name' => 'Adrar', 'ar_name' => 'أدرار', 'slug' => 'adrar' ],
            [ 'id' => '02', 'name' => 'Chlef', 'ar_name' => 'الشلف', 'slug' => 'chlef' ],
            [ 'id' => '03', 'name' => 'Laghouat', 'ar_name' => 'الأغواط', 'slug' => 'laghouat' ],
            [ 'id' => '04', 'name' => 'Oum El Bouaghi', 'ar_name' => 'أم البواقي', 'slug' => 'oum-el-bouaghi' ],
            [ 'id' => '05', 'name' => 'Batna', 'ar_name' => 'باتنة', 'slug' => 'batna' ],
            [ 'id' => '06', 'name' => 'Béjaïa', 'ar_name' => 'بجاية', 'slug' => 'bejaia' ],
            [ 'id' => '07', 'name' => 'Biskra', 'ar_name' => 'بسكرة', 'slug' => 'biskra' ],
            [ 'id' => '08', 'name' => 'Béchar', 'ar_name' => 'بشار', 'slug' => 'bechar' ],
            [ 'id' => '09', 'name' => 'Blida', 'ar_name' => 'البليدة', 'slug' => 'blida' ],
            [ 'id' => '10', 'name' => 'Bouira', 'ar_name' => 'البويرة', 'slug' => 'bouira' ],
            [ 'id' => '11', 'name' => 'Tamanrasset', 'ar_name' => 'تمنراست', 'slug' => 'tamanrasset' ],
            [ 'id' => '12', 'name' => 'Tébessa', 'ar_name' => 'تبسة', 'slug' => 'tebessa' ],
            [ 'id' => '13', 'name' => 'Tlemcen', 'ar_name' => 'تلمسان', 'slug' => 'tlemcen' ],
            [ 'id' => '14', 'name' => 'Tiaret', 'ar_name' => 'تيارت', 'slug' => 'tiaret' ],
            [ 'id' => '15', 'name' => 'Tizi Ouzou', 'ar_name' => 'تيزي وزو', 'slug' => 'tizi-ouzou' ],
            [ 'id' => '16', 'name' => 'Alger', 'ar_name' => 'الجزائر', 'slug' => 'alger' ],
            [ 'id' => '17', 'name' => 'Djelfa', 'ar_name' => 'الجلفة', 'slug' => 'djelfa' ],
            [ 'id' => '18', 'name' => 'Jijel', 'ar_name' => 'جيجل', 'slug' => 'jijel' ],
            [ 'id' => '19', 'name' => 'Sétif', 'ar_name' => 'سطيف', 'slug' => 'setif' ],
            [ 'id' => '20', 'name' => 'Saïda', 'ar_name' => 'سعيدة', 'slug' => 'saida' ],
            [ 'id' => '21', 'name' => 'Skikda', 'ar_name' => 'سكيكدة', 'slug' => 'skikda' ],
            [ 'id' => '22', 'name' => 'Sidi Bel Abbès', 'ar_name' => 'سيدي بلعباس', 'slug' => 'sidi-bel-abbes' ],
            [ 'id' => '23', 'name' => 'Annaba', 'ar_name' => 'عنابة', 'slug' => 'annaba' ],
            [ 'id' => '24', 'name' => 'Guelma', 'ar_name' => 'قالمة', 'slug' => 'guelma' ],
            [ 'id' => '25', 'name' => 'Constantine', 'ar_name' => 'قسنطينة', 'slug' => 'constantine' ],
            [ 'id' => '26', 'name' => 'Médéa', 'ar_name' => 'المدية', 'slug' => 'medea' ],
            [ 'id' => '27', 'name' => 'Mostaganem', 'ar_name' => 'مستغانم', 'slug' => 'mostaganem' ],
            [ 'id' => '28', 'name' => "M'Sila", 'ar_name' => 'المسيلة', 'slug' => 'msila' ],
            [ 'id' => '29', 'name' => 'Mascara', 'ar_name' => 'معسكر', 'slug' => 'mascara' ],
            [ 'id' => '30', 'name' => 'Ouargla', 'ar_name' => 'ورقلة', 'slug' => 'ouargla' ],
            [ 'id' => '31', 'name' => 'Oran', 'ar_name' => 'وهران', 'slug' => 'oran' ],
            [ 'id' => '32', 'name' => 'El Bayadh', 'ar_name' => 'البيض', 'slug' => 'el-bayadh' ],
            [ 'id' => '33', 'name' => 'Illizi', 'ar_name' => 'إليزي', 'slug' => 'illizi' ],
            [ 'id' => '34', 'name' => 'Bordj Bou Arreridj', 'ar_name' => 'برج بوعريريج', 'slug' => 'bordj-bou-arreridj' ],
            [ 'id' => '35', 'name' => 'Boumerdès', 'ar_name' => 'بومرداس', 'slug' => 'boumerdes' ],
            [ 'id' => '36', 'name' => 'El Tarf', 'ar_name' => 'الطارف', 'slug' => 'el-tarf' ],
            [ 'id' => '37', 'name' => 'Tindouf', 'ar_name' => 'تندوف', 'slug' => 'tindouf' ],
            [ 'id' => '38', 'name' => 'Tissemsilt', 'ar_name' => 'تيسمسيلت', 'slug' => 'tissemsilt' ],
            [ 'id' => '39', 'name' => 'El Oued', 'ar_name' => 'الوادي', 'slug' => 'el-oued' ],
            [ 'id' => '40', 'name' => 'Khenchela', 'ar_name' => 'خنشلة', 'slug' => 'khenchela' ],
            [ 'id' => '41', 'name' => 'Souk Ahras', 'ar_name' => 'سوق أهراس', 'slug' => 'souk-ahras' ],
            [ 'id' => '42', 'name' => 'Tipaza', 'ar_name' => 'تيبازة', 'slug' => 'tipaza' ],
            [ 'id' => '43', 'name' => 'Mila', 'ar_name' => 'ميلة', 'slug' => 'mila' ],
            [ 'id' => '44', 'name' => 'Aïn Defla', 'ar_name' => 'عين الدفلة', 'slug' => 'ain-defla' ],
            [ 'id' => '45', 'name' => 'Naâma', 'ar_name' => 'النعامة', 'slug' => 'naama' ],
            [ 'id' => '46', 'name' => 'Aïn Témouchent', 'ar_name' => 'عين تيموشنت', 'slug' => 'ain-temouchent' ],
            [ 'id' => '47', 'name' => 'Ghardaïa', 'ar_name' => 'غرداية', 'slug' => 'ghardaia' ],
            [ 'id' => '48', 'name' => 'Relizane', 'ar_name' => 'غليزان', 'slug' => 'relizane' ],
            [ 'id' => '49', 'name' => 'Timimoun', 'ar_name' => 'تيميمون', 'slug' => 'timimoun' ],
            [ 'id' => '50', 'name' => 'Bordj Badji Mokhtar', 'ar_name' => 'برج باجي مختار', 'slug' => 'bordj-badji-mokhtar' ],
            [ 'id' => '51', 'name' => 'Ouled Djellal', 'ar_name' => 'أولاد جلال', 'slug' => 'ouled-djellal' ],
            [ 'id' => '52', 'name' => 'Béni Abbès', 'ar_name' => 'بني عباس', 'slug' => 'beni-abbes' ],
            [ 'id' => '53', 'name' => 'In Salah', 'ar_name' => 'عين صالح', 'slug' => 'in-salah' ],
            [ 'id' => '54', 'name' => 'In Guezzam', 'ar_name' => 'عين قزام', 'slug' => 'in-guezzam' ],
            [ 'id' => '55', 'name' => 'Touggourt', 'ar_name' => 'تقرت', 'slug' => 'touggourt' ],
            [ 'id' => '56', 'name' => 'Djanet', 'ar_name' => 'جانت', 'slug' => 'djanet' ],
            [ 'id' => '57', 'name' => 'El Meghaier', 'ar_name' => 'المغير', 'slug' => 'el-meghaier' ],
            [ 'id' => '58', 'name' => 'El Menia', 'ar_name' => 'المنيعة', 'slug' => 'el-menia' ],
        ];

        /*
         * Add Wilaya Items
         *
         */
        foreach ($Wilayaitems as $Wilayaitem) {
            $newWilayaitem = Wilaya::where('slug', '=', $Wilayaitem['slug'])->first();
            if ($newWilayaitem === null) {
                $newWilayaitem = Wilaya::create([
                    'name'          => $Wilayaitem['name'],
                    'ar_name'       => $Wilayaitem['ar_name'],
                    'slug'          => $Wilayaitem['slug'],
                    'id'          => $Wilayaitem['id'],
                ]);
            }
        }
    }
}
