import React, { Component } from 'react';
import ReactDOM from 'react-dom';

class AlbumImage extends Component {
  
  constructor(props) {
    super(props);
    
    this.mouseEnter   = null;//this.mouseEnter.bind(this);
    this.mouseLeave   = null;//this.mouseLeave.bind(this);
    this.onPlayerLoad = null;//this.onPlayerLoad.bind(this);
  
    this.state = {
      isActive: false,
      isLoading: false,
    }
  }
  
  mouseEnter() {
    this.setState({
      isActive: true,
      isLoading: true,
    });
  }
  
  mouseLeave() {
    this.setState({
      isActive: false,
      isLoading: false,
    });
  }
  
  onPlayerLoad() {
    this.setState({
      isLoading: false,
    });
  }
  
  componentDidUpdate() {
    var player = ReactDOM.findDOMNode(this.refs.player);
    if (player) {
      //console.log('player', player);
      player.setAttribute('allow', 'encrypted-media');
        
    } else {
      //console.log('no player');
    }
  }
  
  render_player() {
    const {album} = this.props;

    if (!this.state.isActive) return;
    
    const playerUrl = 'https://embed.spotify.com/?uri=' + album.album_uri + '&theme=white&view=coverart';   
    
    return (
      <div className={ `player ${this.state.isLoading ? 'loading' : ''}`}>
        <iframe ref="player" src={playerUrl} onLoad={this.onPlayerLoad} width="280" height="80" frameBorder="0" allowTransparency="true"></iframe>
        <div className="loader"></div>
      </div>
    );
  }

  render() {
    const {album} = this.props;  

    const imageStyle = { backgroundImage: 'url(' + album.image + ')' };
    
    return (
      <div className="album-image" style={ imageStyle } onMouseEnter={this.mouseEnter} onMouseLeave={this.mouseLeave}>
        { this.render_player() }
      </div>
    );
  }
}

export default AlbumImage;
