import 'package:chat_app/Services/database.dart';
import 'package:chat_app/conversation.dart';
import 'package:chat_app/helper/constants.dart';
import 'package:chat_app/helper/helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({Key? key}) : super(key: key);

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController searchController = TextEditingController();
  QuerySnapshot? searchSnapshot;
  @override
  void initState() {
    super.initState();
  }

  initiateSearch() {
    databaseMethods.getUserByUsername(searchController.text).then((val) {
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  // ignore: non_constant_identifier_names
  Widget SearchTile(
      {required String userId, required String fName, required String lName}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fName + ' ' + lName,
              style: const TextStyle(
                fontSize: 28.0,
              ),
            ),
            Text(
              userId,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            createChat(userId: userId);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: const Text('Message',
                style: TextStyle(color: Colors.white, fontSize: 15)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.blue,
            ),
          ),
        ),
      ]),
    );
  }

  Widget searchList(searchSnapshot) {
    // ignore: unnecessary_null_comparison
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SearchTile(
                fName: searchSnapshot.docs[index].data()['First Name'],
                lName: searchSnapshot.docs[index].data()['First Name'],
                userId: searchSnapshot.docs[index].data()["userID"],
              );
            })
        : Container();
  }

  createChat({required String userId}) {
    print("${Constants.myName}");
    if (userId != Constants.myName) {
      List<String> users = [userId, Constants.myName];
      String chatRoomId = getChatRoomId(userId, Constants.myName);
      Map<String, dynamic> chatRoomMap = {
        'users': users,
        'chatroomid': chatRoomId,
      };
      databaseMethods.createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ConversationScreen(chatRoomId: chatRoomId)));
    } else {
      print('cannot do this');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: const Text('Chat',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Container(
        child: Column(children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              children: [
                Container(
                    child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                      hintText: 'Search by username..',
                      hintStyle: TextStyle(color: Colors.blueGrey),
                      border: InputBorder.none),
                )),
                GestureDetector(
                  onTap: () {
                    initiateSearch();
                  },
                  child: Container(
                      height: 40,
                      width: 40,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(40)),
                      child: Image.asset('assets/images/greg.jpg')),
                ),
              ],
            ),
          ),
          searchList(searchSnapshot),
        ]),
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
