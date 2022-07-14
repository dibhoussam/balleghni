import { actionTypes } from "../constants/action-types";
import axios from 'axios'
import { useHistory } from "react-router-dom";


export const setAnnounces = (announces) => {
    return {
        type: actionTypes.SET_ANNOUNCES,
        payload: announces
    };
};

export const loadAnnouncesData = (announces) => {
    return {
        type: actionTypes.LOAD_ANNOUNCE_DATA,
        payload: announces
    };
};

export const loadDataAnnounces = (announce) => {
    return function (dispatch) {
        dispatch(loadAnnouncesData(announce))
    }
}

export const loadAnnounces = (props, page) => {
    return async function (dispatch) {
        await axios.get(`${process.env.REACT_APP_END_POINT_ANNOUNCES_URL}?page=${page}`,
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
                    dispatch(setAnnounces({}))
                } else {

                    dispatch(setAnnounces(res.data.data))
                    dispatch(loadDataAnnounces(res.data.data.data))
                    //  console.log(res.data.data);
                }
            })
            .catch(err => { console.log(err); })
    }
}

export const selectedAnnounce = (announce) => {
    return {
        type: actionTypes.SELECTED_ANNOUNCE,
        payload: announce
    };
};

export const getAnnounce = (props, id) => {
    return function (dispatch) {
        axios.get(`${process.env.REACT_APP_END_POINT_ANNOUNCES_URL}/${id}`,
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
                    dispatch(selectedAnnounce({}))
                } else
                    dispatch(selectedAnnounce(res.data.data))

            })
            .catch(err => { console.log(err); })
    }
}

export const selectedAnnounceAuthoritie = (announceAthoritie) => {
    return {
        type: actionTypes.SELECTED_ANNOUNCE_AUTHORITIE,
        payload: announceAthoritie
    };
};

export const removeAnnounce = (announce) => {
    return {
        type: actionTypes.REMOVE_ANNOUNCE,
        payload: announce
    };
};

export const removeSelectedAnnounce = (announce) => {
    return {
        type: actionTypes.REMOVE_SELECTED_ANNOUNCE,
        payload: announce
    }
}

export const removeAnnounceFromStore = (announce) => {
    return function (dispatch) {

    }
}

export const deleteAnnounce = (access, id, page) => {
    return function (dispatch) {
        axios.delete(`${process.env.REACT_APP_END_POINT_ANNOUNCES_URL}/${id}`,
            {
                headers: {
                    Authorization: `Bearer ${access}`,
                    'Cache-Control': 'no-cache',
                    'Pragma': 'no-cache',
                    'Expires': '0',
                }
            })
            .then((res) => {
                console.log("--------------------------------");
                console.log(res.data);
                console.log("--------------------------------");
                if (res.data === undefined) {
                    dispatch(removeAnnounce({}))
                } else {
                    dispatch(removeAnnounce(res.data));
                    dispatch(loadAnnounces(access,page))
                }
            })
            .catch(err => {
                console.log(err);
            })
    }
}

export const announceAdded = (announce) => {
    return {
        type: actionTypes.ADD_ANNOUNCE,
        payload: announce
    };
};

export const addAnnounce = (access, data, image) => {
    return async function (dispatch) {
        
        
        let formData = new FormData();
        formData.append("file", image)
        console.log(access);
        let res = await axios.post(process.env.REACT_APP_END_POINT_IMAGES_URL, formData,
            {
                headers: {
                    "Content-Type": "multipart/form-data",
                    Authorization: `Bearer ${access}`,
                    'Cache-Control': 'no-cache',
                    'Pragma': 'no-cache',
                    'Expires': '0',
                }
            });
            console.log(res);
            data.file = res.data.url
            console.log(data);

            await axios({
                method: 'post',
                url: `${process.env.REACT_APP_END_POINT_ANNOUNCES_URL}`,
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
                if (response.data === undefined) {
                    dispatch(announceAdded({}))
                } else{
                    dispatch(announceAdded(response.data))
                }
                dispatch(loadAnnounces(access,1))
            }).catch((error) => {
                console.log(error);
            })



            
    }
}

export const updatedAnnounce = (announce) => {
    return {
        type: actionTypes.UPDATE_ANNOUNCE,
        payload: announce
    };
}; 

export const updateAnnounce = (access, id, data, image, imgUpdated) => {
    return function (dispatch) {
        let history = useHistory()
        data.announce_id = id
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
                    data.file = res.data.url
                    console.log(data);
                    axios({
                        method: 'put',
                        url: `${process.env.REACT_APP_END_POINT_ANNOUNCES_URL}/${id}`,
                        data: (data),
                        headers: {
                            Authorization: `Bearer ${access}`,
                            'Cache-Control': 'no-cache',
                            'Pragma': 'no-cache',
                            'Expires': '0',
                        }
                    }).then((response) => {
                        console.log(response.data);
                        dispatch(updatedAnnounce(response.data))
                        history.push(`/announce/${id}`)
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
                url: `${process.env.REACT_APP_END_POINT_ANNOUNCES_URL}/${id}`,
                data: (data),
                headers: {
                    Authorization: `Bearer ${access}`,
                    'Cache-Control': 'no-cache',
                    'Pragma': 'no-cache',
                    'Expires': '0',
                }
            }).then((response) => {
                console.log(response.data);
                dispatch(updatedAnnounce(response.data))
                history.push(`/announce/${id}`)
            }).catch((error) => {
                console.log(error);
            })
        }

    }
}


