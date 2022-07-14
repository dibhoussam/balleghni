import { actionTypes } from "../constants/action-types";
import axios from "axios";

export const setWilayas = (wilayas) => {
    return{
            type: actionTypes.SET_WILAYAS,
            payload: wilayas
        };
}; 

export const loadWilayas = (props) => {
    return function (dispatch) {
        axios.get(`${process.env.REACT_APP_END_POINT_WILAYAS_URL}`,
        {
            headers: { 
                Authorization: `Bearer ${props}`,
                'Cache-Control': 'no-cache',
                'Pragma': 'no-cache',
                'Expires': '0',
            }})
        .then((res) =>{
            console.log(res.data.data);
            dispatch(setWilayas(res.data.data))
        })
        .catch(err =>{console.log(err);})
    }
}

export const selectedWilaya = (wilaya) => {
    return{
            type: actionTypes.SELECTED_WILAYA,
            payload: wilaya
        };
};

export const setDairas = (dairas) => {
    return{
            type: actionTypes.SET_DAIRAS,
            payload: dairas
        };
};

export const selectedDaira = (daira) => {
    return{
            type: actionTypes.SELECTED_DAIRA,
            payload: daira
        };
};

export const setCommunes = (communes) => {
    return{
            type: actionTypes.SET_COMMUNES,
            payload: communes
        };
};

export const selectedCommune = (commune) => {
    return{
            type: actionTypes.SELECTED_COMMUNE,
            payload: commune
        };
};




