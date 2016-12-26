import React, { Component } from 'react';
import MasonryInfiniteScroller from 'react-masonry-infinite';
import AlbumCard from '../components/AlbumCard';

const sizes = [
  { columns: 1, gutter: 20 },
  { mq: '660px',  columns: 2, gutter: 20 },
  { mq: '980px',  columns: 3, gutter: 20 },
  { mq: '1300px', columns: 4, gutter: 20 },
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
