import React, { Component } from 'react';

class AlbumCard extends Component {
  render() {
    const {album} = this.props;  
    
    return (
      <div className="album-card" key={album.album_id}>
        <div className="image"><img src={album.image} /></div>
        <div className="header">
          <div className="artist">{album.artist_name}</div>
          <div className="album">{album.album_name}</div>
        </div>
        <div className="genres">
        </div>
        <div className="sources">
        </div>
      </div>
    );
  }
}

export default AlbumCard;
