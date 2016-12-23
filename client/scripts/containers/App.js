import React, { Component } from 'react';
import history from '../utils/History';
import NavBar from '../components/NavBar';
import AlbumCards from '../components/AlbumCards';

class App extends Component {  
  render() {
    return (
      <div>
        <NavBar />
        { this.props.children }
      </div>
    );
  }
}

export default App;