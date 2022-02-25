import 'package:fanpage_app/admin_view.dart';
import 'package:fanpage_app/firebase.dart';
import 'package:fanpage_app/home_view.dart';
import 'package:fanpage_app/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool valid = true;
  late FirebaseFirestore fStore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text("SIGNUP"),
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
                child: const Text('Login'),
                onPressed: () async {
                  bool shouldNavigate = await signIn(
                      _emailController.text, _passwordController.text);
                  if (shouldNavigate) {
                    var firebaseUser = FirebaseAuth.instance.currentUser;
                    print(firebaseUser?.uid);
                    if (firebaseUser?.uid == "E2HNbUGQioeDJdr1Jk7FMtkwHqX2") {
                      print("this is an admin");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminView(),
                          ));
                    }
                    if (firebaseUser?.uid != "E2HNbUGQioeDJdr1Jk7FMtkwHqX2") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeView(),
                          ));
                    }
                  }
                },
              )),
          Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: ElevatedButton(
                child: const Text('Register'),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyRegister()),
                  );
                },
              ))
        ]),
      ),
    );
  }
}
