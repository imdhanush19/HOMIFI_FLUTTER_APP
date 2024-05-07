/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:osapp/pages/clickeasehome.dart';
import '../auth_page.dart';
import '../pages/homepage.dart';
import '../pages/login.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key); // Corrected constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}

 */




import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:osapp/pages/clickeasehome.dart';
import '../auth_page.dart';
import '../pages/homepage.dart';
import '../pages/login.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Return a loading indicator if the connection state is waiting
          return CircularProgressIndicator();
        } else if (snapshot.hasData) {
          // If user is authenticated, navigate to ClickEase
          return ClickEase();
        } else {
          // If user is not authenticated, show the authentication page
          return AuthPage();
        }
      },
    );
  }
}

 

