const apiBase = 'http://feedme-nicklangridge.c9users.io:8081/api/v1';
/* global fetch */

function apiFetch(method, args = {}) {   
  const query = Object.keys(args).map(key => key + '=' + encodeURIComponent(args[key] || '')).join('&');  
  const url   = apiBase + `/${method}?${query}`;
  console.log('apiFetch', url, method, args); 
  return fetch(url).then(response => response.json());
}

function getAlbums(args) {
  return getClientRegion().then(region => {
    args.region = region;
    return apiFetch('albums', args);
  });
}

function getClientRegion() {
  let region = cacheGet('ClientRegion');
  
  if (region) {
    console.log('region (cached)', region)
    return Promise.resolve(region);
  } else { 
    return apiFetch('client_region').then(json => {
      cacheSet('ClientRegion', json.region);
      console.log('region (fetched)', json.region)
      return Promise.resolve(json.region);
    });
  }
}

function cacheSet(key, value) {
  return window.localStorage.setItem(key, value);
}

function cacheGet(key) {
  return window.localStorage.getItem(key);
}

export { getAlbums, getClientRegion };
