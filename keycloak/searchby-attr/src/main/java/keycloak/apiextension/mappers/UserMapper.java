package keycloak.apiextension.mappers;

import org.keycloak.models.UserModel;

import keycloak.apiextension.models.UserAutorite;
import keycloak.apiextension.models.UserWilaya;

public class UserMapper {
    
    public  UserAutorite mapToUserAutorite(UserModel um) {
       
       
        return new UserAutorite(
            um.getUsername(),
            um.getFirstName(),
            um.getLastName(),
            um.getId(),
            um.getEmail(),
            um.getAttribute ("authoritie").get(0)
            );

    }
    public  UserWilaya mapToUserWilaya(UserModel um) {
        return new UserWilaya(
            um.getUsername(),
            um.getFirstName(),
            um.getLastName(),
            um.getId(),
            um.getEmail(),um.getAttribute("wilaya").get(0)
            );

    }
 



}
