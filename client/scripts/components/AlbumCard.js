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
        <div className="reviews clearfix">
          <ul>
            { album.reviews.map((review, i) => { return (<li>{ review.name  }</li>)} )}
          </ul>
        </div>
        <div className="genres clearfix">
          <ul>
            { album.genres.map((genre, i) => { return (<li>{ genre.name  }</li>)} )}
          </ul>
        </div>
      </div>
    );
  }
}

export default AlbumCard;
