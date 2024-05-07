import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:osapp/Booking/showbook.dart';

import 'package:mailer/smtp_server.dart';


class BookingPage extends StatefulWidget {
  final String providerName;

  const BookingPage({super.key, required this.providerName});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? selectedDateTime;
  double cost = 0.0; // Initialize cost

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser; // Get current user

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Booking Details'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Container(
          width:400.0,
          height:400.0,
          decoration: BoxDecoration(
            color:Colors.lightBlue[100],
            borderRadius: BorderRadius.circular(12.0),
            border:Border.all(
              color:Colors.grey,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Service Provider: ${widget.providerName}'),
              user != null
                  ? Text('Service Availer: ${user.email}') // Display user's email (if logged in)
                  : Text('Please sign in to book a service'), // Inform about login
              ElevatedButton(
                onPressed: () async {
                  selectedDateTime = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDateTime != null) {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then((selectedTime) {
                      if (selectedTime != null) {
                        setState(() {
                          selectedDateTime = DateTime(
                            selectedDateTime!.year,
                            selectedDateTime!.month,
                            selectedDateTime!.day,
                            selectedTime.hour,
                            selectedTime.minute,
                          );
                          cost = calculateCost(selectedDateTime!); // Calculate cost based on date/time
                        });
                      }
                    });
                  }
                },
                child: Text(
                  selectedDateTime != null
                      ? '${selectedDateTime!.year}-${selectedDateTime!.month}-${selectedDateTime!.day} ${selectedDateTime!.hour}:${selectedDateTime!.minute}'
                      : 'Select Date & Time',
                ),
              ),
              Text('Cost: Rs' + cost.toStringAsFixed(2)), // Display formatted cost
              ElevatedButton(
                onPressed: user != null && selectedDateTime != null
                    ? () async {
                  // Booking confirmation logic
                  final userEmail = user!.email!;
                  final providerName = widget.providerName;
                  final bookingDateTime = selectedDateTime!;

                  // 1. Show confirmation dialog (optional)
                  final confirmed = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Booking Confirmation'),
                      content: Text(
                        'Are you sure you want to book with $providerName on $bookingDateTime?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text('Confirm'),
                        ),
                      ],
                    ),
                  );

                  if (!confirmed) return; // User cancelled confirmation

                  // 2. Send confirmation email (assuming you have a method for this)
                  await sendBookingConfirmationEmail(userEmail, providerName, bookingDateTime);

                  // 3. Show success screen (next page with done icon)
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BookingConfirmationPage()),
                  );
                }
                    : null,
                child: Text('Confirm Booking'),
              ),


            ],
          ),
        ),
      ),
    );
  }

  double calculateCost(DateTime dateTime) {
    double baseCost = 700.0; // Weekday base cost
    if (dateTime.weekday == DateTime.saturday || dateTime.weekday == DateTime.sunday) {
      baseCost = 800.0; // Weekend base cost
    }

    int hour = dateTime.hour;
    if (hour >= 18 || hour < 8) { // Evening/night hours
      baseCost += 100.0;
    }

    return baseCost;
  }

  Future<void> sendBookingConfirmationEmail(
      String userEmail,
      String providerName,
      DateTime bookingDateTime,
      ) async {
    final smtpServer = gmail('whyratkhowli@gmail.com', 'pugw jpbr eohe eebs');

    final message = Message()
      ..from = Address('whyratkhowli@gmail.com', 'Homifi')
      ..recipients.add(userEmail)
      ..subject = 'Booking Confirmation - $providerName'
      ..text = '''
      Hi $userEmail,

      This email confirms your booking with $providerName on $bookingDateTime.

      Please note this is just a confirmation email, and the appointment details might vary depending on the service provider.

      Thanks,
      Homifi Team
    ''';

    try {
      final sendReport = await send(message, smtpServer);
      print('Email sent: ${sendReport.toString()}');
    } catch (e) {
      print('Error sending email: $e');
    }
  }




}
