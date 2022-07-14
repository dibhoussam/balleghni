import { actionTypes } from "../constants/action-types";

let initialState = {
    user: null,
    userInfo: {}
}; 

export const userReducer = (state = initialState, { type, payload }) => {
    switch (type) {
        case actionTypes.USER_LOGIN:
            return { ...state, user: payload }
        case actionTypes.USER_LOGOUT:
            return { ...state, user: null, userInfo:{} }
        case actionTypes.USER_INFO:
            return { ...state, userInfo: payload }
        default:
            return state
    }
};