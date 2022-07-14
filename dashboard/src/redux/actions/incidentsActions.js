import { actionTypes } from "../constants/action-types";
import axios from "axios"

 

export const setIncidents = (incidents) => {
    return {
        type: actionTypes.SET_INCIDENTS,
        payload: incidents
    };
};

export const loadIncidents = (props) => {
    return function (dispatch) {
        axios.get(`${process.env.REACT_APP_END_POINT_INCIDENTS_URL}`,
            {
                headers: {
                    Authorization: `Bearer ${props}`,
                    'Cache-Control': 'no-cache',
                    'Pragma': 'no-cache',
                    'Expires': '0',
                }
            })
            .then((res) => {
                if (res.data.data !== undefined) {
                    dispatch(setIncidents(res.data.data))
                } else
                    dispatch(setIncidents({}))

            })
            .catch(err => { console.log(err); })
    }
}

export const selectedIncident = (incident) => {
    return {
        type: actionTypes.SELECTED_INCIDENT,
        payload: incident
    };
};

export const getIncident = (props, id) => {
    return function (dispatch) {
        axios.get(`${process.env.REACT_APP_END_POINT_INCIDENTS_URL}/${id}`,
            {
                headers: {
                    Authorization: `Bearer ${props}`,
                    'Cache-Control': 'no-cache',
                    'Pragma': 'no-cache',
                    'Expires': '0',
                }
            })
            .then((res) => {
                if (res.data.data !== undefined) {
                    dispatch(selectedIncident(res.data.data))
                } else
                    dispatch(selectedIncident({}))

            })
            .catch(err => { console.log(err); })
    }
}


export const removeSelectedIncident = () => {
    return {
        type: actionTypes.REMOVE_SELECTED_INCIDENT
    };
};

export const removeIncident = (incident) => {
    return {
        type: actionTypes.REMOVE_INCIDENT,
        payload: incident
    };
};

export const deleteIncident = (props, id, page) => {
    return function (dispatch) {
        axios.delete(`${process.env.REACT_APP_END_POINT_INCIDENTS_URL}/${id}`,
            {
                headers: {
                    Authorization: `Bearer ${props}`,
                    'Cache-Control': 'no-cache',
                    'Pragma': 'no-cache',
                    'Expires': '0',
                }
            })
            .then((res) => {
                console.log(res.data);
                if (res.data !== undefined) {
                    dispatch(removeIncident(res.data));
                } else {
                    dispatch(removeSelectedIncident({}));
                }

                dispatch(loadIncidents(props))
            })
            .catch(err => {
                console.log(err);
            })
    }
}
 
export const incidentAdded = (incident) => {
    return {
        type: actionTypes.ADD_INCIDENT,
        payload: incident
    };
};

export const addIncident = (access, data, image) => {
    return function (dispatch) {
       
        let formData = new FormData();
        formData.append("file", image)
        console.log(access);
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
                console.log(res);
                data.icon = res.data.url
                console.log(data);

                axios({
                    method: 'post',
                    url: `${process.env.REACT_APP_END_POINT_INCIDENTS_URL}`,
                    data: (data),
                    headers: {
                        Authorization: `Bearer ${access}`,
                        'Cache-Control': 'no-cache',
                        'Pragma': 'no-cache',
                        'Expires': '0',
                    }
                }).then((response) => {
                    console.log("3333333333333333333333");
                    console.log(response.data);
                    console.log("3333333333333333333333");
                    dispatch(incidentAdded(response.data))
                    dispatch(loadIncidents(access))
                   
                }).catch((error) => {
                    console.log(error);
                })
            }).catch(err => {
                console.log(err);
            })

    }
}

export const updatedIncident = (incident) => {
    return {
        type: actionTypes.UPDATE_INCIDENT,
        payload: incident 
    };
}; 

export const updateIncident = (access, id, data, image, imgUpdated) => {
    return function (dispatch) {
        data.incidentType_id = id
        console.log(data);
        if (imgUpdated === true) {
            //console.log(data);
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
                    data.icon = res.data.url
                    console.log(data);
                    axios({
                        method: 'put',
                        url: `${process.env.REACT_APP_END_POINT_INCIDENTS_URL}/${id}`,
                        data: (data),
                        headers: {
                            Authorization: `Bearer ${access}`,
                            'Cache-Control': 'no-cache',
                            'Pragma': 'no-cache',
                            'Expires': '0',
                        }
                    }).then((response) => {
                        console.log(response.data);
                        dispatch(updatedIncident(response.data))
                        dispatch(loadIncidents(access))
                    }).catch((error) => {
                        console.log(error);
                    })
                })
                .catch(err => {
                    console.log(err);
                })
        } else {
            console.log(data);
            axios({
                method: 'put',
                url: `${process.env.REACT_APP_END_POINT_INCIDENTS_URL}/${id}`,
                data: (data),
                headers: {
                    Authorization: `Bearer ${access}`,
                    'Cache-Control': 'no-cache',
                    'Pragma': 'no-cache',
                    'Expires': '0',
                }
            }).then((response) => {
                console.log(response.data);
                dispatch(updatedIncident(response.data))
                dispatch(loadIncidents(access))
            }).catch((error) => {
                console.log(error);
            })
        }

    }
}
