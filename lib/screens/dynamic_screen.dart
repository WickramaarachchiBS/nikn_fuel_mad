import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:nikn_fuel/screens/homeScreenContent/home_content.dart';
import 'package:nikn_fuel/services/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import 'package:nikn_fuel/components/navigation.dart';

class DynamicScreen extends StatefulWidget {
  const DynamicScreen({super.key});

  @override
  State<DynamicScreen> createState() => _DynamicScreenState();
}

class _DynamicScreenState extends State<DynamicScreen> {
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
  ];

  @override
  Widget build(BuildContext context) {
    final bottomItems = <Widget>[
      Icon(Icons.home_outlined, color: Color.fromARGB(255, 255, 255, 255)),
      // Icon(Icons.local_gas_station_outlined, color: Color.fromARGB(255, 255, 255, 255)),
      // Icon(Icons.ev_station_outlined, color: Color.fromARGB(255, 255, 255, 255)),
      // Icon(Icons.person_outlined, color: Color.fromARGB(255, 255, 255, 255)),
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          leading: Transform.scale(
            scale: 0.7,
            child: Image.asset(
              'assets/logo.png',
              // fit: BoxFit.cover,
            ),
          ),
          titleSpacing: 0.0,
          title: Text(
            'RefuelX',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
            ),
          ),
          actions: <Widget>[
            // Padding(
            //   padding: const EdgeInsets.only(right: 1.0),
            //   child: Icon(Icons.menu, color: Colors.white),
            // ),
            // SizedBox(width: 10.0),
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
        // bottomNavigationBar: CurvedNavigationBar(
        //   items: bottomItems,
        //   index: _currentIndex,
        //   height: 47.0,
        //   backgroundColor: Colors.transparent,
        //   buttonBackgroundColor: const Color.fromARGB(255, 65, 50, 50),
        //   color: Color.fromARGB(255, 59, 59, 59),
        //   animationCurve: Curves.easeInOut,
        //   animationDuration: Duration(milliseconds: 400),
        //   onTap: (index) {
        //     setState(() {
        //       _currentIndex = index;
        //     });
        //   },
        // ),
      ),
    );
  }
}
