import React, { Component } from 'react';
import { Link } from 'react-router';
import Popover from '../components/Popover';
import { getClientRegion } from '../helpers/API';
import { getCountryName } from '../helpers/countries';

class Menu extends Component {
  render() {
    
    const regionCode = getClientRegion(); 
    const regionName = getCountryName(regionCode);
    const categories = [
      ['rock-indie', 'Rock / indie'],
      ['pop', 'Pop'],
      ['electronic', 'Electronic'],
      ['hip-hop-rap', 'Hip-hop / rap'],
      ['folk', 'Folk'],
      ['avant-garde', 'Avant garde'],
      ['randb', 'R & B'],
      ['country', 'Country'],
      ['ambient', 'Ambient'],
      ['soul-funk-jazz', 'Soul / funk / jazz'],
      ['reggae-dub', 'Reggae / dub']
    ];
    
    return (
      <Popover className="menu-button">
        <span className="icon ion-navicon-round"></span>
        <div className="menu-content popover-content">
          <div className="links clearfix">
            <ul>
              <li>
                <Link to="/">Home</Link>
              </li>
              <li>
                <Link to="/feeds">Feeds</Link>
              </li>
              <li>
                <Link to="/about">About</Link>
              </li>
            </ul>
          </div>
          <div className="categories clearfix">
            <h2>Categories</h2>
            <ul>
              { 
                categories.map((cat, i) => { 
                  return (<li key={ i } className="feed"><Link to={ '/category/' + cat[0] }>{ cat[1] }</Link></li>)
                })
              }
            </ul>
          </div>
          <div className="region clearfix">
            <ul>
              <li>
                { regionName } <img src={ '/images/flags-iso/shiny/16/' + regionCode + '.png' } width="16" height="16" /> (<Link to="/regions">change</Link>)
              </li>
            </ul>
          </div>
        </div>
      </Popover>
    );
  }
}

export default Menu;
