import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final String location;
  final double latitude;
  final double longitude;

  MapScreen({required this.location, required this.latitude, required this.longitude});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    final LatLng locationCoordinates = LatLng(widget.latitude, widget.longitude);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.location),
        backgroundColor: Colors.blue,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: locationCoordinates,
          zoom: 11.0,
        ),
        markers: _createMarkers(locationCoordinates),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Set<Marker> _createMarkers(LatLng locationCoordinates) {
    return <Marker>[
      Marker(
        markerId: MarkerId('location_marker'),
        position: locationCoordinates,
        infoWindow: InfoWindow(
          title: widget.location,
          snippet: 'Balık burada görüldü',
        ),
      ),
    ].toSet();
  }
}
