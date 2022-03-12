import 'package:chat_app/models/user_model.dart';

class Message {
  final User sender;
  final String time;
  final String text;
  // final bool isLiked;
  // final bool unread;

  Message({required this.sender, required this.time, required this.text});
}

//YOU - current user
final User currentUser = User(
  id: 0,
  name: 'CurrentUser',
  rank: 0,
);

//USERS
final User grant = User(
  id: 1,
  name: 'Grant',
  rank: 5,
);
final User james = User(
  id: 2,
  name: 'James',
  rank: 4,
);
final User john = User(
  id: 3,
  name: 'John',
  rank: 3,
);
final User olivia = User(
  id: 4,
  name: 'Olivia',
  rank: 2,
);
final User sam = User(
  id: 5,
  name: 'Sam',
  rank: 4,
);
final User sophia = User(
  id: 6,
  name: 'Sophia',
  rank: 3,
);
final User steven = User(
  id: 7,
  name: 'Steven',
  rank: 3,
);
List<Message> chats = [
  Message(
    sender: james,
    time: '5:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
  ),
  Message(
    sender: olivia,
    time: '4:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
  ),
  Message(
    sender: john,
    time: '3:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
  ),
  Message(
    sender: sophia,
    time: '2:30 PM',
    text: 'Hey, how\'s it going?',
  ),
  Message(
    sender: steven,
    time: '1:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
  ),
  Message(
    sender: olivia,
    time: '4:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
  ),
  Message(
    sender: john,
    time: '3:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
  ),
  Message(
    sender: sophia,
    time: '2:30 PM',
    text: 'Hey, how\'s it going?',
  ),
  Message(
    sender: steven,
    time: '1:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
  )
];
