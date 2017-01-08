import React, { Component } from 'react';
import Region from '../components/Region';

class RegionSelector extends Component {
  render() {
    const { regions, selected } = this.props;
    
    return (
      <div className="region-selector">
        <div className="section">
          Your currently selected region is
          <Region key="selected" region={ selected } />
        </div>
        <div className="section">
          Not right? Select another...
          { 
            regions.map((region, i) => { 
              if (region == selected) return '';
              return (
                <Region key={ i } region={ region } />
              );
            }) 
          }
        </div>
      </div>
    );
  }
}

export default RegionSelector;
