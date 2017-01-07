import React, { Component } from 'react';
import MasonryInfiniteScroller from 'react-masonry-infinite';
import AlbumCard from '../components/AlbumCard';

// 40 + cols x 320 
const sizes = [
  { columns: 1, gutter: 20 },
  { mq: '680px',  columns: 2, gutter: 20 },
  { mq: '1000px', columns: 3, gutter: 20 },
  { mq: '1320px', columns: 4, gutter: 20 },
  { mq: '1640px', columns: 5, gutter: 20 },
  { mq: '1960px', columns: 6, gutter: 20 },
];

class AlbumCards extends Component {
  render() {
    const {albums, hasMore, loadMore} = this.props;
    
    const cards = albums.map((album, i) => { return (
      <AlbumCard album={album} key={i} />
    )});

    return (
      <div className="album-cards">
        <MasonryInfiniteScroller className="masonry" sizes={ sizes } hasMore={ hasMore } loadMore={ loadMore }>
          { cards }
        </MasonryInfiniteScroller>
      </div>
    );
  }
}

export default AlbumCards;
