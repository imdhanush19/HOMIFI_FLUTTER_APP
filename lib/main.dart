import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:osapp/firebase_options.dart';
import 'auth/mainpage.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp()); // Instantiate MyApp without const
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(), // Define route for login page
    );
  }
}
