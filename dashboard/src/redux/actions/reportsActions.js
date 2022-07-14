import { actionTypes } from "../constants/action-types";
import axios from 'axios'
import { useHistory } from "react-router-dom";

export const setReports = (reports) => {
    return{
            type: actionTypes.SET_REPORTS,
            payload: reports
        };
}; 

export const loadReports = (props,page) => {
    return function (dispatch) {
        axios.get(`${process.env.REACT_APP_END_POINT_REPORTS_URL}?page=${page}`,
        {
            headers: { 
                Authorization: `Bearer ${props}`,
                'Cache-Control': 'no-cache',
                'Pragma': 'no-cache',
                'Expires': '0',
            }})
        .then((res) =>{
            if (res.data.data === undefined) {
                dispatch(setReports({}))
            }else
            dispatch(setReports(res.data.data))
        })
        .catch(err =>{console.log(err);})
    }
}

export const selectedReport = (report) => {
    return{
            type: actionTypes.SELECTED_REPORT,
            payload: report
        };
};

export const getReport = (props,id) =>{
    return function(dispatch) {
        axios.get(`${process.env.REACT_APP_END_POINT_REPORTS_URL}/${id}`,
        {
            headers: { 
                Authorization: `Bearer ${props}`,
                'Cache-Control': 'no-cache',
                'Pragma': 'no-cache',
                'Expires': '0',
            }})
        .then((res) =>{ 
            if (res.data.data === undefined) {
                dispatch(selectedReport({}))
            }else
            dispatch(selectedReport(res.data.data))
        })
        .catch(err =>{console.log(err);})
    }
}


export const updatedReport = (report) => {
    return{
            type: actionTypes.UPDATE_REPORT,
            payload: report
        };
};

export const updateReport = (access, id, data) => {
    return function (dispatch) {
        
        console.log(data);
        axios({
            method: 'put',
            url: `${process.env.REACT_APP_END_POINT_REPORTS_URL}/${id}`,
            data: (data),
            headers: {
                Authorization: `Bearer ${access}`,
                'Cache-Control': 'no-cache',
                'Pragma': 'no-cache',
                'Expires': '0',
            }
        }).then((response) => {
            console.log(response.data);
            dispatch(updatedReport(response.data))
            if (response.data.code !== undefined && response.data.code === 200) {
                alert("l'etat de rapport a ete modifie !")
                window.location.reload()
            }
            
        }).catch((error) => {
            console.log(error);
        })
    }
}






export const removeSelectedReport = (report) => {
    return{
            type: actionTypes.REMOVE_REPORT,
            payload: report
        };
};

export const deleteReport = (props,id) =>{
    return function(dispatch) {
        axios.delete(`${process.env.REACT_APP_END_POINT_REPORTS_URL}/${id}`,
        {
            headers: { 
                Authorization: `Bearer ${props}`,
                'Cache-Control': 'no-cache',
                'Pragma': 'no-cache',
                'Expires': '0',
            }})
        .then((res) =>{
            console.log(res.data);
            //dispatch(removeSelectedReport(res.data));
        })
        .catch(err =>{
            console.log(err);
        })
    }
}

export const reportAdded = (report) => {
    return{
            type: actionTypes.ADD_REPORT,
            payload: report
        };
};

export const addReport = (access,data) =>{
    return function (dispatch) {
        axios({
            method: 'post',
            url: process.env.REACT_APP_END_POINT_REPORTS_URL,
            data: (data),
            headers: {
                Authorization: `Bearer ${access}`,
                'Cache-Control': 'no-cache',
                    'Pragma': 'no-cache',
                    'Expires': '0',
            }
        }).then((response) => {
            console.log(response.data);
            //dispatch(reportAdded(response.data))
        }).catch((error) => {
            console.log(error);
        })
    }
}

