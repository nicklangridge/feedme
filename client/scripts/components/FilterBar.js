import React, { Component } from 'react';

class FilterBar extends Component {
  render() {
    const { filters } = this.props;
    
    const feeds  = filters.feeds  ? filters.feeds  : [];
    const genres = filters.genres ? filters.genres : [];
      
    return (
      <div className="filter-bar">
      XX
        { 
          feeds.map((feed, i) => { 
            return (<div key={ i }>{feed.name}</div>)
          })
        }
        { 
          genres.map((genre, i) => { 
            return (<div key={ i }>{genre.name}</div>)
          })
        }
      </div>
    );
  }
}

export default FilterBar;
