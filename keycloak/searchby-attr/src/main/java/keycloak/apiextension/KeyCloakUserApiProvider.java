package keycloak.apiextension;

import org.jboss.resteasy.annotations.cache.NoCache;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.UserModel;
import org.keycloak.services.resource.RealmResourceProvider;
import org.keycloak.utils.MediaType;

import keycloak.apiextension.mappers.UserMapper;
import keycloak.apiextension.models.UserAutorite;
import keycloak.apiextension.models.UserWilaya;

import javax.ws.rs.*;
import java.util.List;
import java.util.stream.Collector;
import java.util.stream.Collectors;

public class KeyCloakUserApiProvider implements RealmResourceProvider {
    private final KeycloakSession session;
    private final String defaultAttr = "authoritie";
    private final String defaultAttrW = "wilaya";
    private final UserMapper userMapper;
    
    public KeyCloakUserApiProvider(KeycloakSession session) {
        this.session = session;
        this.userMapper = new UserMapper();
    }

    public void close() {
    }

    public Object getResource() {
        return this;
    }

    @GET
    @Path("users/search-autoritie-attr")
    @NoCache
    @Produces({ MediaType.APPLICATION_JSON })
    @Encoded
    public List<UserAutorite> searchUsersByAttributeAuthoritie(@DefaultValue(defaultAttr) @QueryParam("attr") String attr,
            @QueryParam("value") String value) {
        return session.users().searchForUserByUserAttribute (attr, value, session.getContext().getRealm()).stream()
                .map(e -> userMapper.mapToUserAutorite(e)).collect(Collectors.toList());
    }



    @GET
    @Path("users/search-wilaya-attr")
    @NoCache
    @Produces({ MediaType.APPLICATION_JSON })
    @Encoded
    public List<UserWilaya>  searchUsersByAttributeWilaya(@DefaultValue(defaultAttrW) @QueryParam("attr") String attr,
            @QueryParam("value") String value) {
        return session.users().searchForUserByUserAttribute(attr, value, session.getContext().getRealm())
                .stream().map(e -> userMapper.mapToUserWilaya(e)).collect(Collectors.toList());
    }





/*
@GET
@Path("users/search-wilaya-attr")
@NoCache
@Produces({ MediaType.APPLICATION_JSON })
@Encoded
public List<UserWilaya> searchUsersByAttributeWilaya(@DefaultValue(defaultAttrW) @QueryParam("attr") String attr,
        @QueryParam("value") String value) {
    return session.users().searchForUserByUserAttributeStream (attr, value, session.getContext().getRealm())
           .map(e -> userMapper.mapToUserWilaya(e)).collect(Collectors.toList());
}
*/
}