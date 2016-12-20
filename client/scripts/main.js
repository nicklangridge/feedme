import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';
import { Router, Route, IndexRoute, browserHistory } from 'react-router';
import '../styles/main.scss';
import App from './containers/App';
import Albums from './containers/Albums';

ReactDOM.render(
  <Router history={browserHistory}>
    <Route path="/" component={App}>
      <IndexRoute component={Albums} />
      <Route path="/source/:source" component={Albums} />
      <Route path="/genre/:genre"   component={Albums} />
    </Route>
  </Router>,
  document.getElementById('main')
);
