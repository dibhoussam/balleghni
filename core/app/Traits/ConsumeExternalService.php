<?php

namespace App\Traits;

use GuzzleHttp\Client;
use GuzzleHttp\Exception\RequestException;

use GuzzleHttp\Psr7;

trait ConsumeExternalService
{
    /**
     * Send request to any service
     * @param $method
     * @param $requestUrl
     * @param array $formParams
     * @param array $headers
     * @return string
     */
    public function performRequest($method, $requestUrl, $formParams = [], $headers = [])
    {
        $client = new Client([
            'base_uri'  =>  $this->baseUri,
        ]);

        if(isset($this->secret))
        {
            $headers['Authorization'] = $this->secret;
        }

        try {
            $response = $client->request($method, $requestUrl, [
                'form_params' => $formParams,
                'headers'     => $headers,
            ]);
        } catch(RequestException $e) {
            return null;
        }
        
        return $response->getBody()->getContents();
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

    public function performDeleteDashboardRequest($authoritie)
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

            $dashboard_id = $this->getDashboardIdBySlug($authoritie, 'GET', '/api/v1/dashboard/');

            if($dashboard_id)
                $response = $client->request('DELETE', '/api/v1/dashboard/?q=['. $dashboard_id .']', [
                    'headers'     => $headers
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
        $client = new Client([
            'base_uri'  =>  $this->baseUri,
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

    private function getDashboardIdBySlug($authoritie, $method, $requestUrl)
    {
        $client = new Client([
            'base_uri'  =>  $this->baseUri,
        ]);
        
        try {
            $headers = [
                'Cookie' => config('services.stats.secret'),
                'Accept' => 'application/json'
            ];
            
            $response = $client->request($method, $requestUrl . $authoritie->slug, [
                'headers'     => $headers
            ]);
        } catch(RequestException $e) {
            report($e);
        }

        if(isset($response)) {
            $json = json_decode($response->getBody());
            if(isset($json->result))
                return $json->result->id;
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

    public function performDeleteImageRequest($images)
    {
        $baseUri = config('services.images.base_uri');

        $client = new Client([
            'base_uri'  =>  $baseUri,
        ]);
        
        try {
            $headers = [
                'Accept' => 'application/json'
            ];

            foreach($images as $image) {
                $response = $client->request('GET', str_replace('images', 'delete', $image->delete_image), [
                    'headers'     => $headers
                ]);
                $response = $client->request('GET', str_replace('images', 'delete', $image->delete_thumbnail), [
                    'headers'     => $headers
                ]);
            }
        } catch(RequestException $e) {
            report($e);
        }
        
        if(!isset($response))
            return "unknown error";
        else
            return $response->getBody()->getContents();
    }
}