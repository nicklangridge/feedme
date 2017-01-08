import React, { Component } from 'react';
import { Link } from 'react-router';
import Popover from '../components/Popover';

class NavBar extends Component {
  render() {
    return (
      <div className="nav-bar">
        <div className="content">
          <div className="title">
            <Link to="/"><span className="icon ion-forward"></span>feed<span className="me">me</span></Link>
          </div>
          
          <Popover className="menu-button">
            <span className="icon ion-navicon-round"></span>
            <div className="menu-content popover-content">
              <Link to="/regions">Regions</Link>
            </div>
          </Popover>
          
        </div>
      </div>
    );
  }
}

export default NavBar;
