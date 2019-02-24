import React, { Component } from 'react';
import update from 'react-addons-update';
import AlbumCards from '../components/AlbumCards';
import FilterBar from '../components/FilterBar';
import Spinner from '../components/Spinner';
import Footer from '../components/Footer';
import { getClientRegion, getAlbums } from '../helpers/API';

const PAGESIZE = 30;

class Albums extends Component {

  constructor(props) {
    super(props);

    this.state = {
      albums: [],
      isFetching: false,
      offset: 0,
      atEnd: false, 
      filters: null,
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
      feeds: props.params.feed,
      genres: props.params.genre,
      category: props.params.category,
      keywords: props.params.keywords,
    };
    
    return getAlbums(args).then(data => {
      this.setState({
        isFetching: false,
        albums: update(this.state.albums, {$push: data.albums}),
        atEnd: data.albums.length < PAGESIZE,
        filters: data.filters
      });
      
    }).catch(err => { 
      throw err; 
    });
  }

  render() {
    const { albums, filters, isFetching, atEnd } = this.state;
    const { source, genre } = this.props.params;
    
    const hasAlbums = albums.length > 0;
    const hasMore = !atEnd && !isFetching;
    
    return (  
      <div> 
        { isFetching && !hasAlbums ? '' : <FilterBar filters={ filters } /> }
        { hasAlbums ? <AlbumCards albums={ albums } hasMore={ hasMore } loadMore={ this.loadMore } /> : '' }
        { isFetching ? <Spinner /> : '' }
        { atEnd ? <Footer /> : '' }
      </div>
    );
  }
}

export default Albums;
