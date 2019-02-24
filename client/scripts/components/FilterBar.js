import React, { Component } from 'react';
import { Link } from 'react-router';

const icons = {
  category: 'icon ion-pricetags',
  genre: 'icon ion-pricetag',
  feed: 'icon ion-social-rss',
  search: 'icon ion-search',
}

const crumb = {
  category: { name: 'category', path: null },
  genre:    { name: 'genre', path: null },
  feed:     { name: 'feed', path: '/feeds' },
  search:   { name: 'search', path: null },
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
          crumb[type] ? (<span><Link to={ crumb[type].path }>{ crumb[type].name }</Link> - </span>) : ''
        }
        <span className="name">{ name }</span>
        <Link to="/"><span className="close ion-close"></span></Link>
      </div>
    );
  }
}

export default FilterBar;
