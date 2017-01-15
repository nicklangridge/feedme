import React, { Component } from 'react';
import { Link } from 'react-router';

const icons = {
  genre: 'icon ion-pricetag',
  feed: 'icon ion-social-rss',
}

const crumb = {
  genre: null,
  feed: { name: 'feeds', path: '/feeds' },
}

class FilterBar extends Component {
  render() {
    const filters = this.props.filters;
    
    if (!filters) return null;
       
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
