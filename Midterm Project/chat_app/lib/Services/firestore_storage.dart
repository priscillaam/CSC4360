import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/Services/firestore_storage.dart';

CollectionReference<dynamic> users =
    FirebaseFirestore.instance.collection('Users');
CollectionReference<dynamic> messages =
    FirebaseFirestore.instance.collection('Messages');

Future<void> addUser(String userFirst, String userLast, String userId,
    String userRole, String datetime) {
  return users
      .add({
        'userFirstName': userFirst,
        'lastName': userLast,
        'userid': userId,
        'role': userRole,
        'dateandtime': datetime
      })
      .then((value) => print('useradded'))
      .catchError((error) => print('failed: $error'));
}
