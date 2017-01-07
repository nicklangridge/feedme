import React, { Component } from 'react';
import { Link } from 'react-router';
import { setClientRegion } from '../helpers/API';

class Region extends Component {
  render() {
    const { key, region } = this.props;
    
    function setRegion() {
      setClientRegion(region.code);
    }
    
    return (
      <div className="region" key={ key }>
        <Link to={ '/' } onClick={ setRegion }>
          <img className="flag" src={ 'images/flags-iso/shiny/48/' + region.code + '.png' } />
          { region.name }
        </Link>
      </div>
    );
  }
}

export default Region;
