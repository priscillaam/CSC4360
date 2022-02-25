import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpage_app/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminView extends StatefulWidget {
  const AdminView({Key? key}) : super(key: key);

  @override
  _AdminViewState createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  final TextEditingController _messageController = TextEditingController();
  late String codeDialog;
  late String valueText;
  String datetime = DateTime.now().toString();

  Future<void> _displayPopUp(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('TextField in Dialog'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _messageController,
              decoration:
                  const InputDecoration(hintText: "Text Field in Dialog"),
            ),
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
                child: const Text('Post'),
                onPressed: () {
                  addMessage(_messageController.text, datetime);
                  setState(() {
                    codeDialog = valueText;
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin View'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: MaterialButton(
                onPressed: () {
                  _displayPopUp(context);
                },
                color: Colors.blue,
                textColor: Colors.white,
                child: const Icon(
                  Icons.add,
                  size: 24,
                ),
                padding: const EdgeInsets.all(16),
                shape: const CircleBorder(),
              )),
        ]),
      ),
    );
  }
}
