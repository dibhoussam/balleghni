import { actionTypes } from "../constants/action-types";
import axios from "axios";



export const setBranchs = (branchs) => {
    return {
        type: actionTypes.SET_BRANCHS,
        payload: branchs
    };
};

export const loadBranchs = (props, page) => {
    return function (dispatch) {
        axios.get(`${process.env.REACT_APP_END_POINT_BRANCHS_URL}?page=${page}`,
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
                if (res.data.data === undefined)
                    dispatch(setBranchs({}))
                else
                    dispatch(setBranchs(res.data.data))

            })
            .catch(err => { console.log(err); })
    }
}

export const selectedBranch = (branch) => {
    return {
        type: actionTypes.SELECTED_BRANCH,
        payload: branch
    };
};

export const getBranch = (props, id) => {
    return function (dispatch) {
        axios.get(`${process.env.REACT_APP_END_POINT_BRANCHS_URL}/${id}`,
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
                if (res.data.data === undefined)
                    dispatch(selectedBranch({}))
                else
                    dispatch(selectedBranch(res.data.data))

            })
            .catch(err => { console.log(err); })
    }
}

export const resetBranch = () => {
    return {
        type: actionTypes.RESET_BRANCH
    }
}


export const removeSelectedBranch = (branch) => {
    return {
        type: actionTypes.REMOVE_BRANCH,
        payload: branch
    };
};

export const deleteBranch = (access, id, page) => {
    return function (dispatch) {
        axios.delete(`${process.env.REACT_APP_END_POINT_BRANCHS_URL}/${id}`,
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
                dispatch(removeSelectedBranch(res.data));
                dispatch(resetBranch());
                dispatch(loadBranchs(access, page))
            })
            .catch(err => {
                console.log(err);
            })
    }
}

export const branchAdded = (branch) => {
    return {
        type: actionTypes.ADD_BRANCH,
        payload: branch
    };
};

export const addBranch = (access, data) => {
    return function (dispatch) {
        
        console.log(data);
        axios({
            method: 'post',
            url: process.env.REACT_APP_END_POINT_BRANCHS_URL,
            data: (data),
            headers: {
                Authorization: `Bearer ${access}`,
                'Cache-Control': 'no-cache',
                'Pragma': 'no-cache',
                'Expires': '0',
            }
        }).then((response) => {
            console.log(response.data);
            dispatch(branchAdded(response.data))
           
        }).catch((error) => {
            console.log(error);
        })
    }
}

export const updatedBranch = (branch) => {
    return {
        type: actionTypes.BRANCH_UPDATED,
        payload: branch
    };
};

export const updateBranch = (access, id, data) => {
    return function (dispatch) {
        
        console.log(data);
        axios({
            method: 'put',
            url: `${process.env.REACT_APP_END_POINT_BRANCHS_URL}/${id}`,
            data: (data),
            headers: {
                Authorization: `Bearer ${access}`,
                'Cache-Control': 'no-cache',
                'Pragma': 'no-cache',
                'Expires': '0',
            }
        }).then((response) => {
            console.log(response.data);
            dispatch(updatedBranch(response.data))
            
        }).catch((error) => {
            console.log(error);
        })
    }
}

