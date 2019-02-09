import React, { Component } from 'react';
import { Link } from 'react-router';

class NotFound extends Component {
  render() {
    return (
      <div className="not-found">
        <div className="status">404</div> 
        <div className="message">Page not found</div>
        <div>Go back <Link to="/">home</Link></div>
      </div>
    );
  }
}

export default NotFound;
