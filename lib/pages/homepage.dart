import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:osapp/pages/login.dart';
import 'package:osapp/readdata/getusername.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;
  List<String>docsIDs=[];

  get toggleScreens => null;

  Future getDocId() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }

    final snapshot = await FirebaseFirestore.instance
        .collection('app')
        .where('email', isEqualTo: user.email)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final documentID = snapshot.docs.first.reference.id;
      docsIDs.add(documentID);
    }
  }

  void toggle(){
    return null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(

        title:Text((user?.email ?? "Not signed in"),
            style:TextStyle(
            fontSize: 15.0,
              color:Colors.black87,
              fontWeight: FontWeight.bold,

        ),
        ),
        backgroundColor: Colors.green,
        centerTitle:true,
             ),// Remove const
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: FutureBuilder(
                  future: getDocId(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return GetUserName(documentId: docsIDs.first);

                    }
                    return Text('Loading');
                  },
                ),
              ),
              MaterialButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage(showRegisterPage:toggle),),
                  );
                },
                color: Colors.green,
                child: Text('sign out'),
              ),



            ],
          )),
    );
  }
}
