import { actionTypes } from "../constants/action-types";


const initialState = {
    products : [],
    product : {}
};

export const productReducer = (state = initialState, { type, payload }) => {
    switch (type) {
        case actionTypes.SET_PRODUCTS:
            return { ...state, products: payload }
        case actionTypes.SELECTED_PRODUCT:
            return { ...state, product :payload }
        case actionTypes.DELETE_PRODUCT:
            return {...state}
        default:
            return state
    }
};
