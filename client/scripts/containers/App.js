import React, { Component } from 'react';
import history from '../utils/History';
import NavBar from '../components/NavBar';
import AlbumCards from '../components/AlbumCards';

class App extends Component {
  constructor(props) {
    super(props)

    this.state = {
      location: history.location
    }

    history.listen(this.handleNavigation.bind(this))
  }

  handleNavigation(location) {
    this.setState({
      location: location,
    })
  }
  
  render() {
    return (
      <div>
        <NavBar />
        <div style={{marginTop:'60px'}}>Path { this.state.location.pathname }{ this.state.location.search }</div>
        <AlbumCards albums={this.props.albums} />
      </div>
    );
  }
}

export default App;
