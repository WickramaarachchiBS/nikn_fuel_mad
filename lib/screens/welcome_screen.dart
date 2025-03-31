import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize any necessary data or state here
  }

  Future<void> _checkUserStatus() async {
    await Future.delayed(const Duration(seconds: 0));
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to Nikn Fuel',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sign_in');
              },
              child: Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
