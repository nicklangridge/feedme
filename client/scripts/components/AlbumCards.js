import React, { Component } from 'react';
import MasonryInfiniteScroller from 'react-masonry-infinite';
import AlbumCard from '../components/AlbumCard';

const sizes = [
  { columns: 1, gutter: 20 },
  { mq: '660px',  columns: 2, gutter: 20 },
  { mq: '980px',  columns: 3, gutter: 20 },
  { mq: '1300px', columns: 4, gutter: 20 },
];

const endpoint = 'http://feedme-nicklangridge.c9users.io:8081/api/v1/latest';

class AlbumCards extends Component {

  constructor(props) {
    super(props)

    this.state = {
      albums: [],
      isFetching: false,
    }
  }

  componentDidMount() {
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
    const {albums} = this.props;
    
    const cards = albums.map((album, i) => { return (
      <AlbumCard album={album} key={i} />
    )});

    return (
      <div className="album-cards">
        <MasonryInfiniteScroller className="masonry" sizes={sizes}>
          { cards }
        </MasonryInfiniteScroller>
      </div>
    );
  }
}

export default AlbumCards;
