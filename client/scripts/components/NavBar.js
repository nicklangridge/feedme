import React, { Component } from 'react';
import { Link } from 'react-router';
import Menu from '../components/Menu';

class NavBar extends Component {
  render() {
    return (
      <div className="nav-bar">
        <div className="content">
          <div className="title">
            <Link to="/">f<span className="me">m</span></Link>        
          </div>
          <Menu />
        </div>
      </div>
    );
  }
}

export default NavBar;
