

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class Map extends StatefulWidget {
 
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  Set<Marker> _markers = {};
  BitmapDescriptor mapMarker;
  void MapCreated (GoogleMapController controller) {
    setState(() {
      _markers.add(
          Marker(markerId: MarkerId('id-1'),position: LatLng(41.5838623,60.5723919),icon: mapMarker)
      );
    });
  }
  void initState () {
    super.initState();
    setCustomMarker();
  }
  void setCustomMarker () async {
    mapMarker = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'icons/location.png');
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10)
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 8),
      width: 340,
      height: 240,
      child: GoogleMap(
        onMapCreated: MapCreated,
        markers: _markers,
        initialCameraPosition: CameraPosition(
          target: LatLng(41.5838623,60.5723919),
          zoom: 15,


        ),
      ),);

  }
}
