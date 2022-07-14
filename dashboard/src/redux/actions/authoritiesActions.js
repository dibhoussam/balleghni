import { actionTypes } from "../constants/action-types";
import axios from "axios";
import { useHistory } from "react-router-dom";


export const setAuthorities = (authorities) => {
    return {
        type: actionTypes.SET_AUTHORITIES,
        payload: authorities
    };
};

export const resetAuthorities = () => {
    return {
        type: actionTypes.RESET_AUTHORITIES,
    }
}

export const loadAuthorities = (props, page) => {
    return function (dispatch) {

        axios.get(`${process.env.REACT_APP_END_POINT_AUTHORITIES_URL}?page=${page}`,
            {
                headers: {
                    Authorization: `Bearer ${props}`,
                    'Cache-Control': 'no-cache',
                    'Pragma': 'no-cache',
                    'Expires': '0',
                }
            })
            .then((res) => {
                console.log(res);
                if (res.data.data === undefined) {
                    dispatch(setAuthorities({}))
                } else
                    dispatch(setAuthorities(res.data.data))
            })
            .catch(err => { console.log(err); })
    }
}

export const selectedAuthoritie = (authoritie) => {
    return {
        type: actionTypes.SELECTED_AUTHORITIE,
        payload: authoritie
    };
};

export const getAuthoritie = (props, id) => {
    return function (dispatch) {
        axios.get(`${process.env.REACT_APP_END_POINT_AUTHORITIES_URL}/${id}`,
            {
                headers: {
                    Authorization: `Bearer ${props}`,
                    'Cache-Control': 'no-cache',
                    'Pragma': 'no-cache',
                    'Expires': '0',
                }
            })
            .then((res) => {
                if (res.data.data === undefined) {
                    dispatch(selectedAuthoritie({}))
                } else
                    dispatch(selectedAuthoritie(res.data.data))

            })
            .catch(err => { console.log(err); })
    }
}


export const removeAuthoritie = (removedAuthoritie) => {
    return {
        type: actionTypes.REMOVE_AUTHORITIE,
        payload: removedAuthoritie
    };
};

export const removeSelectedAuthoritie = (removedAuthoritie) => {
    return {
        type: actionTypes.REMOVE_SELECTED_AUTHORITIE,
    };
};

export const deleteAthoritie = (access, id, page) => {
    return function (dispatch) {
        axios.delete(`${process.env.REACT_APP_END_POINT_AUTHORITIES_URL}/${id}`,
            {
                headers: {
                    Authorization: `Bearer ${access}`,
                    'Cache-Control': 'no-cache',
                    'Pragma': 'no-cache',
                    'Expires': '0',
                }
            })
            .then((res) => {
                console.log(res.data);
                dispatch(removeAuthoritie(res.data));

                //setTimeout(()=>{dispatch(loadAuthorities(access,page))},20000)


            })
            .catch(err => {
                console.log(err);
            })
    }
}


export const authoritieAdded = (authoritie) => {
    return {
        type: actionTypes.ADD_AUTHORITIE,
        payload: authoritie
    };
};

export const addAuthoritie = (access, data, image) => {
    return function (dispatch) {
        
        let formData = new FormData();
        formData.append('file', image)
        //console.log(access);
        console.log(image);
        axios.post(process.env.REACT_APP_END_POINT_IMAGES_URL, formData,
            {
                headers: {
                    "Content-Type": "multipart/form-data",
                    Authorization: `Bearer ${access}`,
                    'Cache-Control': 'no-cache',
                    'Pragma': 'no-cache',
                    'Expires': '0',
                }
            }).then(res => {

                data.logo = res.data.url
                axios({
                    method: 'post',
                    url: `${process.env.REACT_APP_END_POINT_AUTHORITIES_URL}`,
                    data: (data),
                    headers: {
                        Authorization: `Bearer ${access}`,
                        'Cache-Control': 'no-cache',
                        'Pragma': 'no-cache',
                        'Expires': '0',
                    }
                }).then((response) => {
                    console.log(response.data);
                    console.log(response.data);
                        if (response.data.code !== undefined && response.data.code === 201) {
                            alert("Authoritie ajoutee !")
                        }else
                        alert("Erreur d'ajout d'authoritie")
                    dispatch(authoritieAdded(response.data))
                    dispatch(loadAuthorities(access))
                    
                }).catch((error) => {
                    console.log(error);
                })
            })
            .catch(err => {
                console.log(err);
            })
    }
}
 
export const updatedAuthoritie = (authoritie) => {
    return {
        type: actionTypes.UPDATE_AUTHORITIE,
        payload: authoritie
    };
};

export const updateAuthoritie = (access, id, data, image, imgUpdated) => {
    return function (dispatch) {
        
        if (imgUpdated === true) {
            let formData = new FormData();
            formData.append("file", image)
            console.log(data);
            //console.log(access);
            axios.post(process.env.REACT_APP_END_POINT_IMAGES_URL, formData,
                {
                    headers: {
                        "Content-Type": "multipart/form-data",
                        Authorization: `Bearer ${access}`,
                        'Cache-Control': 'no-cache',
                        'Pragma': 'no-cache',
                        'Expires': '0',
                    }
                }).then(res => {
                    data.logo = res.data.url
                    console.log(data);
                    axios({
                        method: 'put',
                        url: `${process.env.REACT_APP_END_POINT_AUTHORITIES_URL}/${id}`,
                        data: (data),
                        headers: {
                            Authorization: `Bearer ${access}`,
                            'Cache-Control': 'no-cache',
                            'Pragma': 'no-cache',
                            'Expires': '0',
                        }
                    }).then((response) => {
                        console.log(response.data);
                        if (response.data.code !== undefined && response.data.code === 200) {
                            alert("MAJ authoritie reusit")
                        }
                        dispatch(updatedAuthoritie(response.data))
                        dispatch(loadAuthorities(access))
                      
                    }).catch((error) => {
                        console.log(error);
                    })
                })
                .catch(err => {
                    console.log(err);
                })
        } else {
            axios({
                method: 'put',
                url: `${process.env.REACT_APP_END_POINT_AUTHORITIES_URL}/${id}`,
                data: (data),
                headers: {
                    Authorization: `Bearer ${access}`,
                    'Cache-Control': 'no-cache',
                    'Pragma': 'no-cache',
                    'Expires': '0',
                }
            }).then((response) => {
                console.log(response.data);
                if (response.data.code !== undefined && response.data.code === 200) {
                    alert("MAJ authoritie reusit")
                }
                dispatch(updatedAuthoritie(response.data))
                dispatch(loadAuthorities(access, 1))
              
            }).catch((error) => {
                console.log(error);
            })
        }

    }
}

