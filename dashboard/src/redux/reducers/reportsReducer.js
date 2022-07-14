import { actionTypes } from "../constants/action-types";

const initialState = {
    reports: {},
    report: {},
    removedReport: {},
    addedReport: {},
    updatedReport: {}
};

export const reportsReducer = (state = initialState, { type, payload }) => {
    switch (type) {
        case actionTypes.SET_REPORTS:
            return { ...state, reports: payload }
        case actionTypes.SELECTED_REPORT:
            return { ...state, report: payload }
        case actionTypes.REMOVE_REPORT:
            return { ...state, removedReport: payload }
        case actionTypes.ADD_REPORT:
            return { ...state, addedReport: payload }
        case actionTypes.UPDATE_REPORT:
            return { ...state, updatedReport: payload }
        default:
            return state
    }
};