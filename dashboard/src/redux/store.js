import { createStore, applyMiddleware,compose } from 'redux';
import reducers from './reducers/index';
import reduxThunk from 'redux-thunk';


const middlewares = [reduxThunk];
const composedEnhancer = compose(applyMiddleware(...middlewares))

const store = createStore(reducers,composedEnhancer);

export default store;