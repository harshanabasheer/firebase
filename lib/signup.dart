import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase/login.dart';
import 'package:firebase/list.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  Future<void> SignIn() async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
              Text("SignUp",style: TextStyle(fontSize: 30,color: Colors.black,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
              SizedBox(height: 40,),
              Padding(
                  padding: const EdgeInsets.only(left:15.0,right: 15),
                  child: // Note: Same code is applied for the TextFormField as well
                  TextFormField(
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
                  child: // Note: Same code is applied for the TextFormField as well
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.black),
                      ),
                      hintText: "Password",
                    ),
                  )
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left:15.0,right: 15),
                child: ElevatedButton(onPressed: (){
                  SignIn();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black54,minimumSize: const Size.fromHeight(50), //
                    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),

                    ),
                  ),
                  child: const Text('SignUp', style: TextStyle(fontSize: 15,color: Colors.white),),
                ),
              ),
              SizedBox(height: 10,),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                },
                child: const  Text('Already have Account?', style: TextStyle(fontSize: 15,color: Colors.black)),
              ),


            ],
          ),
        ),
      ),

    );
  }
}
