import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpage_app/home_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fanpage_app/firebase.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _MyRegisterState extends State<MyRegister> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  late String userId;
  late String userFirst;
  late String userLast;
  late String userRole;
  String datetime = DateTime.now().toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("SIGNUP"),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 50,
          ),
          child: TextFormField(
            decoration: const InputDecoration(hintText: 'First Name:'),
            onChanged: (value) {
              userFirst = value;
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 50,
          ),
          child: TextFormField(
            decoration: const InputDecoration(hintText: 'Last Name:'),
            onChanged: (value) {
              userLast = value;
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 50,
          ),
          child: TextFormField(
            decoration: const InputDecoration(hintText: 'Role'),
            onChanged: (value) {
              userRole = value;
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 50,
          ),
          child: TextFormField(
            decoration: const InputDecoration(hintText: 'enter user id'),
            onChanged: (value) {
              userId = value;
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 50,
          ),
          child: TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              hintText: "Email...",
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 50,
          ),
          child: TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              hintText: "Password..",
            ),
          ),
        ),
        Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 50,
            ),
            child: ElevatedButton(
                onPressed: () async {
                  bool shouldNavigate = await register(
                      _emailController.text, _passwordController.text);
                  if (shouldNavigate) {
                    addUser(userFirst, userLast, userRole, userId, datetime);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeView(),
                        ));
                  }
                },
                child: const Text('Register')))
      ]),
    );
  }
}
