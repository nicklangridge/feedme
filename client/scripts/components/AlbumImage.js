import React, { Component } from 'react';
import ReactDOM from 'react-dom';

class AlbumImage extends Component {
  
  constructor(props) {
    super(props); 
    this.onClick = this.onClick.bind(this);
  }
  
  onClick(e) {
    const {album} = this.props;
    window.location.href = album.album_uri;
    e.preventDefault();
  }
  
  render() {
    const {album} = this.props;  
    const imageStyle = { backgroundImage: 'url(' + album.image + ')' };
    
    return (
      <div className="album-image" style={ imageStyle } onClick={this.onClick}></div>
    );
  }
}

export default AlbumImage;
