import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:nikn_fuel/constants.dart';

class EvStationsScreen extends StatefulWidget {
  const EvStationsScreen({super.key});

  @override
  State<EvStationsScreen> createState() => _EvStationsScreenState();
}

class _EvStationsScreenState extends State<EvStationsScreen> {
  GoogleMapController? mapController;
  Set<Marker> _markers = {};
  LatLng? _initialPosition;

  // static const initialLocation = LatLng(37.7749, -122.4194);

  @override
  void initState() {
    super.initState();
    _loadLocationAndFuelStations();
  }

  Future<void> _loadLocationAndFuelStations() async {
    try {
      Position position = await _getCurrentLocation();
      setState(() {
        _initialPosition = LatLng(position.latitude, position.longitude);
      });
      // print(_initialPosition);

      // Fetch nearby EV stations
      List<dynamic> evStations = await getNearbyEvStations(position.latitude, position.longitude);
      setState(() {
        _markers = evStations.map((station) {
          final lat = station['geometry']['location']['lat'];
          final lng = station['geometry']['location']['lng'];
          final name = station['name'] ?? 'Unnamed Station';
          return Marker(
              markerId: MarkerId(name),
              position: LatLng(lat, lng),
              infoWindow: InfoWindow(title: name),
              onTap: () {
                _showStationModal(station);
              });
        }).toSet();
        if (_initialPosition != null) {
          _markers.add(
            Marker(
              markerId: const MarkerId('my_location'),
              position: _initialPosition!,
              infoWindow: const InfoWindow(title: 'My Location'),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            ),
          );
        }
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void _showStationModal(dynamic station) {
    final name = station['name'] ?? 'Unnamed Station';
    final lat = station['geometry']['location']['lat'];
    final lng = station['geometry']['location']['lng'];

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF2B2002),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, color: Colors.amberAccent),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Text(
                        'Latitude: ${lat.toStringAsFixed(6)}',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        'Longitude: ${lng.toStringAsFixed(6)}',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                        elevation: MaterialStateProperty.all<double>(5),
                      ),
                      onPressed: () => _openInMaps(lat, lng),
                      child: const Text('Open in Maps'),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                        elevation: MaterialStateProperty.all<double>(5),
                      ),
                      onPressed: () => _getDirections(lat, lng),
                      child: const Text('Directions'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Open location in Google Maps
  Future<void> _openInMaps(double lat, double lng) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      print('Could not launch $url');
    }
  }

  // Open directions in Google Maps
  Future<void> _getDirections(double lat, double lng) async {
    final currentLat = _initialPosition!.latitude;
    final currentLng = _initialPosition!.longitude;
    final url = 'https://www.google.com/maps/dir/?api=1&origin=$currentLat,$currentLng&destination=$lat,$lng';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        title: Row(
          children: [
            const Icon(
              Icons.ev_station,
              color: Colors.amberAccent,
            ),
            SizedBox(width: 5),
            Text(
              'Nearby Charging Stations',
              style: TextStyle(color: Colors.white, fontSize: 19),
            ),
          ],
        ),
      ),
      body: _initialPosition == null
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _initialPosition!,
                  zoom: 13,
                ),
                markers: _markers,
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
              ),
            ),
    );
  }
}

// getting the current location
Future<Position> _getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  // Check for location permissions
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  }

  // Get the current location
  return await Geolocator.getCurrentPosition();
}

//Fetch nearby ev stations
Future<List<dynamic>> getNearbyEvStations(double latitude, double longitude) async {
  const apiKey = googleMapsApiKey;
  const radius = 5000; // 5 km radius
  const type = 'charging_station'; // Type of place to search for

  final url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=$radius&type=$type&key=$apiKey';

  final response = await http.get(Uri.parse(url));
  print(response.body);
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['results'];
  } else {
    throw Exception('Failed to load nearby EV stations');
  }
}
