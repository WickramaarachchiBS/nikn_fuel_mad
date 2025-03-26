import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class FuelStationScreen extends StatefulWidget {
  const FuelStationScreen({super.key});

  @override
  State<FuelStationScreen> createState() => _FuelStationScreenState();
}

class _FuelStationScreenState extends State<FuelStationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.red,
              ),
              SizedBox(width: 8),
              Text(
                "Nearby Filling Stations...",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        // body: FlutterMap(
        //   options: MapOptions(
        //     initialCenter: LatLng(6.9271, 79.8612), // Initial map center
        //     initialZoom: 13.0, // Adjust zoom level
        //   ),
        //   children: [
        //     // Background or map placeholder
        //     TileLayer(
        //       urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
        //     ),
        //     MarkerLayer(
        //       markers: [
        //         Marker(
        //           width: 80.0,
        //           height: 80.0,
        //           point: LatLng(6.9271, 79.8612),
        //           child: Icon(Icons.location_pin, color: Colors.red, size: 40),
        //         ),
        //       ],
        //     ),
        //
        //     // Bottom Sheet
        //     Align(
        //       alignment: Alignment.bottomCenter,
        //       child: Container(
        //         width: double.infinity,
        //         margin: const EdgeInsets.all(8),
        //         padding: const EdgeInsets.all(12),
        //         decoration: BoxDecoration(
        //           color: Colors.red,
        //           borderRadius: BorderRadius.circular(10),
        //         ),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             // Station Name and Directions Button
        //             Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               mainAxisSize: MainAxisSize.min,
        //               children: [
        //                 const Text(
        //                   "Homagama Filling Station",
        //                   style: TextStyle(
        //                     fontSize: 16,
        //                     fontWeight: FontWeight.bold,
        //                     color: Colors.white,
        //                   ),
        //                 ),
        //                 const SizedBox(height: 5),
        //                 ElevatedButton(
        //                   onPressed: () {
        //                     // Handle navigation to directions
        //                   },
        //                   style: ElevatedButton.styleFrom(
        //                     backgroundColor: Colors.green,
        //                     shape: RoundedRectangleBorder(
        //                       borderRadius: BorderRadius.circular(20),
        //                     ),
        //                   ),
        //                   child: const Text("Directions"),
        //                 ),
        //               ],
        //             ),
        //
        //             // Close Button
        //             GestureDetector(
        //               onTap: () {
        //                 // Handle close action
        //               },
        //               child: const Icon(Icons.close, color: Colors.white),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
