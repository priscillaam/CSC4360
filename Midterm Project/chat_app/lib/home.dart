// import 'package:chat_app/firebase.dart';
// import 'package:chat_app/home.dart';
import 'package:chat_app/Services/database.dart';
import 'package:chat_app/Services/firebase_authentication.dart';
import 'package:chat_app/helper/constants.dart';
import 'package:chat_app/helper/helper.dart';
import 'package:chat_app/signIn.dart';
import 'package:chat_app/widgets/category_selector.dart';
import 'package:chat_app/widgets/recent_chats.dart';
import 'package:chat_app/widgets/search_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();
  Stream? chatRoomsStream;

  Widget chatRoomList() {
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return ChatRoomTile(
                    snapshot.data.docs[index].get('chatroomid'),
                  );
                })
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = (await HelperFunctions.getUserNameSharedPreference())!;
    databaseMethods.getChatRooms(Constants.myName).then((value) {
      setState(() {
        chatRoomsStream = value;
      });
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
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

      // body: chatRoomList(),
      body: Column(
        children: const <Widget>[
          CategorySelector(),
          SearchBar(),
          RecentChats(),
          // Expanded(
          //   child: Container(
          //     child: Column(
          //       children: <Widget>[
          //         Expanded(
          //           child: chatRoomList(),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
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

class ChatRoomTile extends StatelessWidget {
  final String userId;
  // ignore: use_key_in_widget_constructors
  const ChatRoomTile(this.userId);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(40)),
            child: Text(
              // ignore: unnecessary_string_interpolations
              "${userId.substring(0, 1).toUpperCase()}",
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            userId,
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
