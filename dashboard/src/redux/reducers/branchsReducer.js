import { actionTypes } from "../constants/action-types";

const initialState = {
    branchs: {},
    branch: {},
    removedBranch: {},
    addedBranch: {},
    updatedBranch: {}
};

export const brachsReducer = (state = initialState, { type, payload }) => {
    switch (type) {
        case actionTypes.SET_BRANCHS:
            return { ...state, branchs: payload }
        case actionTypes.SELECTED_BRANCH:
            return { ...state, branch: payload }
        case actionTypes.REMOVE_BRANCH:
            return { ...state, removedBranch: payload }
        case actionTypes.ADD_BRANCH:
            return { ...state, addedBranch: payload }
        case actionTypes.BRANCH_UPDATED:
            return { ...state, updatedBranch: payload }
        case actionTypes.RESET_BRANCH:
            return { ...state, branchs : {}}
        default:
            return state;
    }
};