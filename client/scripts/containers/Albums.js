import React, { Component } from 'react';
import AlbumCards from '../components/AlbumCards';

const endpoint = 'http://feedme-nicklangridge.c9users.io:8081/api/v1/latest';

class Albums extends Component {

  constructor(props) {
    super(props);

    this.state = {
      albums: [],
      isFetching: false,
      ignoreLastFetch: false,
    };
  }

  componentDidMount() {
    this.fetchAlbums();
  }
  
  componentWillReceiveProps() {
    this.fetchAlbums();
  }
  
  fetchAlbums() {
    /*global fetch*/
    this.setState({
      isFetching: 1,
      albums: [],
    });    
    
    return fetch(endpoint)
      .then(response => response.json())
      .then(json => {
        this.setState({
          isFetching: 0,
          albums: json,
        });
      })
      .catch(err => { throw err; });
  }

  render() {
    const {albums, isFetching} = this.state;

    return (  
      <div>
        { albums.length > 0 ? <AlbumCards albums={ albums } /> : '' }
        { isFetching ? <div>loading...</div> : '' }
      </div>
    );
  }
}

export default Albums;
