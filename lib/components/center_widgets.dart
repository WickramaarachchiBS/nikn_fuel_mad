import 'package:flutter/material.dart';

class CenterWidget extends StatelessWidget {
  const CenterWidget({super.key, required this.color, required this.icon, required this.title, required Function() onTapped});

  final Color color;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0.0),
      width: 170.0,
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Stack(
        children: [
          // Icon at the top-right
          Positioned(
            top: 10,
            right: 10,
            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),
          // Text at the bottom-left
          Positioned(
            bottom: 10,
            left: 10,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CenterWidget2 extends StatelessWidget {
  const CenterWidget2({super.key, required this.color, required this.icon, required this.title, required Function() onTapped});

  final Color color;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(0.0),
        width: 170.0,
        height: 150,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Stack(
          children: [
            // Icon at the top-right
            Positioned(
              top: 10,
              right: 10,
              child: Icon(
                icon,
                color: Colors.white,
                size: 40,
              ),
            ),
            // Text at the bottom-left
            Positioned(
              bottom: 10,
              left: 10,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
