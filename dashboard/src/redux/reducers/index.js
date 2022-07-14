import {combineReducers} from 'redux';
import { announcesReducer } from './announcesReducer';
import { authoritiesReducer } from './authoritiesReducer';
import { brachsReducer } from './branchsReducer';
import { incidentsReducer } from './incidentsReducer';
import { productReducer } from './productReducer';
import { reportsReducer } from './reportsReducer';
import { userReducer } from './userReducer';
import { usersReducer } from './usersReducer';
import {wilayasReducer} from './wilayasReducer'

let reducers = combineReducers({
    allProducts : productReducer,
    allreports :reportsReducer,
    allAnnounces : announcesReducer,
    allIncidents : incidentsReducer,
    allAuthorities : authoritiesReducer,
    allBranchs : brachsReducer,
    user : userReducer,
    allWilayas : wilayasReducer,
    allUsers : usersReducer
    
});



export default reducers;
