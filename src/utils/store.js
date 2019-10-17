import {createStore, applyMiddleware} from 'redux';

import thunk from 'redux-thunk';

import mainReducer from './../reducers';
  
const createStoreWithMiddleware = applyMiddleware(thunk)(createStore);
const store = createStoreWithMiddleware(mainReducer);

export default store;
