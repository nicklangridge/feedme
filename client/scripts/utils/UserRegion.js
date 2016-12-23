function setUserRegion(regionCode) {
  return window.localStorage.setItem('UserRegion', regionCode);
}

function getUserRegion() {
  return window.localStorage.getItem('UserRegion');
}

export default getUserRegion;
export default setUserRegion;