import React, { Component } from 'react';
import AlbumCard from '../components/AlbumCard';

class AlbumCards extends Component {
  render() {
    const {albums} = this.props;
    
    const cards = albums.map((album, i) => { return (
      <AlbumCard album={album} key={i} />
    )});

    return (
      <div className="album-cards">
        {cards}
      </div>
    );
  }
}

export default AlbumCards;
