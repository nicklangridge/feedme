import { getCountryName } from './countries';
var config = require('config');

const apiBase = config.api_base_uri;
/* global fetch */

function apiFetch(method, args = {}) {   
  const query = Object.keys(args).map(key => key + '=' + encodeURIComponent(args[key] || '')).join('&');  
  const url   = apiBase + `/${method}?${query}`;
  console.log('apiFetch', url, method, args); 
  return fetch(url).then(response => response.json());
}

function getAlbums(args) {
  if (!args.region) args.region = getClientRegion();
  
  return apiFetch('albums', args).then(json => {
    //console.log('got json', json);
    if (!args.region) setClientRegion(json.region); // save region if not set already 
    return Promise.resolve(json);
  });
}

function getRegions() {
  return apiFetch('regions').then(regions => {
    return Promise.resolve(
      regions.sort( (a, b) => getCountryName(a).localeCompare(getCountryName(b)) )
    );
  });
}

function getFeeds() {
  return apiFetch('feeds');
}

function getClientRegion() {
  return _cacheGet('ClientRegion');
}

function setClientRegion(region) {
  return _cacheSet('ClientRegion', region);
}

function _cacheSet(key, value) {
  return window.localStorage.setItem(key, value);
}

function _cacheGet(key) {
  return window.localStorage.getItem(key);
}

export { 
  getAlbums, 
  getRegions, 
  getFeeds, 
  getClientRegion, 
  setClientRegion, 
};
