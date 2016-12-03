import React, { Component } from 'react';

class AlbumCard extends Component {
    
  render() {
    const {album} = this.props;  
    
    return (
      <div className="album-card" key={ album.album_id }>
        <div className="image">
          <a href={ album.album_uri }><img src={ album.image } /></a>
        </div>
        <div className="header">
          <div className="artist">
            <a href={ album.artist_uri }>{ album.artist_name }</a>
          </div>
          <div className="album">
            <a href={ album.album_uri }>{ album.album_name }</a>
          </div>
        </div>
        <div className="reviews clearfix">
          <div className="label">Reviews</div> 
          <ul>
            { 
              album.reviews.map((review, i) => { 
                return (<li><a href={ review.url } target="_blank">{ review.name }</a></li>) 
              }) 
            }
          </ul>
        </div>
        <div className="tags clearfix">
          <ul>
            { 
              album.reviews.filter(short).map((tag, i) => { 
                return (<li className="source"><a href={ '/?source=' + tag.slug }>{ tag.name }</a></li>)
              })
            }
            { 
              album.genres.filter(short).map((tag, i) => { 
                return (<li className="genre"><a href={ '/?genre=' + tag.slug }>{ tag.name }</a></li>)
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
