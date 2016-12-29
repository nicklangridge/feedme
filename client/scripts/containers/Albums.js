import React, { Component } from 'react';
import update from 'react-addons-update';
import AlbumCards from '../components/AlbumCards';
import Spinner from '../components/Spinner';
import Footer from '../components/Footer';
import { getClientRegion, getAlbums } from '../utils/API';

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
    
    const args = {
      offset: page * PAGESIZE,
      limit: PAGESIZE,
      feed: props.params.source,
      genre: props.params.genre,
    };
    
    return getAlbums(args).then(json => {
      this.setState({
        isFetching: false,
        albums: update(this.state.albums, {$push: json}),
        atEnd: (json.length < 1),
      });
    }).catch(err => { 
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
