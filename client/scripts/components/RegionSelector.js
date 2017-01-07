import React, { Component } from 'react';
import Region from '../components/Region';

class RegionSelector extends Component {
  render() {
    const { regions, selected } = this.props;
    
    const selectedRegion = regions.filter(r => r.code == selected)[0] || {};
  
    return (
      <div className="region-selector">
        <div className="section">
          Your currently selected region is
          <Region key="selected" region={ selectedRegion } />
        </div>
        <div className="section">
          Not right? Select another...
          { 
            regions.map((region, i) => { 
              if (region.code == selected) return '';
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
