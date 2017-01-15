import React, { Component } from 'react';
import FeedSelector from '../components/FeedSelector';
import Spinner from '../components/Spinner';
import { getFeeds } from '../helpers/API';

class Feeds extends Component {

  constructor(props) {
    super(props);

    this.state = {
      feeds: [],
      isFetching: false,
    };
  }
  
  componentDidMount() {
    this.fetchFeeds();
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
    const { feeds, isFetching } = this.state;
    
    return (  
      <div> 
        { 
          isFetching     ? <Spinner /> : 
          feeds.length ? <FeedSelector feeds={ feeds } /> : 
          '' 
        }
      </div>
    );
  }
}

export default Feeds;
