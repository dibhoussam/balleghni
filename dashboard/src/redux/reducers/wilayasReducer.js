import { actionTypes } from "../constants/action-types";

const initialState = {
    wilayas: [],
};

export const wilayasReducer = (state = initialState, { type, payload }) => {
    switch (type) {
        case actionTypes.SET_WILAYAS:
            return { ...state, wilayas: payload }
        default:
            return state
    }
};