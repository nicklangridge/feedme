import React, { Component } from 'react';

class AlbumCard extends Component {
    
  render() {
    const {album} = this.props;  
    
    return (
      <div className="album-card" key={album.album_id}>
        <div className="image"><img src={album.image} /></div>
        <div className="header">
          <div className="artist">{album.artist_name}</div>
          <div className="album">{album.album_name}</div>
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
              album.reviews.map((tag, i) => { 
                return (<li className="source"><a href={ '/?source=' + tag.slug }>{ tag.name }</a></li>)
              })
            }
            { 
              album.genres.map((tag, i) => { 
                return i > 4 ? 
                  (i > 5 ? '' : (<li>...</li>)) : 
                  (<li className="genre"><a href={ '/?genre=' + tag.slug }>{ tag.name }</a></li>)
              })
            }
          </ul>
        </div>
      </div>
    );
  }
}

export default AlbumCard;
