import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Auth/signup.dart';
import 'firebase_options.dart';
import 'home.dart';

var email;
var userid;
var name;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  SharedPreferences prefs = await SharedPreferences.getInstance();
  email = prefs.getString('email');
  userid = prefs.getString('userid');
  name = prefs.getString('name');

  runApp( MyApp());
}
// main() => runApp(new Expenses());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ExT',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        canvasColor: Colors.white,


      ),
      // home: MapScreen(),
      home: email==null?Signup():Home(),


    );
  }
}



