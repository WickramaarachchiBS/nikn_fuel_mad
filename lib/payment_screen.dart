import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Payment', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your payment details',
              style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            RichText(
              text: TextSpan(
                text: 'By continuing you agree to our ',
                style: TextStyle(color: Colors.white70, fontSize: 14),
                children: [
                  TextSpan(
                    text: 'Terms',
                    style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                paymentIcon('assets/paypal.png'),
                paymentIcon('assets/visa.png'),
                paymentIcon('assets/mastercard.png'),
                paymentIcon('assets/discover.jpg'),
                paymentIcon('assets/amex.png'),
              ],
            ),
            SizedBox(height: 30),
            buildTextField('Cardholder Name'),
            SizedBox(height: 20),
            buildTextField('Card Number', isNumber: true),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: buildDropdownField('Exp Month', List.generate(12, (index) => (index + 1).toString()))),
                SizedBox(width: 15),
                Expanded(child: buildDropdownField('Exp Year', List.generate(10, (index) => (2024 + index).toString()))),
              ],
            ),
            SizedBox(height: 20),
            buildTextField('CVC', isNumber: true),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  backgroundColor: Colors.red,
                ),
                child: Text('PAY NOW', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, {bool isNumber = false}) {
    return TextField(
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey[900],
      ),
      style: TextStyle(color: Colors.white),
    );
  }

  Widget buildDropdownField(String label, List<String> items) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey[900],
      ),
      dropdownColor: Colors.black,
      items: items.map((String value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value, style: TextStyle(color: Colors.white)),
        );
      }).toList(),
      onChanged: (value) {},
    );
  }

  Widget paymentIcon(String path) {
    return Image.asset(path, width: 50);
  }
}
