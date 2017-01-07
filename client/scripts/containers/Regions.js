import React, { Component } from 'react';
import RegionSelector from '../components/RegionSelector';
import Spinner from '../components/Spinner';
import { getClientRegion, getRegions } from '../helpers/API';

class Regions extends Component {

  constructor(props) {
    super(props);

    this.state = {
      regions: [],
      clientRegion: getClientRegion(),
      isFetching: false,
    };
  }
  
  componentDidMount() {
    this.fetchRegions();
  }

  fetchRegions() {
    
    this.setState({ isFetching: true });  
    
    return getRegions().then(regions => {
      this.setState({
        isFetching: false,
        regions: regions,
      });
    }).catch(err => { 
      throw err; 
    });
  }


  render() {
    const { regions, clientRegion, isFetching } = this.state;
    
    return (  
      <div> 
        { 
          isFetching     ? <Spinner /> : 
          regions.length ? <RegionSelector regions={ regions } selected={ clientRegion } /> : 
          '' 
        }
      </div>
    );
  }
}

export default Regions;
