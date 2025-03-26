import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EvStationsScreen extends StatefulWidget {
  const EvStationsScreen({super.key});

  @override
  State<EvStationsScreen> createState() => _EvStationsScreenState();
}

class _EvStationsScreenState extends State<EvStationsScreen> {
  static const initialLocation = LatLng(37.7749, -122.4194);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: initialLocation,
          zoom: 13.0,
        ),
      ),
    );
  }
}
