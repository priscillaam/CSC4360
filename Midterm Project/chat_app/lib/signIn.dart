import 'package:chat_app/Services/database.dart';
import 'package:chat_app/home.dart';
import 'package:chat_app/register.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Services/firebase_authentication.dart';
import 'helper/helper.dart';

class MySignInPage extends StatefulWidget {
  const MySignInPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MySignInPage> createState() => _MySignInPageState();
}

class _MySignInPageState extends State<MySignInPage> {
  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userID = TextEditingController();
  bool valid = true;
  late FirebaseFirestore fStore;
  bool isLoading = false;
  QuerySnapshot? snapshotUserInfo;

  signIn() {
    if (formKey.currentState!.validate()) {
      HelperFunctions.saveUserNameSharedPreference(_userID.text);

      databaseMethods.gutUserByUserEmail(_emailController.text).then((val) {
        snapshotUserInfo = val;
        HelperFunctions.saveUserNameSharedPreference(
            snapshotUserInfo?.docs[0].get('userID'));
      });

      setState(() {
        isLoading = true;
      });

      authMethods
          .signInWithEmailAndPassword(
              _emailController.text, _passwordController.text)
          .then((val) {
        if (val != null) {
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Home()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text("SIGNUP"),
          Form(
            key: formKey,
            child: Column(children: [
              TextFormField(
                controller: _emailController,
                validator: (val) {
                  return RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(val!)
                      ? null
                      : 'Provide valid email';
                },
                decoration: const InputDecoration(
                  hintText: "Email...",
                ),
              ),
              TextFormField(
                controller: _passwordController,
                validator: (val) {
                  return val!.length > 6 ? null : 'Provide valid password';
                },
                decoration: const InputDecoration(
                  hintText: "Password..",
                ),
              ),
            ]),
          ),
          GestureDetector(
            onTap: () {
              signIn();
            },
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: const Text('Log In'),
            ),
          ),
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
