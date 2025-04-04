import 'package:flutter/material.dart';

class LocationContent extends StatefulWidget {
  const LocationContent({super.key});

  @override
  State<LocationContent> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Center(
        child: Text(
          'Location Content',
          style: TextStyle(
            fontSize: 30,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
    );
  }
}
