import React, { Component } from 'react';
import { Link } from 'react-router';
import { getClientRegion } from '../helpers/API';
import { getCountryName } from '../helpers/countries';
import { getFeeds } from '../helpers/API';

class MenuRegion extends Component {
  
  constructor(props) {
    super(props);

    this.state = {
      region: null,
      isFetching: false,
    };
  }
  
  componentDidMount() {
    this.fetchRegion();
  }

  fetchFeeds() {
    this.setState({ isFetching: true });  
    
    return getFeeds().then(feeds => {
      this.setState({
        isFetching: false,
        feeds: feeds,
      });
    }).catch(err => { 
      throw err; 
    });
  }


  render() {
    
    const regionCode = getClientRegion(); 
    const regionName = getCountryName(regionCode);
    
    return (
      <div className="region clearfix">
        <ul>
          <li>
            { regionName } <img src={ '/images/flags-iso/shiny/16/' + regionCode + '.png' } width="16" height="16" /> (<Link to="/regions">change</Link>)
          </li>
        </ul>
      </div>
    );
  }
}

export default MenuRegion;
