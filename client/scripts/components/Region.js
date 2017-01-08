import React, { Component } from 'react';
import { Link } from 'react-router';
import { setClientRegion } from '../helpers/API';
import { getCountryName } from '../helpers/countries';

class Region extends Component {
  render() {
    const { key, region } = this.props;
    
    function setRegion() {
      setClientRegion(region);
    }
    
    return (
      <div className="region" key={ key }>
        <Link to={ '/' } onClick={ setRegion }>
          <img className="flag" src={ 'images/flags-iso/shiny/48/' + region + '.png' } />
          { getCountryName(region) }
        </Link>
      </div>
    );
  }
}

export default Region;
