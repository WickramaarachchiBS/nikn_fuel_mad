import 'package:flutter/material.dart';
import 'package:nikn_fuel/screens/dynamic_screen.dart';
import 'package:nikn_fuel/screens/evstations_screen.dart';
import 'package:nikn_fuel/screens/welcome_screen.dart';
import 'package:nikn_fuel/screens/signin_sceen.dart';
import 'package:nikn_fuel/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nikn_fuel/screens/fuelstations_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DynamicScreen(),
      routes: {
        '/home': (context) => const DynamicScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/sign_in': (context) => const SignInScreen(),
        '/sign_up': (context) => const SignUpScreen(),
        '/fuel_stations': (context) => const GasStationsScreen(),
        '/ev_stations': (context) => const EvStationsScreen(),
      },
    );
  }
}
