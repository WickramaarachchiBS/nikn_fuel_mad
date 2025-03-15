import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
              backgroundColor:
                  WidgetStatePropertyAll(const Color.fromARGB(255, 46, 46, 46)),
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
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: 170.0,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 62, 129, 88),
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Text(
                        'What would you like to do today?',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: 170.0,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 62, 111, 151),
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Text(
                        'What would you like to do today?',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: 170.0,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 36, 201, 58),
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Text(
                        'What would you like to do today?',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: 170.0,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 74, 45, 100),
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Text(
                        'What would you like to do today?',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(),
            Row(),
          ],
        ),
      ),
    );
  }
}
