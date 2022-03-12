import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByUsername(String userId) async {
    return await FirebaseFirestore.instance
        .collection('Users')
        .where('userID', isGreaterThanOrEqualTo: userId)
        .get();
  }

  gutUserByUserEmail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection('Users')
        .where('Email', isEqualTo: userEmail)
        .get();
  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection('Users').add(userMap);
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addConversationMsgs(String chatRoomId, msgMap) {
    FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(chatRoomId)
        .collection('Chats')
        .add(msgMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getConversationMsgs(String chatRoomId) async {
    // ignore: await_only_futures
    return await FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(chatRoomId)
        .collection('Chats')
        .snapshots();
  }

  getChatRooms(String userId) async {
    return await FirebaseFirestore.instance
        .collection('ChatRoom')
        .where('users', arrayContains: userId)
        .snapshots();
  }
}
