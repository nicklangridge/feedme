import React, { Component } from 'react';
import update from 'react-addons-update';
//import RegionList from '../components/RegionList';
import Spinner from '../components/Spinner';
import Footer from '../components/Footer';
//import { getClientRegion, getAlbums } from '../helpers/API';

class Regions extends Component {

  constructor(props) {
    super(props);

    this.state = {
      regions: [],
      isFetching: false,
    };
  }

  render() {
    const { regions, isFetching } = this.state;
    
    return (  
      <div> 
        Regions here
      </div>
    );
  }
}

export default Regions;
