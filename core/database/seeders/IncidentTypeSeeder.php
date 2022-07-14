<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\IncidentType;
use App\Models\Authoritie;

class IncidentTypeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $IncidentTypeitems = [
            [ 'title' => 'Animaux et nuisibles', 'slug' => 'animaux-nuisible', 'description' => 'animeaux et nuisibles', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => 'Commentaires et demande générale', 'slug' => 'comm-demande-generale', 'description' => 'Commentaires et demande générale', 'icon' => 'https://cdn-icons.flaticon.com/png/512/1545/premium/1545951.png?token=exp=1645233958~hmac=4ec6efd82cc62d9e9f0e09f860bfbb33', 'authoritie_id' => 1 ],
            [ 'title' => 'Graffitis et vandalisme', 'slug' => 'graffiti-vandalisme', 'description' => 'Graffitis et vandalisme', 'icon' => 'https://cdn-icons.flaticon.com/png/512/1545/premium/1545951.png?token=exp=1645233958~hmac=4ec6efd82cc62d9e9f0e09f860bfbb33', 'authoritie_id' => 1 ],
            [ 'title' => 'Bruit et pollution', 'slug' => 'bruit-pollution', 'description' => 'Bruit et pollution', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Pollution de leau", 'slug' => 'pollution-eau', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Pneus sous-évalués", 'slug' => 'pneus-sous-evalues', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Bruit - animal", 'slug' => 'brui-animal', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Bruit - construction", 'slug' => 'bruit-construction', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Bruit - général", 'slug' => 'bruit-general', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Pollution - général", 'slug' => 'pollution-general', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Véhicule abandonné", 'slug' => 'vehicule-abandonne', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Stationnement - handicapé", 'slug' => 'stationnement-handicape', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Stationnement - illégal", 'slug' => 'stationnement-illegal', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Parking et voitures - général", 'slug' => 'parking-voitures-general', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Parcs et équipements municipaux", 'slug' => 'parcs-voitures-general', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Végétation envahie", 'slug' => 'vegetation-envahie', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Toilette publique", 'slug' => 'toilette-publique', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Ordures et poubelles - général", 'slug' => 'ordures-poubelles', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Parc - demande générale", 'slug' => 'parc-demande-generale', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Chaussée et sentier", 'slug' => 'chaussee-sentier', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Trottoir - endommagé", 'slug' => 'trottoire-endommage', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Chaussée - général", 'slug' => 'chaussee-general', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Fosse et équipement", 'slug' => 'fosse-equipement', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Câbles aériens", 'slug' => 'cables-aeriens', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Lampadaire - général", 'slug' => 'lampadaire-general', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Eclairage public de route principale", 'slug' => 'eclairage-public', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Route endommagée", 'slug' => 'route-endommagee', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Nid-de-poule", 'slug' => 'nid-poule', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Blocage de la route", 'slug' => 'blocage-route', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Signalisation routière", 'slug' => 'signalisation-routiere', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Nettoyage des rues", 'slug' => 'nettoyage-rues', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Gouttières / eaux pluviales", 'slug' => 'gouttieres-eau-pluviales', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Routes - général", 'slug' => 'routes-general', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Poteaux et signalisation - général", 'slug' => 'poteaux-signalisation', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Ordures déversées", 'slug' => 'ordures-deversees', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Pneus sous-évalués", 'slug' => 'pneus-sous-evalues', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Litière", 'slug' => 'litiere', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Demander la réparation ou le remplacement du bac", 'slug' => 'demander-reparation-remplacement-bac', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Ordures et poubelles - général", 'slug' => 'ordures-poubelles-general', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Arbre tombé", 'slug' => 'arbre-tombé', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Eau et égout", 'slug' => 'eau-egout', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Fuite compteur", 'slug' => 'fuite-compteur', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Pas d'eau à la propriété", 'slug' => 'pas-eau', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Egout - fuite / blocage", 'slug' => 'egout-fuit-blocage', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Egout - odeur", 'slug' => 'egout-odeur', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Egout général", 'slug' => 'egout-general', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Gouttières / eaux pluviales", 'slug' => 'gouttieres-eaux-pluviales', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Général de l'eau", 'slug' => 'general-eau', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ],
            [ 'title' => "Fuite d'eau ", 'slug' => 'fuite-eau', 'description' => 'Pollution de leau', 'icon' => 'https://cdn-icons.flaticon.com/png/512/3477/premium/3477117.png?token=exp=1645233958~hmac=0a2cbfaf9e69fb511d3d0c836d41ef4d', 'authoritie_id' => 1 ]
        ];

        /*
         * Add IncidentType Items
         *
         */
        foreach ($IncidentTypeitems as $IncidentTypeitem) {
            $newIncidentTypeitem = IncidentType::where('slug', '=', $IncidentTypeitem['slug'])->first();
            if ($newIncidentTypeitem === null) {
                $newIncidentTypeitem = IncidentType::create([
                    'title' => $IncidentTypeitem['title'],
                    'slug' => $IncidentTypeitem['slug'],
                    'description' => $IncidentTypeitem['description'],
                    'icon' => $IncidentTypeitem['icon'],
                    'authoritie_id' => Authoritie::all()->random()->id,
                ]);
            }
        }
    }
}