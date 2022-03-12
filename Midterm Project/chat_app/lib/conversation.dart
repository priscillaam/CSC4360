import 'package:chat_app/Services/database.dart';
import 'package:chat_app/helper/constants.dart';
import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;

  // ignore: use_key_in_widget_constructors
  const ConversationScreen({required String this.chatRoomId});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController messageController = TextEditingController();
  Stream? chatMessagesStream;

  @override
  void initState() {
    databaseMethods.getConversationMsgs(widget.chatRoomId).then((val) {
      setState(() {
        chatMessagesStream = val;
      });
    });
    super.initState();
  }

  // ignore: non_constant_identifier_names
  Widget ChatMsgList() {
    return StreamBuilder(
      stream: chatMessagesStream,
      builder: (context, AsyncSnapshot snapshot) {
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            return MessageTile(snapshot.data.docs[index].get('message'),
                snapshot.data.docs[index].get('sendBy') == Constants.myName);
          },
        );
      },
    );
  }

  sendMsg() {
    if (messageController.text.isNotEmpty) {
      Map<String, String> msgMap = {
        'message': messageController.text,
        'sendBy': Constants.myName,
      };
      databaseMethods.addConversationMsgs(widget.chatRoomId, msgMap);
      messageController.text = ' ';
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
          child: Stack(
            children: [
              ChatMsgList(),
              Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: messageController,
                        decoration: const InputDecoration(
                            hintText: 'Message..',
                            hintStyle: TextStyle(color: Colors.blueGrey),
                            border: InputBorder.none),
                      )),
                      GestureDetector(
                        onTap: () {
                          sendMsg();
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
              ),
            ],
          ),
        ));
  }
}

class MessageTile extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MessageTile(this.message, this.isSendByMe);
  final String message;
  final bool isSendByMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xff007EF4), Color(0xff2A75BC)]),
          borderRadius: BorderRadius.circular(23),
        ),
        child: Text(message,
            style: const TextStyle(color: Colors.white, fontSize: 20)),
      ),
    );
  }
}
