import 'package:flutter/material.dart';

class SnackBarWidget extends StatelessWidget {
  final String? message;

  const SnackBarWidget({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(
        message!,
      ),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(top: 50, left: 10, right: 10),
      duration: Duration(seconds: 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
