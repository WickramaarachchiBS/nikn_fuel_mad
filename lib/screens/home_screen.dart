import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:nikn_fuel/components/center_widgets.dart';
import 'package:nikn_fuel/components/bottom_widget.dart';
// import 'package:nikn_fuel/components/navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 1.0),
            child: Icon(Icons.menu, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SearchBar(
              backgroundColor: WidgetStatePropertyAll(const Color.fromARGB(255, 46, 46, 46)),
              hintText: '',
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.search,
                  color: Colors.red,
                ),
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              child: Text.rich(
                TextSpan(
                  text: 'Hello User ',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  children: [
                    TextSpan(
                      text: '!',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CenterWidget(
                      color: const Color.fromARGB(255, 61, 15, 15),
                      icon: Icons.explore,
                      title: 'Fuel Stations',
                    ),
                    CenterWidget(
                      color: const Color.fromARGB(193, 9, 38, 82),
                      icon: Icons.local_gas_station_outlined,
                      title: 'Mobile Fuel \nDistributer',
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CenterWidget(
                      color: const Color.fromARGB(255, 17, 53, 33),
                      icon: Icons.garage_outlined,
                      title: 'Service Stations',
                    ),
                    CenterWidget(
                      color: const Color.fromARGB(255, 49, 19, 63),
                      icon: Icons.redeem,
                      title: 'Deals',
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Journey',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                Text(
                  'Fuel Type',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                Text(
                  'Charging',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                Text(
                  'Payments',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            BottomWidget(),
            // NavBar(),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: items,
        height: 60.0,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        buttonBackgroundColor: const Color.fromARGB(255, 65, 50, 50),
        color: Color.fromARGB(255, 59, 59, 59),
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 400),
      ),
    );
  }
}
