import 'package:flutter/material.dart';

class CenterWidget extends StatelessWidget {
  const CenterWidget({super.key, required this.color1, required this.color2, required this.icon, required this.title, required this.onTapped});

  final Color color1;
  final Color color2;
  final IconData icon;
  final String title;
  final Function() onTapped;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Container(
        padding: EdgeInsets.all(0.0),
        width: 170.0,
        height: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color1.withOpacity(1),
              color2.withOpacity(0.5),
              // Colors.black.withOpacity(0.5),
            ],
            stops: [0.3, 0.7],
          ),
          borderRadius: BorderRadius.circular(18.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(2, 2), // changes position of shadow
            ),
          ],
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
      ),
    );
  }
}

class CenterWidget2 extends StatelessWidget {
  const CenterWidget2(
      {super.key, required this.color1, required this.color2, required this.color3, required this.icon, required this.title, required this.onTapped});

  final Color color1;
  final Color color2;
  final Color color3;
  final IconData icon;
  final String title;
  final Function() onTapped;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTapped,
        child: Container(
          padding: EdgeInsets.all(0.0),
          width: 170.0,
          height: 150,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color1.withOpacity(1),
                color2.withOpacity(0.5),
                color3.withOpacity(0.5),
                // Colors.black.withOpacity(0.5),
              ],
              stops: [0.2, 0.5, 0.9],
            ),
            borderRadius: BorderRadius.circular(18.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(2, 2), // changes position of shadow
              ),
            ],
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
      ),
    );
  }
}
