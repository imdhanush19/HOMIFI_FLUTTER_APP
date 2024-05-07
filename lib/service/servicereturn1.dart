import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Booking/booking6.dart';

class GetService1 extends StatelessWidget {
  final String documentId;
  final user = FirebaseAuth.instance.currentUser;

  GetService1({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('cleaning');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error retrieving data: ${snapshot.error}');
          }

          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

          // Access and display all retrieved details
          String name = data['Name'];
          int mobile = data['Mobile'];
          double rating = data['Rating'].toDouble();

          return Container(
            height:130.0,
            width:85.0,
            decoration: BoxDecoration(
              color:Colors.lightBlueAccent[100],
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(

                children: [
                  Text('Name: $name'),
                  Text('Mobile: $mobile'),
                  Text('Rating: $rating'),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingPage(
                            providerName: name,
                          ),
                        ),
                      );

                      print('Book button pressed for $name');
                    },
                    child: Text('Book',
                    style:TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                ],
              ),
            ),
          );
        }

        return Text('Loading');
      }),
    );
  }
}
