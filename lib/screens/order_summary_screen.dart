import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class OrderSummaryScreen extends StatefulWidget {
  final bool isFuelOrder;

  final String? selectedFuel;
  final String? selectedType;
  final double? fuelAmount;

  final String? chargingType;
  final String? level;
  final double? expectedPercentage;

  const OrderSummaryScreen({
    super.key,
    required this.isFuelOrder,
    this.selectedFuel,
    this.selectedType,
    this.fuelAmount,
    this.chargingType,
    this.level,
    this.expectedPercentage,
  });

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  GoogleMapController? mapController;
  LatLng? _initialPosition;
  Set<Marker> _markers = {};

  double distance = 0.0;
  //charging station location
  final double permanentLat = 33.629508;
  final double permanentLng = -117.925069;

  // Price for fuel & delivery
  final double pricePerLiter = 350; // Rs. 350 per liter
  final double deliveryRatePerKm = 50; // Rs. 50 per km
  // Price for EV charging
  final double pricePerPercentage = 150; // Rs. 50 per percentage

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
        _markers.add(
          Marker(
            markerId: const MarkerId('permanent_location'),
            position: LatLng(permanentLat, permanentLng),
            infoWindow: const InfoWindow(title: 'Permanent Location'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ),
        );
        double distanceInMeters = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          permanentLat,
          permanentLng,
        );
        distance = distanceInMeters / 1000; // Convert to kilometers
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
    // Calculate prices
    double serviceCost = 0;
    double deliveryCost = 0;
    double totalCost = 0;

    if (widget.isFuelOrder) {
      serviceCost = pricePerLiter * (widget.fuelAmount ?? 0);
      deliveryCost = deliveryRatePerKm * distance;
      totalCost = serviceCost + deliveryCost;
    } else {
      serviceCost = pricePerPercentage * (widget.expectedPercentage ?? 0);
      deliveryCost = deliveryRatePerKm * distance;
      totalCost = serviceCost + deliveryCost;
    }

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
          title: const SizedBox.shrink(),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Your Order Will Be Delivered Here...',
                    style: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                  Text('data')
                ],
              ),
            ),

            // Map Section
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: _initialPosition == null
                    ? const Center(child: CircularProgressIndicator())
                    : GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: _initialPosition!,
                          zoom: 17,
                        ),
                        markers: _markers,
                        onMapCreated: (GoogleMapController controller) {
                          mapController = controller;
                        },
                      ),
              ),
            ),
            Text(
              'Distance: ${distance.round()} km from our nearest outlet',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            const SizedBox(height: 16),
            // Order Summary
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  if (widget.isFuelOrder) ...[
                    _buildSummaryRow(widget.selectedFuel ?? ''),
                    const SizedBox(height: 8),
                    _buildSummaryRow(widget.selectedType ?? ''),
                    const SizedBox(height: 8),
                    _buildSummaryRow('${widget.fuelAmount?.round() ?? 0} Ltr'),
                    const SizedBox(height: 8),
                  ] else ...[
                    _buildSummaryRow(widget.chargingType ?? ''),
                    const SizedBox(height: 8),
                    _buildSummaryRow(widget.level ?? ''),
                    const SizedBox(height: 8),
                    _buildSummaryRow('${widget.expectedPercentage?.round() ?? 0}%'),
                    const SizedBox(height: 8),
                  ],
                  // Price Breakdown
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Price',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        if (widget.isFuelOrder)
                          _buildPriceRow('$pricePerLiter*${widget.fuelAmount?.round() ?? 0}', serviceCost.toStringAsFixed(0))
                        else
                          _buildPriceRow('$pricePerPercentage*${widget.expectedPercentage?.round() ?? 0}', serviceCost.toStringAsFixed(0)),
                        const SizedBox(height: 8),
                        if (widget.isFuelOrder)
                          _buildPriceRow('(Rs.$deliveryRatePerKm per KM) $deliveryRatePerKm*${distance.round()}', deliveryCost.toStringAsFixed(0))
                        else
                          _buildPriceRow('(Rs.$deliveryRatePerKm per KM)$deliveryRatePerKm*${widget.expectedPercentage?.round() ?? 0}',
                              deliveryCost.toStringAsFixed(0)),
                        const SizedBox(height: 16),
                        _buildPriceRow('TOTAL', 'Rs. ${totalCost.round()}', isTotal: true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Proceed to Payment Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  // Handle "Proceed to Payment" button press
                  print('Proceeding to payment...');
                  print('Total Cost: Rs. $totalCost');
                  // Navigate to payment screen or perform payment action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Proceed to Payment',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String value) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  // Helper method to build price breakdown rows
  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isTotal ? Colors.white : Colors.grey[400],
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isTotal ? Colors.white : Colors.grey[400],
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
