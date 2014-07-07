<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>Leftovers</title>
    <style>
      html, body, #map-canvas {
        height: 500px;
        width: 700px;
        margin: 0px;
        padding: 0px
      }
      .food_pic  { 
        margin: 0px;
        position: absolute; 
      }
      .food_name { 
        display: inline-block;
        margin-left: 110px;
      }
      .foodBodyContent {
        margin-top: 20px;
      }
    </style>
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>
    <script>
      function initialize() {
        var myLatLng = new google.maps.LatLng(30.274665,-97.74035);
        var mapOptions = {
          zoom: 13,
          center: myLatLng
        }
        var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

        var contentString ='<div id="content">'+
          '<img class="food_pic" src="http://placehold.it/100x70"/>'+
          '<h2 class="food_name">GoHardInThePaint Buffet</h2>'+
          '<div class="foodBodyContent">'+  
          '<p>made too much fried chicken, curry, and fried rice.<br>-Sachston</p>'+
          '</div>'+
          '</div>';
        var infowindow = new google.maps.InfoWindow({
          content: contentString
        });

        var marker_lat_long = new google.maps.LatLng(30.269329,-97.742658)
        var marker = new google.maps.Marker({
            position: marker_lat_long,
            map: map,
            title: 'Hello World!'
        });
        google.maps.event.addListener(marker, 'click', function() {
          infowindow.open(map,marker);
        });
      };

      google.maps.event.addDomListener(window, 'load', initialize);

    </script>
  </head>
  <body>
    <div id="map-canvas"></div>
  </body>
</html>