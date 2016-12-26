import React, { Component } from 'react';
import update from 'react-addons-update';
import AlbumCards from '../components/AlbumCards';
import Spinner from '../components/Spinner';
import Footer from '../components/Footer';

const endpoint = 'http://feedme-nicklangridge.c9users.io:8081/api/v1/latest';
const REPLACE  = 'REPLACE';
const APPEND   = 'APPEND';
const PAGESIZE = 30;

class Albums extends Component {

  constructor(props) {
    super(props);

    this.state = {
      albums: [],
      isFetching: false,
      offset: 0,
      atEnd: false, 
    };
    
    this.loadMore = this.loadMore.bind(this);
  }

  componentDidMount() {
    this.fetchAlbums(this.props);
  }
  
  componentWillReceiveProps(nextProps) {
    this.fetchAlbums(nextProps);
  }
  
  loadMore(page) {
    console.log('load more', page);
    this.fetchAlbums(this.props, page);
  }
  
  fetchAlbums(props, page = 0) {
    
    this.setState({
      isFetching: true,
      albums: page > 0 ? this.state.albums : [],
      atEnd: false,
    });  
      
    let url = endpoint + `?offset=${page * PAGESIZE}`;
        
    if (props.params.source) {
      url += `&feed=${props.params.source}`;
    } else if (props.params.genre) {
      url += `&genre=${props.params.genre}`;
    }
    
    console.log('params', props.params);
    console.log('fetch', url);
    
    /*global fetch*/
    return fetch(url)
      .then(response => response.json())
      .then(json => {
        this.setState({
          isFetching: false,
          albums: update(this.state.albums, {$push: json}),
          atEnd: (json.length < 1),
        });
      })
      .catch(err => { 
        throw err; 
      });
  }

  render() {
    const {albums, isFetching, atEnd} = this.state;
    
    const hasMore = !atEnd && !isFetching;
    
    return (  
      <div> 
        { albums.length > 0 ? <AlbumCards albums={ albums } hasMore={ hasMore } loadMore={ this.loadMore } /> : '' }
        { isFetching ? <Spinner /> : '' }
        { atEnd ? <Footer /> : '' }
      </div>
    );
  }
}

export default Albums;
