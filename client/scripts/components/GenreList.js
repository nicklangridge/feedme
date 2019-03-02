import React, { Component } from 'react';
import { Link } from 'react-router';

class GenreList extends Component {
  render() {
    const {genres} = this.props;
    
    return (
      <div className="genre-list">
        <div className="content">
          <div className="genres clearfix">
            <ul>
              { 
                genres.map((genre, i) => { 
                  return (<li key={ i } className="genre"><Link to={ '/genre/' + genre.slug }>{ genre.name }</Link></li>)
                })
              }
            </ul>
          </div>
        </div>
      </div>
    );
  }
}

export default GenreList;
