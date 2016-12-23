import React, { Component } from 'react';
import { Link } from 'react-router';

class NavBar extends Component {
  render() {
    return (
      <div className="nav-bar">
        <div className="content">
          <div className="title">
            <Link to={'/'}>feed<span className="me">me</span></Link>
          </div>
        </div>
      </div>
    );
  }
}

export default NavBar;
