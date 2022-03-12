import 'package:chat_app/conversation.dart';
import 'package:chat_app/register.dart';
import 'package:chat_app/signIn.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'helper/helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  bool userIsLoggedIn = false;
  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getuserLoggedInSharedPreference().then((val) {
      setState(() {
        userIsLoggedIn = val!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: userIsLoggedIn ? const MySignInPage(title: 'title') : Blank(),
    );
  }
}

class Blank extends StatelessWidget {
  const Blank({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
