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
                    text: userName,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  const TextSpan(
                    text: ' !',
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
                    color: const Color.fromARGB(255, 61, 15, 15),
                    icon: Icons.local_gas_station,
                    title: 'Fuel Stations',
                  ),
                  CenterWidget(
                    onTapped: () {
                      Navigator.pushNamed(context, '/ev_stations');
                    },
                    color: const Color.fromARGB(255, 113, 93, 43),
                    icon: Icons.ev_station,
                    title: 'EV Stations',
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CenterWidget(
                    onTapped: () {
                      Navigator.pushNamed(context, '/service_stations');
                    },
                    color: const Color.fromARGB(255, 17, 53, 33),
                    icon: Icons.garage_outlined,
                    title: 'Service Stations',
                  ),
                  CenterWidget(
                    onTapped: () {
                      Navigator.pushNamed(context, '/deals');
                    },
                    color: const Color.fromARGB(255, 49, 19, 63),
                    icon: Icons.redeem,
                    title: 'Deals',
                  ),
                ],
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.055, right: screenWidth * 0.055, top: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CenterWidget2(
                      onTapped: () {
                        Navigator.pushNamed(context, '/fuel_order');
                      },
                      color: const Color.fromARGB(193, 9, 38, 82),
                      icon: Icons.local_shipping,
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
    );
  }
}
