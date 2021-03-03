ymaps.ready(init);
var myMap;

function init(){
  mapElement = document.getElementById('map');

  if (!mapElement) {
      return;
  }

  address = document.getElementById('map').getAttribute('data-address');

  myMap = new ymaps.Map("map", {
    center: [56.870630, 60.437392],
    zoom: 10
  });

  myGeocoder = ymaps.geocode(address);

  myGeocoder.then(
    function (res) {
      coordinates = res.geoObjects.get(0).geometry.getCoordinates();

      myMap.geoObjects.add(
        new ymaps.Placemark(
          coordinates,
          {iconContent: address},
          {preset: 'islands#blueStretchyIcon'}
        )
      );

      myMap.setCenter(coordinates);
      myMap.setZoom(15);
    }, function (err) {
      alert('Ошибка при определении местоположения');
    }
  );
}