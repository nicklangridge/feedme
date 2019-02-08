import React, { Component } from 'react';
import { Link } from 'react-router';

const icons = {
  genre: 'icon ion-pricetag',
  feed: 'icon ion-social-rss',
}

const crumb = {
  genre: { name: 'genre', path: null },
  feed:  { name: 'feed', path: '/feeds' },
}

class FilterBar extends Component {
  render() {
    const filters = this.props.filters;
    
    if (!filters) return (
      <div className="filter-bar">
        <span className="icon"></span><span className="name">Recent Spotify albums and reviews</span>
      </div>
    );
       
    const type = filters[0].type;
    const name = filters[0].name;
    
    return (
      <div className="filter-bar">
        <span className={ icons[type] }></span>
        {
          crumb[type] ? (<span><Link to={ crumb[type].path }>{ crumb[type].name }</Link> / </span>) : ''
        }
        <span className="name">{ name }</span>
        <Link to="/"><span className="close ion-close"></span></Link>
      </div>
    );
  }
}

export default FilterBar;
