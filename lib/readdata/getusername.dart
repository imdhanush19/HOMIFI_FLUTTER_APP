import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class GetUserName extends StatelessWidget {
  final String documentId;
  final user = FirebaseAuth.instance.currentUser;
  GetUserName({required this.documentId});






  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('app');
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(documentId).get(),
        builder: ((context, snapshot){
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic>data =
            snapshot.data!.data() as Map<String, dynamic>;
            String name = data['name'];
            int age = data['age'];
            int mobile = data['mobile'];
            String email = data['email'];

            if ('$email'==user?.email){
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CircleAvatar(
                      radius:70.0,
                    ),
                  ),

                  Text('Name: $name',
                  style:TextStyle(
                    color:Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),),
                  Text('Age: $age',
                      style:TextStyle(
                        color:Colors.white,
                        fontSize: 20.0,

                      )),
                  Text('Mobile: $mobile',
                      style:TextStyle(
                        color:Colors.white,
                        fontSize: 20.0,
                      )),
                  Text('Email: $email',
                      style:TextStyle(
                        color:Colors.white,
                        fontSize: 20.0,
                      )),
                ],
              );
            }



          }


          return Text('Loading');
        }));
  }
}