import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';
import { Router, Route, IndexRoute, browserHistory, Redirect } from 'react-router';
import '../styles/main.scss';
import App from './containers/App';
import Albums from './containers/Albums';
import NotFound from './components/NotFound';

ReactDOM.render(
  <Router history={browserHistory}>
    <Route path="/" component={App}>
      <IndexRoute component={Albums} />
      <Route path="/feed/:feed"   component={Albums} />
      <Route path="/genre/:genre" component={Albums} />
      <Route path="*"             component={NotFound} />
    </Route>
  </Router>,
  document.getElementById('main')
);
