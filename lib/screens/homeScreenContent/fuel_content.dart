import 'package:flutter/material.dart';

class FuelContent extends StatefulWidget {
  const FuelContent({super.key});

  @override
  State<FuelContent> createState() => _FuelContentState();
}

class _FuelContentState extends State<FuelContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Center(
        child: Text(
          'Fuel Content',
          style: TextStyle(
            fontSize: 30,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
    );
  }
}
