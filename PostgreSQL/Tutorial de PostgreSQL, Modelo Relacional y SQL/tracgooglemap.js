/* 
 JavaScript functions for Trac GoogleMapMacro

 Copyright (c) 2008 Martin Scharrer <martin@scharrer-online.de>
 $Id: tracgooglemap.js 4801 2008-11-14 15:36:27Z martin_s $
 $HeadURL: http://trac-hacks.org/svn/googlemapmacro/0.11/tracgooglemap/htdocs/tracgooglemap.js $

 This is Free Software under the GPL v3!
*/

function SetMarkerByCoords(map,lat,lng,letter,link,title,target) {
    if (!title) { title = link; }
    var marker = new GMarker( new GLatLng(lat,lng),
        { title: title, icon: new GIcon (G_DEFAULT_ICON,
        'http://maps.google.com/mapfiles/marker'
        + letter + '.png') }
     );
    if (link) {
        GEvent.addListener(marker, "click", function() {
            if (target) {
                window.open(link);
            } else {
                window.location = link;
            }
        });
    }
    map.addOverlay(marker);
}

function SetMarkerByAddress(map,address,letter,link,title,target,geocoder) {
    if (!geocoder) {
        geocoder = new GClientGeocoder();
    }
    geocoder.getLatLng(
      address,
      function(point) {
        if (point) {
          SetMarkerByCoords(map, point.lat(), point.lng(), letter, link, title, target);
        }
      }
    )
}

// Array to store all Map init functions
var tracgooglemapfuncs = new Array();

function TracGoogleMap( initfunc, id ) {
    // 'id' is for future features and ignored at the moment
    tracgooglemapfuncs.push(initfunc);
};

function gmapiloaded() {
    if ( GBrowserIsCompatible() ) {
        // Go through all GoogleMap divs, set id and execute the 
        // associated init function:
        $("div.tracgooglemap")
        .each( function (index) {
            var initfunc = tracgooglemapfuncs[index];
            if (initfunc) {
                initfunc(this, index);
            }
        });
    }
}

$(document).ready( function () {
    if ( $("div.tracgooglemap").length ) {
        var key = $("link.google-key").attr('title');
        jQuery.getScript("http://www.google.com/jsapi?key=" + key, function () {
            google.load("maps", "2.x", {"callback" : gmapiloaded})
        });
    }
});

$(window).unload( function () {
    if ( $("div.tracgooglemap").length ) {
        GUnload();
    }
});

