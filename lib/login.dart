
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase/signup.dart';
import 'package:firebase/list.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();

  Future<void> login() async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (userCredential.user != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ListAdd()),
        );
      } else {
        print("Login failed: User is null");
      }
    } catch (e) {
      print("Exception during login: $e");
    }
  }
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.jpeg"),fit: BoxFit.cover
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login",style: TextStyle(fontSize: 30,color: Colors.black,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
              SizedBox(height: 40,),
              Padding(
                  padding: const EdgeInsets.only(left:15.0,right: 15),
                  child:TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.black),
                      ),
                      hintText: "User Name",
                    ),
                  )
              ),
              SizedBox(height: 20,),
              Padding(
                  padding: const EdgeInsets.only(left:15.0,right: 15),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.black),
                      ),
                      hintText: "Password",
                    ),
                  )
              ),
              SizedBox(height: 20,),
              Align(
                  alignment: Alignment.centerRight,
                  child: Text('forgot password?', style: TextStyle(fontSize: 15,color: Colors.black),)),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left:15.0,right: 15),
                child: ElevatedButton(onPressed: (){
                  login();
                },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black54,minimumSize: const Size.fromHeight(50), //
                    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),

                    ),
                  ),
                  child: const Text('Login', style: TextStyle(fontSize: 15,color: Colors.white),),
                ),
              ),
              SizedBox(height: 10,),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUp()));
                },
                child: const  Text('Create New Account', style: TextStyle(fontSize: 15,color: Colors.black)),
              ),


            ],
          ),
        ),
      ),

    );
  }
}
