import React, { Component } from 'react';

class Spinner extends Component {
  constructor(props) {
    super(props);
    this.setVisible = this.setVisible.bind(this);

    this.state = {
      visible: false,
    };

    this.timer = setTimeout(this.setVisible, 250);
  }

  componentWillUnmount() {
    clearTimeout(this.timer);
  }

  setVisible() {
    this.setState({visible: true});
  }

  
  render() {
    const {visible} = this.state;
    
    if (!visible) {
      return null;
    }
    
    return (
      <div className="spinner-container">
        <div className="spinner"></div>
      </div>
    );
  }
}

export default Spinner;
