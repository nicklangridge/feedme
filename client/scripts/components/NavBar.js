import React, { Component } from 'react';
import { Link } from 'react-router';
//import { IconMenu, MenuItem, MenuDivider } from 'react-toolbox/lib/menu';

class NavBar extends Component {
  render() {
    return (
      <div className="nav-bar">
        <div className="content">
          <div className="title">
            <Link to={'/'}><span className="icon ion-forward"></span>feed<span className="me">me</span></Link>
          </div>
          <div className="menu">
            <span className="icon ion-navicon-round"></span>
          </div>
        </div>
      </div>
    );
  }
}

            // <IconMenu icon='more_vert' position='topLeft' menuRipple>
            //   <MenuItem value='download' icon='get_app' caption='Download' />
            //   <MenuItem value='help' icon='favorite' caption='Favorite' />
            //   <MenuItem value='settings' icon='open_in_browser' caption='Open in app' />
            //   <MenuDivider />
            //   <MenuItem value='signout' icon='delete' caption='Delete' disabled />
            // </IconMenu>

export default NavBar;
