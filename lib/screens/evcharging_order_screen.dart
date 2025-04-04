import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nikn_fuel/screens/order_summary_screen.dart';

class EvChargingOrderScreen extends StatefulWidget {
  const EvChargingOrderScreen({super.key});

  @override
  State<EvChargingOrderScreen> createState() => _EvChargingOrderScreenState();
}

class _EvChargingOrderScreenState extends State<EvChargingOrderScreen> {
  GoogleMapController? mapController;
  LatLng? _initialPosition;
  Set<Marker> _markers = {};

  // State variables for selections
  String _selectedChargingType = 'AC'; // Default charging type
  String _selectedLevel = 'Level 2 (3-22kW)'; // Default level for AC
  double _expectedPercentage = 90; // Default expected percentage

  @override
  void initState() {
    super.initState();
    _loadUserLocation();
  }

  Future<void> _loadUserLocation() async {
    try {
      Position position = await _getCurrentLocation();
      setState(() {
        _initialPosition = LatLng(position.latitude, position.longitude);
        _markers.add(
          Marker(
            markerId: const MarkerId('my_location'),
            position: _initialPosition!,
            infoWindow: const InfoWindow(title: 'My Location'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
        );
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context); // Go back to the previous screen
            },
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  side: const BorderSide(color: Colors.orange, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/fuel_order');
                },
                child: const Text(
                  'Switch to Fuel',
                  style: TextStyle(fontSize: 16, color: Colors.orange),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Your Location...',
                    style: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                ],
              ),
            ),
            // Map Section
            Container(
              height: MediaQuery.of(context).size.height * 0.49,
              margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: _initialPosition == null
                    ? const Center(child: CircularProgressIndicator())
                    : GoogleMap(
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
            ),
            const SizedBox(height: 16),
            // Charging Type Selection
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Charging Type',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Row(
                    children: [
                      _buildChargingTypeButton('AC'),
                      const SizedBox(width: 8),
                      _buildChargingTypeButton('DC'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Level Selection
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Level',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Row(
                    children: _selectedChargingType == 'AC'
                        ? [
                            _buildLevelButton('Level 2 (3-22kW)'),
                          ]
                        : [
                            _buildLevelButton('Level 3 (50-350kW)'),
                          ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Expected Percentage Slider
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Expected Per(%)',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Row(
                    children: [
                      Slider(
                        value: _expectedPercentage,
                        min: 1,
                        max: 100,
                        divisions: 99,
                        label: _expectedPercentage.round().toString(),
                        onChanged: (value) {
                          setState(() {
                            _expectedPercentage = value;
                          });
                        },
                        activeColor: Colors.grey,
                        inactiveColor: Colors.grey[800],
                      ),
                      Text(
                        '${_expectedPercentage.round()}%',
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Next Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderSummaryScreen(
                          isFuelOrder: false,
                          chargingType: _selectedChargingType,
                          level: _selectedLevel,
                          expectedPercentage: _expectedPercentage,
                        ),
                      ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build charging type buttons
  Widget _buildChargingTypeButton(String type) {
    bool isSelected = _selectedChargingType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedChargingType = type;
          // Reset level based on charging type
          _selectedLevel = type == 'AC' ? 'Level 2 (3-22kW)' : 'Level 3 (50-350kW)';
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey : Colors.grey[800],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          type,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  // Helper method to build level buttons
  Widget _buildLevelButton(String level) {
    bool isSelected = _selectedLevel == level;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLevel = level;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey : Colors.grey[800],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          level,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
