import React, { Component } from 'react';
import AlbumCards from '../components/AlbumCards';

class App extends Component {
  render() {
    return (
      <div>
        <AlbumCards albums={this.props.albums} />
      </div>
    );
  }
}

export default App;
