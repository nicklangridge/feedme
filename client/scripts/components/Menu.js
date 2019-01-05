import React, { Component } from 'react';
import { Link } from 'react-router';
import Popover from '../components/Popover';
import { getClientRegion } from '../helpers/API';
import { getCountryName } from '../helpers/countries';

class Menu extends Component {
  render() {
    
    const regionCode = getClientRegion(); 
    const regionName = getCountryName(regionCode);

    return (
      <Popover className="menu-button">
        <span className="icon ion-navicon-round"></span>
        <div className="menu-content popover-content">
          <ul>
            <li>
              <Link to="/feeds">Feeds</Link>
            </li>
            <li>
              <Link to="/about">About</Link>
            </li>
            <li className="region">
              { regionName } <img src={ '/images/flags-iso/shiny/16/' + regionCode + '.png' } width="16" height="16" /> (<Link to="/regions">change</Link>)
            </li>
          </ul>
        </div>
      </Popover>
    );
  }
}

export default Menu;
