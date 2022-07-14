import { actionTypes } from "../constants/action-types";
import axios from "axios";
import jwt_decode from "jwt-decode";

export const userLogin = (user) =>{
    return(
        {
            type : actionTypes.USER_LOGIN,
            payload : user
        }
    )
}

export const userLogout = () => {
    return(
        {
            type : actionTypes.USER_LOGOUT,
            payload : null
        }
    )
}

export const userInfo = (userInfo) => {
    return(
        {
            type : actionTypes.USER_INFO,
            payload : userInfo
        }
    )
}

export const logout = () => {
    return function (dispatch) {
        dispatch(userLogout());
        removeTokenFromLocalStorage();
    }
}

export const login = ({username,password}) =>{
    return function (dispatch) {
        var reqData = `username=${username}&password=${password}`;
        axios({
            method: 'post',
            url: process.env.REACT_APP_END_POINT_AUTHENTICATION_URL,
            data: (reqData),

            headers: {
                "Content-Type": "application/x-www-form-urlencoded",
                'Cache-Control': 'no-cache',
                    'Pragma': 'no-cache',
                    'Expires': '0',
            }
        }).then((response) => {
            console.log(response.data);
            saveTokenInLocalStorage(response.data)
            dispatch(userLogin(response.data))
            dispatch(userInfo(jwt_decode(response.data.access_token)))
            
        }).catch((error) => {
            console.log(error);
        })
    }
}

export const saveTokenInLocalStorage = (token) =>{
    localStorage.setItem('userDetails' , JSON.stringify(token))
}

export const checkAutoLogin = (dispatch) => {
    const token = localStorage.getItem('userDetails')
    if (!token) {
        dispatch(logout())
        return
    }
    const jsToken = JSON.parse(token)
    dispatch(userLogin(jsToken))
    dispatch(userInfo(jwt_decode(jsToken.access_token)))
}

export const removeTokenFromLocalStorage = () => {
    localStorage.removeItem('userDetails')

} 