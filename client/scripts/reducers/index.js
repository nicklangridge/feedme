import { combineReducers } from 'redux';
import environment from '../reducers/environment';
import navigator from '../reducers/navigator';

const rootReducer = combineReducers({
  environment,
  navigator,
});

export default rootReducer;
