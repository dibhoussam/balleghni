import { actionTypes } from "../constants/action-types";

const initialState = {
    announces: {},
    data: [],
    announce: {},
    removedAnnounce: {},
    addedAnnounce: {},
    updatedAnnounce: {}
};

export const announcesReducer = (state = initialState, action) => {
    switch (action.type) {
        case actionTypes.SET_ANNOUNCES:
            return { ...state, announces: action.payload }
        case actionTypes.LOAD_ANNOUNCE_DATA:
            return { ...state, data: action.payload }
        case actionTypes.SELECTED_ANNOUNCE:
            return { ...state, announce: action.payload }
        case actionTypes.REMOVE_ANNOUNCE:
            return { ...state, removedAnnounce: action.payload }
        case actionTypes.ADD_ANNOUNCE:
            return { ...state, addedAnnounce: action.payload }
        case actionTypes.UPDATE_ANNOUNCE:
            return { ...state, updatedAnnounce: action.payload }
        case actionTypes.REMOVE_SELECTED_ANNOUNCE:
            return { ...state, announces: action.payload }
        default:
            return state;
    }
};