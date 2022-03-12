import 'package:chat_app/Services/database.dart';
import 'package:chat_app/helper/helper.dart';
import 'package:chat_app/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Services/firebase_authentication.dart';
import 'Services/firestore_storage.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _MyRegisterState extends State<MyRegister> {
  bool isLoading = false;
  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _userID = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  late String userRole;
  String datetime = DateTime.now().toString();

  registerUser() {
    if (formKey.currentState!.validate()) {
      Map<String, String> userInfoMaps = {
        'First Name': _firstNameController.text,
        'Last Name': _lastNameController.text,
        'userID': _userID.text,
        'Email': _emailController.text
      };

      HelperFunctions.saveUserNameSharedPreference(_userID.text);
      HelperFunctions.saveUserEmailSharedPreference(_emailController.text);

      setState(() {
        isLoading = true;
      });

      authMethods
          .signUpwithInfo(_emailController.text, _passwordController.text)
          .then((val) {
        print('${val.userID}');

        // ignore: unused_local_variable

        databaseMethods.uploadUserInfo(userInfoMaps);
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: isLoading
            ? Container(
                child: const Center(child: CircularProgressIndicator()),
              )
            : SingleChildScrollView(
                child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _firstNameController,
                              decoration: const InputDecoration(
                                  hintText: 'First Name:'),
                            ),
                            TextFormField(
                              controller: _lastNameController,
                              decoration:
                                  const InputDecoration(hintText: 'Last Name:'),
                            ),
                            TextFormField(
                              decoration:
                                  const InputDecoration(hintText: 'Role'),
                              onChanged: (value) {
                                userRole = value;
                              },
                            ),
                            TextFormField(
                              validator: (val) {
                                return val!.isEmpty || val.length < 2
                                    ? 'Incorrect'
                                    : null;
                              },
                              controller: _userID,
                              decoration: const InputDecoration(
                                  hintText: 'enter user id'),
                            ),
                            TextFormField(
                              validator: (val) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(val!)
                                    ? null
                                    : 'Provide valid email';
                              },
                              controller: _emailController,
                              decoration: const InputDecoration(
                                hintText: "Email...",
                              ),
                            ),
                            TextFormField(
                              validator: (val) {
                                return val!.length > 6
                                    ? null
                                    : 'Provide valid password';
                              },
                              controller: _passwordController,
                              decoration: const InputDecoration(
                                hintText: "Password..",
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          registerUser();
                        },
                        child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(30)),
                            child: const Text('Register',
                                style: TextStyle(color: Colors.white))),
                      ),
                    ]),
              )));
  }

  void uploadUserInfo() {}
}
