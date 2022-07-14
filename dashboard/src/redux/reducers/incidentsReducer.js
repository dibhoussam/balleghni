import { actionTypes } from "../constants/action-types";

const initialState = {
    incidents: {},
    incident: {},
    removedIncident: {},
    addedIncident: {},
    updatedIncident: {}
};

export const incidentsReducer = (state = initialState, { type, payload }) => {
    switch (type) {
        case actionTypes.SET_INCIDENTS:
            return { ...state, incidents: payload }
        case actionTypes.SELECTED_INCIDENT:
            return { ...state, incident: payload }
        case actionTypes.REMOVE_INCIDENT:
            return { ...state, removedIncident: payload }
        case actionTypes.ADD_INCIDENT:
            return { ...state, addedIncident: payload }
        case actionTypes.UPDATE_INCIDENT:
            return { ...state, updatedIncident: payload }
        case actionTypes.REMOVE_SELECTED_INCIDENT:
            return { ...state, incident: {} }

        default:
            return state;
    }
};