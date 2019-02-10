import React, { Component } from 'react';
import { Link } from 'react-router';

class FeedSelector extends Component {
  render() {
    const { feeds } = this.props;
    
    return (
      <div className="feed-selector">
        <div className="caption">Select a feed...</div>
        { 
          feeds.map((feed, i) => { return (
            <div className="feed" key={ i }>
              <Link to={ '/feed/' + feed.slug } className="name">
                <span className="icon ion-social-rss"></span>{ feed.name }
              </Link>
              <a href={ feed.homepage_url } className="link" target="_blank">
              { 
                feed.homepage_url
                  .replace('http://', '')
                  .replace('https://', '')
                  .replace('www.', '')
                  .split('/')[0]
              }
              </a>  
            </div>
          )}) 
        }
      </div>
    );
  }
}

export default FeedSelector;
