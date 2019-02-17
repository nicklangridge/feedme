import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';
import { Router, Route, IndexRoute, browserHistory, Redirect } from 'react-router';
import '../styles/main.scss';
import App from './containers/App';
import Albums from './containers/Albums';
import Regions from './containers/Regions';
import Feeds from './containers/Feeds';
import About from './components/About';
import NotFound from './components/NotFound';

ReactDOM.render(
  <Router history={browserHistory}>
    <Route path="/" component={App}>
      <IndexRoute component={Albums} />
      <Route path="/feed/:feed"         component={Albums} />
      <Route path="/genre/:genre"       component={Albums} />
      <Route path="/category/:category" component={Albums} />
      <Route path="/regions"            component={Regions} />
      <Route path="/feeds"              component={Feeds} />
      <Route path="/about"              component={About} />
      <Route path="*"                   component={NotFound} />
    </Route>
  </Router>,
  document.getElementById('main')
);
