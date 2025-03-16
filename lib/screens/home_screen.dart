import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:nikn_fuel/screens/homeScreenContent/HomeContent.dart';
import 'package:nikn_fuel/screens/homeScreenContent/location_content.dart';
import 'package:nikn_fuel/screens/homeScreenContent/FuelContent.dart';
import 'package:nikn_fuel/screens/homeScreenContent/ProfileContent.dart';

// import 'package:nikn_fuel/components/navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomeContent(),
    FuelContent(),
    LocationContent(),
    ProfileContent(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.home_outlined, color: Color.fromARGB(255, 255, 255, 255)),
      Icon(Icons.ev_station_outlined, color: Color.fromARGB(255, 255, 255, 255)),
      Icon(Icons.location_on_outlined, color: Color.fromARGB(255, 255, 255, 255)),
      Icon(Icons.person_outlined, color: Color.fromARGB(255, 255, 255, 255)),
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        leading: Icon(Icons.arrow_back_ios, color: Colors.white),
        title: Text(
          'Nikn Fuel',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 1.0),
            child: Icon(Icons.menu, color: Colors.white),
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        items: items,
        index: _currentIndex,
        height: 60.0,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        buttonBackgroundColor: const Color.fromARGB(255, 65, 50, 50),
        color: Color.fromARGB(255, 59, 59, 59),
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
