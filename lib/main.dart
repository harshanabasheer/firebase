import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase/login.dart';

Future main()async{//sync fun returns the type future
  WidgetsFlutterBinding.ensureInitialized();//to interact with flutter engin
  //we put await infront of async to make lines waiting for future result
  await Firebase.initializeApp();
  runApp(MaterialApp(debugShowCheckedModeBanner: false,
  home: const Login(),));
}

