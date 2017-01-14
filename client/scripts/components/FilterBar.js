import React, { Component } from 'react';
import { Link } from 'react-router';

const icons = {
  genre: 'icon ion-pricetag',
  feed: 'icon ion-social-rss',
}

class FilterBar extends Component {
  render() {
    const filters = this.props.filters;
    
    if (!filters) return null;
       
    return (
      <div className="filter-bar">
       <span className={ icons[filters[0].type] }></span>
       <span className="name">{ filters[0].name }</span>
       <Link to="/"><span className="close ion-close"></span></Link>
      </div>
    );
  }
}

export default FilterBar;
