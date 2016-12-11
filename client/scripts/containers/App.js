import React, { Component } from 'react';
import history from '../utils/History';
import NavBar from '../components/NavBar';
import AlbumCards from '../components/AlbumCards';

const endpoint = 'http://feedme-nicklangridge.c9users.io:8081/api/v1/latest';

class App extends Component {
  constructor(props) {
    super(props)

    this.state = {
      location: history.location,
      albums: [],
    }

    history.listen(this.handleNavigation.bind(this))
  }

  componentDidMount() {
    this.fetchAlbums();
  }

  handleNavigation(location) {
    this.setState({
      location: location,
    });
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
    const {albums, isFetching} = this.state;
    
    return (
      <div>
        <NavBar />
        <div style={{marginTop:'60px'}}>Path { this.state.location.pathname }{ this.state.location.search }</div>
        { albums.length > 0 ? <AlbumCards albums={this.state.albums} /> : '' }
        { isFetching ? <div>loading...</div> : '' }
      </div>
    );
  }
}

export default App;