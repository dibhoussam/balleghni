import { actionTypes } from "../constants/action-types";
import axios from "axios";


export const AuthoritieUsersLoad = (authoritieUsers) => {
    return (
        {
            type: actionTypes.AUTHORITIE_USERS_LOADED,
            payload: authoritieUsers
        }
    )
}

export const loadAuthoritieUsers = (access, id) => {
    return function (dispatch) {
        axios.get(`${process.env.REACT_APP_END_POINT_USERS_AUTHORITIE_URL}/${id}`,
            {
                headers: {
                    Authorization: `Bearer ${access}`,
                    'Cache-Control': 'no-cache',
                    'Pragma': 'no-cache',
                    'Expires': '0',
                }
            })
            .then((res) => {
                console.log(res);
                if (res.data.collection === undefined) {
                    dispatch(AuthoritieUsersLoad([]))
                } else
                    dispatch(AuthoritieUsersLoad(res.data.collection))
            })
            .catch(err => { console.log(err); })
    }
}

export const WilayaUsersLoad = (authoritieUsers) => {
    return (
        {
            type: actionTypes.WILAYA_USERS_LOADED,
            payload: authoritieUsers
        }
    )
}

export const loadWilayaUsers = (access, id) => {
    return function (dispatch) {
        axios.get(`${process.env.REACT_APP_END_POINT_USERS_WILAYA_URL}/${id}`,
            {
                headers: {
                    Authorization: `Bearer ${access}`,
                    'Cache-Control': 'no-cache',
                    'Pragma': 'no-cache',
                    'Expires': '0',
                }
            })
            .then((res) => {
                console.log(res);
                if (res.data.collection === undefined) {
                    dispatch(WilayaUsersLoad([]))
                } else
                    dispatch(WilayaUsersLoad(res.data.collection))
            })
            .catch(err => { console.log(err); })
    }
}

export const UserAdded = (user) => {
    return (
        {
            type: actionTypes.ADD_USER,
            payload: user
        }
    )
}

export const addUser = (access, data) => {
    return function (dispatch) {
        
        console.log(data);
        let uRL = ""
        if (data.attributes.hasOwnProperty("wilaya")) {
            uRL = process.env.REACT_APP_END_POINT_USERS_WILAYA_URL
        } else
            uRL = process.env.REACT_APP_END_POINT_USERS_AUTHORITIE_URL
        console.log(uRL);
        axios({
            method: 'post',
            url: `${uRL}`,
            data: (data),
            headers: {
                Authorization: `Bearer ${access}`,
                'Cache-Control': 'no-cache',
                'Pragma': 'no-cache',
                'Expires': '0',
            }
        }).then((response) => {
            console.log("3333333333333333333333");
            console.log(response);
            console.log("3333333333333333333333");
            if (response.data.error_log.http_status_code === 409) {
                alert("Utilisateur existe deja !!")
            }else
                dispatch(UserAdded(response.data))
            
        }).catch((error) => {
            console.log(error);
        })
    }
}

export const userUpdated = (user) => {
    return {
        type: actionTypes.UPDATE_USER,
        payload: user
    };
};

export const updateUser = (access, id, data,type) => {
    return function (dispatch) {
        console.log(type);
        let uRL = ""
        console.log(data);
        if (type === 1) {
            uRL = process.env.REACT_APP_END_POINT_USERS_AUTHORITIE_URL

        }else if (type === 2) {
            uRL = process.env.REACT_APP_END_POINT_USERS_WILAYA_URL
        }
        
        console.log(uRL);

        axios({
            method: 'put',
            url: `${uRL}/${id}`,
            data: (data),
            headers: {
                Authorization: `Bearer ${access}`,
                'Cache-Control': 'no-cache',
                'Pragma': 'no-cache',
                'Expires': '0',
            }
        }).then((response) => {
            console.log(response.data);
            dispatch(userUpdated(response.data))
            
        }).catch((error) => {
            console.log(error);
        })
    }
}

export const removeSelectedUser = (user) => {
    return {
        type: actionTypes.DELETE_USER,
        payload: user
    };
};

export const deleteUser = (access, id,idWilaya) => {
    return function (dispatch) {
        let url = process.env.REACT_APP_END_POINT_USERS_WILAYA_URL
        axios.delete(`${url}/${id}`,
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
                dispatch(removeSelectedUser(res.data));
                dispatch(loadWilayaUsers(access,idWilaya))
            })
            .catch(err => {
                console.log(err);
            })
    }
}