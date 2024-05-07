import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'forgetpasswordpage.dart';
class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({super.key,required this.showRegisterPage});



  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();

  Future<void> SignIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

    } on FirebaseAuthException catch (e) {

      print(e.code); // For debugging
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('images/doraemon.jpg'),
                ),
                Text(
                  'Welcome to Homifi',
                  style: TextStyle(
                    fontSize: 30.0,
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
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap:(){
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context){
                            return ForgotPasswordPage();
                      },),

                        );
                      },
                        child: Text('Forget Password ?',
                        style:TextStyle(
                          color:Colors.greenAccent,
                          fontWeight: FontWeight.bold,

                        ),),
                      ),
                    ],
                  ),
                ),

                SizedBox(height:10.0),

                Padding(
                  padding:EdgeInsets.symmetric(horizontal: 25.0),
                  child:GestureDetector(
                    onTap: SignIn,
                    child: Container(
                      padding:EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color:Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child:Center(
                        child:Text('Sign In',
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
                      'New User? ',
                      style:TextStyle(
                        color:Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap:widget.showRegisterPage,
                      child: Text('Register Now',
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
    );
  }
}



