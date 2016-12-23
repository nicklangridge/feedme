import React, { Component } from 'react';
import AlbumCards from '../components/AlbumCards';

const endpoint = 'http://feedme-nicklangridge.c9users.io:8081/api/v1/latest';

class Albums extends Component {

  constructor(props) {
    super(props);

    this.state = {
      albums: [],
      isFetching: false,
    };
  }

  componentDidMount() {
    this.fetchAlbums(this.props);
  }
  
  componentWillReceiveProps(nextProps) {
    this.fetchAlbums(nextProps);
  }
  
  fetchAlbums(props) {
    /*global fetch*/
    this.setState({
      isFetching: 1,
      albums: [],
    });    
    
    let url = endpoint;
    
    if (props.params.source) {
      url += `?feed=${props.params.source}`;
    } else if (props.params.genre) {
      url += `?genre=${props.params.genre}`;
    }
    
    console.log('params', props.params);
    console.log('fetch', url);
    
    return fetch(url)
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
