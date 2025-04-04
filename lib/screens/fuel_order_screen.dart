import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nikn_fuel/screens/order_summary_screen.dart';

class FuelOrderScreen extends StatefulWidget {
  const FuelOrderScreen({super.key});

  @override
  State<FuelOrderScreen> createState() => _FuelOrderScreenState();
}

class _FuelOrderScreenState extends State<FuelOrderScreen> {
  GoogleMapController? mapController;
  LatLng? _initialPosition;
  Set<Marker> _markers = {};

  // State variables for selections
  String _selectedFuel = 'Petrol'; // Default fuel type
  String _selectedType = 'Octane 92'; // Default type for Petrol
  double _fuelAmount = 10; // Default fuel amount in liters

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
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
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
              margin: EdgeInsets.only(right: 20.0),
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
                  Navigator.pushNamed(context, '/ev_order');
                },
                child: const Text(
                  'Switch to EV',
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
                    style: TextStyle(color: Colors.limeAccent, fontSize: 15),
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
                // border: Border.all(color: Colors.blue, width: 2),
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
            // Fuel Type Selection
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Fuel',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Row(
                    children: [
                      _buildFuelTypeButton('Petrol'),
                      const SizedBox(width: 8),
                      _buildFuelTypeButton('Diesel'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Fuel Type Options
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Type',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Row(
                    children: _selectedFuel == 'Petrol'
                        ? [
                            _buildTypeButton('Octane 92'),
                            const SizedBox(width: 8),
                            _buildTypeButton('Octane 95'),
                          ]
                        : [
                            _buildTypeButton('Auto Diesel'),
                            const SizedBox(width: 8),
                            _buildTypeButton('Super Diesel'),
                          ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Fuel Amount Slider
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Fuel Amount',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Row(
                    children: [
                      Slider(
                        value: _fuelAmount,
                        min: 1,
                        max: 50,
                        divisions: 49,
                        label: _fuelAmount.round().toString(),
                        onChanged: (value) {
                          setState(() {
                            _fuelAmount = value;
                          });
                        },
                        activeColor: Colors.grey,
                        inactiveColor: Colors.grey[800],
                      ),
                      Text(
                        '${_fuelAmount.round()} Ltr',
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
                        isFuelOrder: true,
                        selectedFuel: _selectedFuel,
                        selectedType: _selectedType,
                        fuelAmount: _fuelAmount,
                      ),
                    ),
                  );
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

  // Helper method to build fuel type buttons
  Widget _buildFuelTypeButton(String fuel) {
    bool isSelected = _selectedFuel == fuel;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFuel = fuel;
          // Reset type based on fuel selection
          _selectedType = fuel == 'Petrol' ? 'Octane 92' : 'Auto Diesel';
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey : Colors.grey[800],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          fuel,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  // Helper method to build type buttons
  Widget _buildTypeButton(String type) {
    bool isSelected = _selectedType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedType = type;
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
}
