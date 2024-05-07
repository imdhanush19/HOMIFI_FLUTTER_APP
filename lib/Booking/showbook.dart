import 'package:flutter/material.dart';

import '../pages/clickeasehome.dart';

class BookingConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Confirmation'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.done,
              size: 80.0,
              color: Colors.green,
            ),
            Text(
              'Booking Confirmed!',
              style: TextStyle(fontSize: 24.0),
            ),
            ElevatedButton(
              onPressed:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClickEase()),
                );
              }, child: Text('BACK') ,
            ),
          ],
        ),
      ),
    );
  }
}
