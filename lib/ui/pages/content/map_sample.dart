import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  final double lat;
  final double lon;

  const MapSample({
    super.key,
    required this.lat,
    required this.lon,
  });

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();

  late final CameraPosition initialLocation = CameraPosition(
    // Coordenadas iniciales
    target: LatLng(widget.lat, widget.lon),
    zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    print('Lat: ${widget.lat} - Lon: ${widget.lon}');
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: initialLocation,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
