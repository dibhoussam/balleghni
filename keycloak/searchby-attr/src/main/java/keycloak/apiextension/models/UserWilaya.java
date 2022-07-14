package keycloak.apiextension.models;

public class UserWilaya {
    private String userName;
    private String firstName;
    private String lastName;
    private String id;
    private String email;
    private String wilayaid;

    public UserWilaya(String userName, String firstName, String lastName, String id, String email, String wilayaid) {
        this.userName = userName;
        this.firstName = firstName;
        this.lastName = lastName;
        this.id = id;
        this.email = email;
        this.wilayaid = wilayaid;
    }
    
    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }

    public String getWilayaId() {
        return wilayaid;
    }

    public void setWilayaId(String wilayaid) {
        this.wilayaid = wilayaid;
    }
}
