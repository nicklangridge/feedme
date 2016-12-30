import React, { Component } from 'react';

class FilterBar extends Component {
  render() {
    const filters = this.props.filters;
    
    if (!filters) return null;
       
    return (
      <div className="filter-bar">
        { filters[0].type }: { filters[0].name }
      </div>
    );
  }
}

export default FilterBar;
