import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:nikn_fuel/screens/homeScreenContent/home_content.dart';
import 'package:nikn_fuel/screens/homeScreenContent/location_content.dart';
import 'package:nikn_fuel/screens/homeScreenContent/fuel_content.dart';
import 'package:nikn_fuel/screens/homeScreenContent/profile_content.dart';
import 'package:nikn_fuel/services/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import 'package:nikn_fuel/components/navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomeContent(),
    FuelContent(),
    LocationContent(),
    ProfileContent(),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomItems = <Widget>[
      Icon(Icons.home_outlined, color: Color.fromARGB(255, 255, 255, 255)),
      Icon(Icons.ev_station_outlined, color: Color.fromARGB(255, 255, 255, 255)),
      Icon(Icons.explore, color: Color.fromARGB(255, 255, 255, 255)),
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
          SizedBox(width: 10.0),
          IconButton(
            onPressed: () {
              _auth.signOut();
              // Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/sign_in');
            },
            icon: Icon(Icons.logout),
            color: Colors.white,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: bottomItems,
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
