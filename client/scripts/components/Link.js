import React, { Component } from 'react';
import history from '../utils/History';

class Link extends React.Component {
  constructor(props) {
    super(props);
    this.handleClick = this.handleClick.bind(this);
  }

  handleClick(event) {
    event.preventDefault();
    history.push(this.props.href);
  }

  render() {
    const { children, className, href, title } = this.props;
    return (
      <a
        className={className}
        href={href}
        onClick={this.handleClick}
        title={title ? String(title) : ''}
      >
        {children}
      </a>
    );
  }
}

export default Link;
