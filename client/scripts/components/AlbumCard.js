import React, { Component } from 'react';
import { Link } from 'react-router';
import TimeAgo from 'react-timeago';
import AlbumImage from '../components/AlbumImage';


class AlbumCard extends Component {
  
  render() {
    const {album} = this.props;  
        
    return (
      <div className="album-card" key={ album.album_id }>
        <AlbumImage album={album} />
        <div className="header">
          <div className="artist">
            <a href={ album.artist_uri }>{ album.artist_name }</a>
          </div>
          <div className="album">
            <a href={ album.album_uri }>{ album.album_name }</a>
          </div>
        </div>
        <div className="reviews clearfix">
          <ul>
            { 
              album.reviews.map((review, i) => { 
                return (<li key={ i }><a href={ review.url } target="_blank">{ review.name }</a> &ldquo;{ review.snippet }&rdquo; <a href={ review.url } target="_blank">more</a></li>) 
              }) 
            }
          </ul>
        </div>
        <div className="time-ago clearfix">Found <TimeAgo date={ album.created } /></div>
        <div className="tags clearfix">
          <ul>
            { 
              album.reviews.map((tag, i) => { 
                return (<li key={ i } className="feed"><Link to={ '/feed/' + tag.slug }>{ tag.name }</Link></li>)
              })
            }
            { 
              album.genres.filter(short).map((tag, i) => { 
                return (<li key={ i } className="genre"><Link to={ '/genre/' + tag.slug }>{ tag.name }</Link></li>)
              })
            }
          </ul>
        </div>
      </div>
    );
  }
}

function short(tag) {
  return tag.name.split(" ").length < 3;
}

export default AlbumCard;
