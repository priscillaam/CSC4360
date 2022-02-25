import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

CollectionReference<dynamic> users =
    FirebaseFirestore.instance.collection('Users');
CollectionReference<dynamic> messages =
    FirebaseFirestore.instance.collection('Messages');
Future<bool> register(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('the password is weak');
      return false;
    } else if (e.code == 'email-already-in-use') {
      print('the account exists');
      return false;
    }
    return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

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

Future<void> addMessage(String message, String datetime) async {
  return messages
      .add({'message': message, 'datetime': datetime})
      .then((value) => print('message added'))
      .catchError((error) => print('failed: $error'));
}

class CMethods {
  getMessage() async {
    return messages;
  }
}
