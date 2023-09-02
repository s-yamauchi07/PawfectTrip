const initMap = () => {
  const tokyoStation = { lat:35.6814104752183, lng:139.76721062882686};

  let map = new google.maps.Map(document.getElementById('map'), {
  center: tokyoStation,
  zoom: 8
  });
}

window.addEventListener('turbo:load', initMap);