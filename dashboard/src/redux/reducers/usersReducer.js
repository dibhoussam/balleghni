import { actionTypes } from "../constants/action-types";

const initialState = {
    users: [],
    userAdded: {}
};

export const usersReducer = (state = initialState, { type, payload }) => {
    switch (type) {
        case actionTypes.AUTHORITIE_USERS_LOADED:
            return { ...state, users: payload }
        case actionTypes.WILAYA_USERS_LOADED:
            return { ...state, users: payload }
        case actionTypes.ADD_USER:
            return { ...state, userAdded: payload }
        default:
            return state
    }
};