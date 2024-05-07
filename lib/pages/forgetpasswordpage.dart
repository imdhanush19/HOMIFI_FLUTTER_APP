

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController=TextEditingController();
  @override
  void dispose(){
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async{
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email:_emailController.text.trim());
      showDialog(context: context,
          builder:(context){
            return AlertDialog(
              content:Text("Password reset link sent! Check your MailBox!!",),
            );
          } );
    } on FirebaseAuthException catch(e){
      print(e);
      showDialog(context: context,
          builder:(context){
            return AlertDialog(
              content:Text(e.message.toString()),
            );
          } );
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar:AppBar(
        backgroundColor: Colors.green,
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Enter your email for new password',
          style:TextStyle(
            color:Colors.white,
          ),
          ),
          SizedBox(height:10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email',
                    prefixIcon:Icon(Icons.email),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height:10.0),
          MaterialButton(onPressed:passwordReset,
          child:Text('Reset Password'),
          color:Colors.green,)

        ],
      )
    );
  }
}
