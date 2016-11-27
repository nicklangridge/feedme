import React, { Component, PropTypes } from 'react';

const propTypes = {
  dispatch: PropTypes.func.isRequired,
  height: PropTypes.number,
  isMobile: PropTypes.bool,
  path: PropTypes.array.isRequired,
  width: PropTypes.number,
};

class App extends Component {
  render() {
    return (
      <div>
        hello
      </div>
    );
  }
}

App.propTypes = propTypes;

export default App;
