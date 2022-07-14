<?php

use App\Http\Controllers\AuthoritieController;
use App\Http\Controllers\AuthoritieBranchController;
use App\Http\Controllers\AnnounceController;
use App\Http\Controllers\IncidentTypeController;
use App\Http\Controllers\ReportController;

/** @var \Laravel\Lumen\Routing\Router $router */

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/
$router->group(['prefix' => 'api', 'middleware' => 'auth'], function () use ($router) {
    // Authorities
    $router->get    ('authorities',                    'AuthoritieController@index'              );/**CHECKED**/
    $router->get    ('authorities/all',                'AuthoritieController@indexWithOutPagination'              );/**CHECKED**/
    $router->get    ('authorities/{id:[0-9]+}',        'AuthoritieController@show'               );/**CHECKED**/
    $router->post   ('authorities',                    'AuthoritieController@store'              );/**CHECKED**/
    //$router->batch  ('authorities',                    'AuthoritieController@storeBatch'         );
    $router->put    ('authorities/{id}',               'AuthoritieController@update'             );/**CHECKED**/
    $router->delete ('authorities/{id}',               'AuthoritieController@destroy'            );/**CHECKED**/
    //$router->delete ('authorities',                    'AuthoritieController@deleteBatch'        );
    // Authoritie Branchs
    $router->get    ('branchs',                        'AuthoritieBranchController@index'        );/**CHECKED**/
    $router->get    ('branchs/all',                    'AuthoritieBranchController@indexWithOutPagination'        );/**CHECKED**/
    $router->get    ('branchs/{id:[0-9]+}',            'AuthoritieBranchController@show'         );/**CHECKED**/
    $router->post   ('branchs',                        'AuthoritieBranchController@store'        );/**CHECKED**/
    //$router->batch  ('branchs/authoritie/{id}',        'AuthoritieBranchController@storeBatch'   );
    $router->put    ('branchs/{id}',                   'AuthoritieBranchController@update'       );/**CHECKED**/
    $router->delete ('branchs/{id}',                   'AuthoritieBranchController@destroy'      );/**CHECKED**/
    //$router->delete ('branchs',                        'AuthoritieBranchController@deleteBatch'  );
    // Announces
    $router->get    ('announces',                        'AnnounceController@index'                );/**CHECKED**/
    $router->get    ('announces/all',                    'AnnounceController@indexWithOutPagination'   );/**CHECKED**/
    $router->get    ('announces/{id:[0-9]+}',            'AnnounceController@show'                 );/**CHECKED**/
    $router->get    ('announces/authoritie/{id:[0-9]+}', 'AnnounceController@showByAuthoritieId'   );/**CHECKED**/
    $router->get    ('announces/authoritie/all/{id:[0-9]+}', 'AnnounceController@showByAuthoritieIdWithOutPagination'   );/**CHECKED**/
    $router->post   ('announces',                        'AnnounceController@store'                );/**CHECKED**/
    $router->put    ('announces/{id}',                   'AnnounceController@update'               );/**CHECKED**/
    $router->delete ('announces/{id}',                   'AnnounceController@destroy'              );/**CHECKED**/
    //$router->delete ('announces',                      'AnnounceController@deleteBatch'          );
    // Incident Types
    $router->get    ('incidents',                      'IncidentTypeController@index'            );/**CHECKED**/
    $router->get    ('incidents/{id}',                 'IncidentTypeController@show'             );/**CHECKED**/
    $router->post   ('incidents',                      'IncidentTypeController@store'            );/**CHECKED**/
    //$router->batch  ('incidents',                      'IncidentTypeController@storeBatch'       );
    $router->put    ('incidents/{id}',                 'IncidentTypeController@update'           );/**CHECKED**/
    $router->delete ('incidents/{id}',                 'IncidentTypeController@destroy'          );/**CHECKED**/
    //$router->delete ('incidents',                      'IncidentTypeController@deleteBatch'      );
    // Wilayas
    $router->get    ('wilayas',                        'WilayaController@index'                  );/**CHECKED**/
    $router->get    ('wilayas/{id}',                   'WilayaController@show'                  );/**CHECKED**/
    $router->get    ('dairas',                         'DairaController@index'                  );/**CHECKED**/
    $router->get    ('dairas/{id}',                    'DairaController@show'                  );/**CHECKED**/
    $router->get    ('communes',                       'CommuneController@index'                  );/**CHECKED**/
    $router->get    ('communes/{id}',                  'CommuneController@show'                  );/**CHECKED**/
    // Reports
    $router->get    ('reports/all',                    'ReportController@indexAll'               );/**CHECKED**/
    $router->get    ('reports/all/nopag',                    'ReportController@indexAllWithOutPagination'               );/**CHECKED**/
    $router->get    ('reports',                        'ReportController@index'                  );/**CHECKED**/
    $router->get    ('reports/nopag',                        'ReportController@indexWithOutPagination'                  );/**CHECKED**/
    $router->get    ('reports/{id:[0-9]+}',            'ReportController@show'                   );/**CHECKED**/
    $router->get    ('reports/incidents',              'ReportController@showByIncidents'        );/**CHECKED**/
    $router->get    ('reports/incidents/all',              'ReportController@showByIncidentsWithOutPagination'        );/**CHECKED**/
    $router->get    ('reports/authorities',            'ReportController@showByAuthorities'      );/**CHECKED**/
    $router->get    ('reports/authorities/all',            'ReportController@showByAuthoritiesWithOutPagination'      );/**CHECKED**/
    $router->post   ('reports/nearby',                 'ReportController@showNearBy'             );/**CHECKED**/
    $router->post   ('reports',                        'ReportController@store'                  );/**CHECKED**/
    $router->put    ('reports/{id}',                   'ReportController@update'                 );/**CHECKED**/
    $router->delete ('reports/{id}',                   'ReportController@destroy'                );/**CHECKED**/
});






//['middleware' => 'auth', 'uses' => 'ReportController@index']