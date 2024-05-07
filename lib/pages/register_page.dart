import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;

  const RegisterPage({super.key,required this.showLoginPage,});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();
  final _confirmpasswordController=TextEditingController();
  final _nameController=TextEditingController();
  final _mobilenoController=TextEditingController();
  final _ageController=TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _nameController.dispose();
    _mobilenoController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future SignUp() async {
    if (passwordConfirmed()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
        addUserDetails(
            _nameController.text.trim(),
            int.parse(_mobilenoController.text.trim()),
            int.parse(_ageController.text.trim()),
            _emailController.text.trim());
      } on FirebaseAuthException catch (error) {
        if (error.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (error.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          // You can display an error message to the user here
          // For example:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('An account already exists for this email. Please login.'),
            ),
          );
        }
      }
    } else {
      print('Passwords do not match.');
    }
  }



  Future addUserDetails(String Name,int Mobile,int Age,String Email) async{
    await FirebaseFirestore.instance.collection('app').add({
      'name':Name,
      'mobile':Mobile,
      'age':Age,
      'email':Email,
    });
  }
  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmpasswordController.text.trim()) {
      return true;
    }
    else {
      return false;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(

        child: Center(
          child: SingleChildScrollView(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage('images/doraemon.jpg'),
                  ),
              
                  Text(
                    'Register with your details',
                    style: TextStyle(
                      fontSize: 20.0,
                      color:Colors.green,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
              
              
                      ),
                      child:Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Name',
                            prefixIcon: Icon(Icons.email),
              
                          ),
                        ),
                      ),
              
              
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
              
              
                      ),
                      child:Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: TextField(
                          controller: _mobilenoController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Mobile No',
                            prefixIcon: Icon(Icons.email),
              
                          ),
                        ),
                      ),
              
              
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
              
              
                      ),
                      child:Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: TextField(
                          controller: _ageController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Age',
                            prefixIcon: Icon(Icons.email),
              
                          ),
                        ),
                      ),
              
              
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
              
              
                      ),
                      child:Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
                            prefixIcon: Icon(Icons.email),
              
                          ),
                        ),
                      ),
              
              
                    ),
                  ),
                  SizedBox(height: 10),
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
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
                            prefixIcon:Icon(Icons.security),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
              
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
                          controller: _confirmpasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Confirm Password',
                            prefixIcon:Icon(Icons.security),
                          ),
                        ),
                      ),
                    ),
                  ),
              
                  SizedBox(height: 10.0,),
              
                  Padding(
                    padding:EdgeInsets.symmetric(horizontal: 25.0),
                    child:GestureDetector(
                      onTap: SignUp,
                      child: Container(
                        padding:EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color:Colors.green,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child:Center(
                          child:Text('Sign Up',
                            style:TextStyle(
                              fontWeight:FontWeight.bold,
                              fontSize:18,
                              color:Colors.white,
              
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height:10.0),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    children: [
                      Text(
                        'You are to be our user ',
                        style:TextStyle(
                          color:Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap:widget.showLoginPage,
                        child: Text('Login Now',
                          style:TextStyle(
                            fontWeight: FontWeight.bold,
                            color:Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
              
              
                ],
              ),
            ),
          ),
        ),
      ),
    );;
  }
}
