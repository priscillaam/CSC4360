import 'package:chat_app/signIn.dart';
import 'package:flutter/material.dart';

import 'Services/firebase_authentication.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthMethods authMethods = AuthMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: const Text('Chat',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                )),
            elevation: 0.0,
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                iconSize: 30.0,
                color: Colors.white,
                tooltip: 'logout',
                onPressed: () {
                  _displayExitPopUp(context);
                },
              )
            ]),
        body: SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 34),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text('My\nProfile',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.blue, fontSize: 36)),
                      Text('Rating: 5',
                          style: TextStyle(color: Colors.blue, fontSize: 26))
                    ],
                  ),
                ))));
  }

  Future<void> _displayExitPopUp(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Are you sure you want to logout?'),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              ElevatedButton(
                child: const Text('Log Out'),
                onPressed: () {
                  authMethods.signOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MySignInPage(
                                title: '',
                              )));
                },
              ),
            ],
          );
        });
  }
}
