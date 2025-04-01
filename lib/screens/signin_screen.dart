import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nikn_fuel/components/textfield_widget.dart';
import 'package:nikn_fuel/services/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> signIn() async {
    setState(() {
      isLoading = true;
    });
    try {
      await authService.value.signIn(email: emailController.text.trim(), password: passwordController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign in successful!'), backgroundColor: Colors.green),
      );
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Sign in failed'), backgroundColor: Colors.red),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('assets/logo.png'),
                  ),
                ),
                SizedBox(height: 10),
                // RefuelX title
                Text(
                  'RefuelX',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Montserrat',
                  ),
                ),
                SizedBox(height: 200),
                Container(
                  margin: EdgeInsets.only(left: 27),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Let's sign you in",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Email field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFieldWidget(
                    hintText: 'Username*',
                    icon: Icons.person,
                    controller: emailController,
                  ),
                ),
                SizedBox(height: 20),
                // Password field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFieldWidget(
                    hintText: 'Password*',
                    icon: Icons.lock,
                    controller: passwordController,
                    obscureText: true,
                  ),
                ),
                SizedBox(height: 30),
                // Sign In button
                isLoading
                    ? CircularProgressIndicator(
                        color: Color(0xFFE7121C),
                      )
                    : ElevatedButton(
                        onPressed: signIn,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE7121C),
                          padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                SizedBox(height: 20),

                TextButton(
                  onPressed: () {
                    // Add forgot password logic
                  },
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(color: Color(0xFFE7121C)),
                  ),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/sign_up');
                  },
                  child: Text(
                    'Create New Account',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
