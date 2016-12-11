import React, { Component } from 'react';
import Link from '../components/Link';

class NavBar extends Component {
  render() {
    return (
      <div className="nav-bar">
        <div className="content">
          <div className="title">
            <Link href={'/'}>feed<span className="me">me</span></Link>
          </div>
        </div>
      </div>
    );
  }
}

export default NavBar;
