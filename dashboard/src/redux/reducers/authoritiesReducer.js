import { actionTypes } from "../constants/action-types";

const initialState = {
    authorities: {},
    authoritie: {},
    removedAuthoritie: {},
    addedAuthoritie: {},
    updatedAuthoritie: {},
};

export const authoritiesReducer = (state = initialState, { type, payload }) => {
    switch (type) {
        case actionTypes.SET_AUTHORITIES:
            return { ...state, authorities: payload }
        case actionTypes.SELECTED_AUTHORITIE:
            return { ...state, authoritie: payload }
        case actionTypes.REMOVE_AUTHORITIE:
            return { ...state, removedAuthoritie: payload }
            case actionTypes.REMOVE_SELECTED_AUTHORITIE:
            return { ...state, authoritie: {} }
        case actionTypes.ADD_AUTHORITIE:
            return { ...state, addedAuthoritie: payload }
        case actionTypes.UPDATE_AUTHORITIE:
            return { ...state, updatedAuthoritie: payload }
            case actionTypes.RESET_AUTHORITIES:
                return { ...state, authorities : {} }
        default:
            return state;
    }
};