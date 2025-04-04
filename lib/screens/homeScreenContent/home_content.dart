import 'package:flutter/material.dart';
import 'package:nikn_fuel/components/bottom_widget.dart';
import 'package:nikn_fuel/components/center_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nikn_fuel/screens/paymentUnsuccessfull_screen.dart';
import 'package:nikn_fuel/screens/paymentsuccessful_screen.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({
    super.key,
  });

  // Get the current user's name or username from email
  String _getUserName() {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return 'User';
    }

    if (user.displayName != null && user.displayName!.isNotEmpty) {
      return user.displayName!;
    } else if (user.email != null) {
      // Extract username from email (part before @)
      return user.email!.split('@')[0];
    } else {
      return 'User';
    }
  }

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final String userName = _getUserName();
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 1.0),
          //   child: SearchBar(
          //     backgroundColor: WidgetStatePropertyAll(const Color.fromARGB(255, 46, 46, 46)),
          //     hintText: '',
          //     leading: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Icon(
          //         Icons.search,
          //         color: Colors.red,
          //       ),
          //     ),
          //     shape: WidgetStatePropertyAll(
          //       RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(18.0),
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(height: 25.0),
          Container(
            padding: EdgeInsets.only(left: 30),
            alignment: Alignment.centerLeft,
            child: Text.rich(
              TextSpan(
                text: 'Hello ',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                  color: Colors.grey.shade500,
                ),
                children: [
                  TextSpan(
                    text: capitalizeFirstLetter(userName),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  const TextSpan(
                    text: ' !',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),

          // widgets
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CenterWidget(
                    onTapped: () {
                      Navigator.pushNamed(context, '/fuel_stations');
                    },
                    color1: const Color.fromARGB(255, 0, 0, 0),
                    color2: const Color.fromARGB(255, 255, 229, 41),
                    icon: Icons.local_gas_station_outlined,
                    title: 'Fuel Stations',
                  ),
                  CenterWidget(
                    onTapped: () {
                      Navigator.pushNamed(context, '/ev_stations');
                    },
                    color1: const Color.fromARGB(255, 0, 0, 0),
                    color2: const Color.fromARGB(255, 60, 179, 255),
                    icon: Icons.ev_station_outlined,
                    title: 'EV Stations',
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CenterWidget(
                    onTapped: () {
                      Navigator.pushNamed(context, '/service_stations');
                    },
                    color1: const Color.fromARGB(255, 35, 188, 100),
                    color2: const Color.fromARGB(255, 0, 0, 0),
                    icon: Icons.garage_outlined,
                    title: 'Service Stations',
                  ),
                  CenterWidget(
                    onTapped: () {
                      Navigator.pushNamed(context, '/deals');
                    },
                    color1: const Color.fromARGB(255, 176, 52, 228),
                    color2: const Color.fromARGB(255, 0, 0, 0),
                    icon: Icons.redeem_outlined,
                    title: 'Deals',
                  ),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.055, right: screenWidth * 0.055, top: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CenterWidget2(
                      onTapped: () {
                        Navigator.pushNamed(context, '/fuel_order');
                      },
                      color1: const Color.fromARGB(255, 98, 27, 129),
                      color2: const Color.fromARGB(255, 0, 0, 0),
                      color3: const Color.fromARGB(255, 64, 174, 169),
                      icon: Icons.local_shipping_outlined,
                      title: 'Mobile Fuel \nDistributer',
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Ongoing Tasks',
                style: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          BottomWidget(),
          // NavBar(),
        ],
      ),
    );
  }
}
