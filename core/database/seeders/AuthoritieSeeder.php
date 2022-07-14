<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Authoritie;

use GuzzleHttp\Client;
use GuzzleHttp\Exception\RequestException;

use GuzzleHttp\Psr7;

class AuthoritieSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $Authoritiesitems = [
            //[ 'id' => 1, 'name' => '', 'slug' => 'adrar', 'description' => '', 'logo' => '' ],
            //[ 'id' => 2, 'name' => '', 'slug' => 'chlef', 'description' => '', 'logo' => '' ],
            //[ 'id' => 3, 'name' => '', 'slug' => 'laghouat', 'description' => '', 'logo' => '' ],
            //[ 'id' => 4, 'name' => '', 'slug' => 'oum-el-bouaghi', 'description' => '', 'logo' => '' ],
            //[ 'id' => 5, 'name' => '', 'slug' => 'batna', 'description' => '', 'logo' => '' ],
            //[ 'id' => 6, 'name' => '', 'slug' => 'bejaia', 'description' => '', 'logo' => '' ],
            //[ 'id' => 7, 'name' => '', 'slug' => 'biskra', 'description' => '', 'logo' => '' ],
            //[ 'id' => 8, 'name' => '', 'slug' => 'bechar', 'description' => '', 'logo' => '' ],
            //[ 'id' => 9, 'name' => '', 'slug' => 'blida', 'description' => '', 'logo' => '' ],
            //[ 'id' => 10, 'name' => '', 'slug' => 'bouira', 'description' => '', 'logo' => '' ],
            //[ 'id' => 11, 'name' => '', 'slug' => 'tamanrasset', 'description' => '', 'logo' => '' ],
            //[ 'id' => 12, 'name' => '', 'slug' => 'tebessa', 'description' => '', 'logo' => '' ],
            //[ 'id' => 13, 'name' => '', 'slug' => 'tlemcen', 'description' => '', 'logo' => '' ],
            //[ 'id' => 14, 'name' => '', 'slug' => 'tiaret', 'description' => '', 'logo' => '' ],
            //[ 'id' => 15, 'name' => '', 'slug' => 'tizi-ouzou', 'description' => '', 'logo' => '' ],
            [ 'id' => 16, 'name' => "Wilaya d'Alger", 'slug' => 'alger', 'description' => 'ولاية الجزائر', 'logo' => 'http://41.111.148.170:8081/images/wilaya-alger.jpeg' ],
            //[ 'id' => 17, 'name' => '', 'slug' => 'djelfa', 'description' => '', 'logo' => '' ],
            //[ 'id' => 18, 'name' => '', 'slug' => 'jijel', 'description' => '', 'logo' => '' ],
            //[ 'id' => 19, 'name' => '', 'slug' => 'setif', 'description' => '', 'logo' => '' ],
            //[ 'id' => 20, 'name' => '', 'slug' => 'saida', 'description' => '', 'logo' => '' ],
            //[ 'id' => 21, 'name' => '', 'slug' => 'skikda', 'description' => '', 'logo' => '' ],
            //[ 'id' => 22, 'name' => '', 'slug' => 'sidi-bel-abbes', 'description' => '', 'logo' => '' ],
            //[ 'id' => 23, 'name' => '', 'slug' => 'annaba', 'description' => '', 'logo' => '' ],
            //[ 'id' => 24, 'name' => '', 'slug' => 'guelma', 'description' => '', 'logo' => '' ],
            //[ 'id' => 25, 'name' => '', 'slug' => 'constantine', 'description' => '', 'logo' => '' ],
            //[ 'id' => 26, 'name' => '', 'slug' => 'medea', 'description' => '', 'logo' => '' ],
            //[ 'id' => 27, 'name' => '', 'slug' => 'mostaganem', 'description' => '', 'logo' => '' ],
            //[ 'id' => 28, 'name' => '', 'slug' => 'msila', 'description' => '', 'logo' => '' ],
            //[ 'id' => 29, 'name' => '', 'slug' => 'mascara', 'description' => '', 'logo' => '' ],
            //[ 'id' => 30, 'name' => '', 'slug' => 'ouargla', 'description' => '', 'logo' => '' ],
            //[ 'id' => 31, 'name' => '', 'slug' => 'oran', 'description' => '', 'logo' => '' ],
            //[ 'id' => 32, 'name' => '', 'slug' => 'el-bayadh', 'description' => '', 'logo' => '' ],
            //[ 'id' => 33, 'name' => '', 'slug' => 'illizi', 'description' => '', 'logo' => '' ],
            //[ 'id' => 34, 'name' => '', 'slug' => 'bordj-bou-arreridj', 'description' => '', 'logo' => '' ],
            //[ 'id' => 35, 'name' => '', 'slug' => 'boumerdes', 'description' => '', 'logo' => '' ],
            //[ 'id' => 36, 'name' => '', 'slug' => 'el-tarf', 'description' => '', 'logo' => '' ],
            //[ 'id' => 37, 'name' => '', 'slug' => 'tindouf', 'description' => '', 'logo' => '' ],
            //[ 'id' => 38, 'name' => '', 'slug' => 'tissemsilt', 'description' => '', 'logo' => '' ],
            //[ 'id' => 39, 'name' => '', 'slug' => 'el-oued', 'description' => '', 'logo' => '' ],
            //[ 'id' => 40, 'name' => '', 'slug' => 'khenchela', 'description' => '', 'logo' => '' ],
            //[ 'id' => 41, 'name' => '', 'slug' => 'souk-ahras', 'description' => '', 'logo' => '' ],
            //[ 'id' => 42, 'name' => '', 'slug' => 'tipaza', 'description' => '', 'logo' => '' ],
            //[ 'id' => 43, 'name' => '', 'slug' => 'mila', 'description' => '', 'logo' => '' ],
            //[ 'id' => 44, 'name' => '', 'slug' => 'ain-defla', 'description' => '', 'logo' => '' ],
            //[ 'id' => 45, 'name' => '', 'slug' => 'naama', 'description' => '', 'logo' => '' ],
            //[ 'id' => 46, 'name' => '', 'slug' => 'ain-temouchent', 'description' => '', 'logo' => '' ],
            //[ 'id' => 47, 'name' => '', 'slug' => 'ghardaia', 'description' => '', 'logo' => '' ],
            //[ 'id' => 48, 'name' => '', 'slug' => 'relizane', 'description' => '', 'logo' => '' ],
            //[ 'id' => 49, 'name' => '', 'slug' => 'timimoun', 'description' => '', 'logo' => '' ],
            //[ 'id' => 50, 'name' => '', 'slug' => 'bordj-badji-mokhtar', 'description' => '', 'logo' => '' ],
            //[ 'id' => 51, 'name' => '', 'slug' => 'ouled-djellal', 'description' => '', 'logo' => '' ],
            //[ 'id' => 52, 'name' => '', 'slug' => 'beni-abbes', 'description' => '', 'logo' => '' ],
            //[ 'id' => 53, 'name' => '', 'slug' => 'in-salah', 'description' => '', 'logo' => '' ],
            //[ 'id' => 54, 'name' => '', 'slug' => 'in-guezzam', 'description' => '', 'logo' => '' ],
            //[ 'id' => 55, 'name' => '', 'slug' => 'touggourt', 'description' => '', 'logo' => '' ],
            //[ 'id' => 56, 'name' => '', 'slug' => 'djanet', 'description' => '', 'logo' => '' ],
            //[ 'id' => 57, 'name' => '', 'slug' => 'el-meghaier', 'description' => '', 'logo' => '' ],
            //[ 'id' => 58, 'name' => '', 'slug' => 'el-menia', 'description' => '', 'logo' => '' ],
            [ 'id' => 101, 'name' => 'Algérienne des eaux', 'slug' => 'algerieeau', 'description' => 'الجزائرية للمياه', 'logo' => 'http://41.111.148.170:8081/images/algerieeau.jpeg' ],
            [ 'id' => 102, 'name' => 'Asrout', 'slug' => 'asrout', 'description' => 'أزروت', 'logo' => 'http://41.111.148.170:8081/images/asrout.jpeg' ],
            [ 'id' => 103, 'name' => 'Algérie Télécome', 'slug' => 'at', 'description' => 'إتصالات الجزائر', 'logo' => 'http://41.111.148.170:8081/images/at.png' ],
            [ 'id' => 104, 'name' => 'Seaal', 'slug' => 'seaal', 'description' => 'سيال', 'logo' => 'http://41.111.148.170:8081/images/seaal.png' ],
            [ 'id' => 105, 'name' => 'Sonalgaz', 'slug' => 'sonalgaz', 'description' => 'سونلغاز', 'logo' => 'http://41.111.148.170:8081/images/sonalgaz.jpeg' ],
        ];

        /*
         * Add Authoritie Items
         *
         */
        foreach ($Authoritiesitems as $Authoritieitem) {
            $newAuthoritieitem = Authoritie::where('slug', '=', $Authoritieitem['slug'])->first();
            if ($newAuthoritieitem === null) {
                $newAuthoritieitem = Authoritie::create([
                    'id' => $Authoritieitem['id'],
                    'name' => $Authoritieitem['name'],
                    'slug' => $Authoritieitem['slug'],
                    'description' => $Authoritieitem['description'],
                    'logo' => $Authoritieitem['logo']
                ]);
                if($newAuthoritieitem->id > 100)
                    $this->performCreateAuthoritieDashboardRequest($newAuthoritieitem, 'POST', "/api/v1/dashboard/import/");
                else
                    $this->performCreateWilayaDashboardRequest($newAuthoritieitem, 'POST', "/api/v1/dashboard/import/");
            }
        }
    }

    public function performCreateAuthoritieDashboardRequest($authoritie, $method, $requestUrl)
    {
        $baseUri = config('services.stats.base_uri');

        $client = new Client([
            'base_uri'  =>  $baseUri,
        ]);
        
        try {
            $headers = [
                'Cookie' => config('services.stats.secret'),
                'Accept' => 'application/json'
            ];
            
            $response = $client->request($method, $requestUrl, [
                'headers'     => $headers,
                'multipart'   => [
                    [
                        'name'     => 'formData',
                        'contents' => Psr7\StreamWrapper::getResource(
                            Psr7\Utils::streamFor(
                                $this->modify_authoritie_json_file(
                                    $authoritie,
                                    storage_path('app/authoritie.json')
                                )
                            )        
                        ),
                        'headers'  => $headers
                    ],
                    [
                        'name'     => 'overwrite',
                        'contents' => false,
                        'headers'  => $headers
                    ]
                ]
            ]);

            $dashboard_id = $this->getDashboardId($authoritie, 'GET', '/api/v1/dashboard/');

            $response = $client->request('PUT', '/api/v1/dashboard/' . $dashboard_id, [
                'headers'     => $headers,
                'json'   => [
                    'published'     => true,
                    'slug' => $authoritie->slug
                ]
            ]);
        } catch(RequestException $e) {
            report($e);
        }
        
        if(!isset($response))
            return "unknown error";
        else
            return $response->getBody()->getContents();
    }

    public function performCreateWilayaDashboardRequest($authoritie, $method, $requestUrl)
    {
        $baseUri = config('services.stats.base_uri');

        $client = new Client([
            'base_uri'  =>  $baseUri,
        ]);
        
        try {
            $headers = [
                'Cookie' => config('services.stats.secret'),
                'Accept' => 'application/json'
            ];
            
            $response = $client->request($method, $requestUrl, [
                'headers'     => $headers,
                'multipart'   => [
                    [
                        'name'     => 'formData',
                        'contents' => Psr7\StreamWrapper::getResource(
                            Psr7\Utils::streamFor(
                                $this->modify_wilaya_json_file(
                                    $authoritie,
                                    storage_path('app/wilaya.json')
                                )
                            )        
                        ),
                        'headers'  => $headers
                    ],
                    [
                        'name'     => 'overwrite',
                        'contents' => true,
                        'headers'  => $headers
                    ]
                ]
            ]);

            $dashboard_id = $this->getDashboardId($authoritie, 'GET', '/api/v1/dashboard/');

            $response = $client->request('PUT', '/api/v1/dashboard/' . $dashboard_id, [
                'headers'     => $headers,
                'json'   => [
                    'published'     => true,
                    'slug' => $authoritie->slug
                ]
            ]);
        } catch(RequestException $e) {
            report($e);
        }
        
        if(!isset($response))
            return "unknown error";
        else
            return $response->getBody()->getContents();
    }

    private function getDashboardId($authoritie, $method, $requestUrl)
    {
        $baseUri = config('services.stats.base_uri');

        $client = new Client([
            'base_uri'  =>  $baseUri,
        ]);
        
        try {
            $headers = [
                'Cookie' => config('services.stats.secret'),
                'Accept' => 'application/json'
            ];
            
            $response = $client->request($method, $requestUrl, [
                'headers'     => $headers
            ]);
        } catch(RequestException $e) {
            report($e);
        }

        $json = json_decode($response->getBody());

        foreach ($json->result as $item) {
            if (str_contains($item->dashboard_title, $authoritie->name)) {
                return $item->id;
            }
        }

        return -1;
    }

    private function modify_authoritie_json_file($authoritie, $json_file_path)
    {
        //Load the file
        $contents = file_get_contents($json_file_path);

        //Decode the JSON data into a PHP array.
        $contentsDecoded = json_decode($contents, true);

        //Modify the DATA JSON FORMAT.
        $contentsDecoded['dashboards'][0]['__Dashboard__']['dashboard_title'] = $authoritie->name . " - Tableau de bord";
        for($compt = 0; $compt < count($contentsDecoded['dashboards'][0]['__Dashboard__']['slices']); $compt++) {
            $rand = random_int(2147, 2147483647) * intval(date_timestamp_get(date_create()));
            $contentsDecoded['dashboards'][0]['__Dashboard__']['position_json'] = str_replace(
                '"chartId":'. $contentsDecoded['dashboards'][0]['__Dashboard__']['slices'][$compt]['__Slice__']['id'] . ',',
                '"chartId":'. $rand .',',
                $contentsDecoded['dashboards'][0]['__Dashboard__']['position_json']
            );
            $contentsDecoded['dashboards'][0]['__Dashboard__']['slices'][$compt]['__Slice__']['id'] = $rand;
            $contentsDecoded['dashboards'][0]['__Dashboard__']['slices'][$compt]['__Slice__']['params'] = str_replace(
                '<%= authoritie_str_to_replace_3 %>',
                '"slice_id": "'. $rand .'"',
                $contentsDecoded['dashboards'][0]['__Dashboard__']['slices'][$compt]['__Slice__']['params']
            );
            $contentsDecoded['dashboards'][0]['__Dashboard__']['slices'][$compt]['__Slice__']['query_context'] = str_replace(
                '<%= authoritie_str_to_replace_3 %>',
                '"slice_id": "'. $rand .'"',
                $contentsDecoded['dashboards'][0]['__Dashboard__']['slices'][$compt]['__Slice__']['query_context']
            );
            $contentsDecoded['dashboards'][0]['__Dashboard__']['slices'][$compt]['__Slice__']['params'] = str_replace(
                '<%= authoritie_str_to_replace_4 %>',
                '"remote_id": "'. $rand .'"',
                $contentsDecoded['dashboards'][0]['__Dashboard__']['slices'][$compt]['__Slice__']['params']
            );
        }
        //Encode the array back into a JSON string.
        $json = json_encode($contentsDecoded);

        //Modify the DATA TEXT FORMAT.
        $result_tmp_1 = str_replace(
            '<%= authoritie_str_to_replace_1 %>',
            '\"authoritie_id\",\"op\":\"==\",\"val\":\"'. $authoritie->id .'\"',
            $json
        );
        $result = str_replace(
            '<%= authoritie_str_to_replace_2 %>',
            '\"comparator\":\"'. $authoritie->id .'\"',
            $result_tmp_1
        );
        
        return $result;
    }

    private function modify_wilaya_json_file($authoritie, $json_file_path)
    {
        //Load the file
        $contents = file_get_contents($json_file_path);

        //Decode the JSON data into a PHP array.
        $contentsDecoded = json_decode($contents, true);

        //Modify the DATA JSON FORMAT.
        $contentsDecoded['dashboards'][0]['__Dashboard__']['dashboard_title'] = $authoritie->name . " - Tableau de bord";
        for($compt = 0; $compt < count($contentsDecoded['dashboards'][0]['__Dashboard__']['slices']); $compt++) {
            $rand = random_int(2147, 2147483647) * intval(date_timestamp_get(date_create()));
            $contentsDecoded['dashboards'][0]['__Dashboard__']['position_json'] = str_replace(
                '"chartId":'. $contentsDecoded['dashboards'][0]['__Dashboard__']['slices'][$compt]['__Slice__']['id'] . ',',
                '"chartId":'. $rand .',',
                $contentsDecoded['dashboards'][0]['__Dashboard__']['position_json']
            );
            $contentsDecoded['dashboards'][0]['__Dashboard__']['slices'][$compt]['__Slice__']['id'] = $rand;
            $contentsDecoded['dashboards'][0]['__Dashboard__']['slices'][$compt]['__Slice__']['params'] = str_replace(
                '<%= authoritie_str_to_replace_3 %>',
                '"slice_id": "'. $rand .'"',
                $contentsDecoded['dashboards'][0]['__Dashboard__']['slices'][$compt]['__Slice__']['params']
            );
            $contentsDecoded['dashboards'][0]['__Dashboard__']['slices'][$compt]['__Slice__']['query_context'] = str_replace(
                '<%= authoritie_str_to_replace_3 %>',
                '"slice_id": "'. $rand .'"',
                $contentsDecoded['dashboards'][0]['__Dashboard__']['slices'][$compt]['__Slice__']['query_context']
            );
            $contentsDecoded['dashboards'][0]['__Dashboard__']['slices'][$compt]['__Slice__']['params'] = str_replace(
                '<%= authoritie_str_to_replace_4 %>',
                '"remote_id": "'. $rand .'"',
                $contentsDecoded['dashboards'][0]['__Dashboard__']['slices'][$compt]['__Slice__']['params']
            );
        }

        //Encode the array back into a JSON string.
        $json = json_encode($contentsDecoded);

        //Modify the DATA TEXT FORMAT.
        $result_tmp = str_replace(
            '<%= authoritie_str_to_replace_1 %>',
            '\"wilaya_id\",\"op\":\"==\",\"val\":\"'. $authoritie->id .'\"',
            $json
        );
        $result = str_replace(
            '<%= authoritie_str_to_replace_2 %>',
            '\"comparator\": \"'. $authoritie->id .'\"',
            $result_tmp
        );
        
        return $result;
    }
}
