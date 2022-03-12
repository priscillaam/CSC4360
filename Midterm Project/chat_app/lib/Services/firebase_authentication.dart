import 'package:chat_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Users? _userFromFirebaseUser(User cuser) {
    // ignore: unnecessary_null_comparison
    return cuser != null ? Users(userID: cuser.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser!);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUpwithInfo(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser!);
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
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}











// Future<bool> register(String email, String password) async {
//   try {
//     await FirebaseAuth.instance
//         .createUserWithEmailAndPassword(email: email, password: password);
//     return true;
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'weak-password') {
//       print('the password is weak');
//       return false;
//     } else if (e.code == 'email-already-in-use') {
//       print('the account exists');
//       return false;
//     }
//     return false;
//   } catch (e) {
//     print(e.toString());
//     return false;
//   }
// }

// Future<bool> signIn(String email, String password) async {
//   try {
//     await FirebaseAuth.instance
//         .signInWithEmailAndPassword(email: email, password: password);
//     return true;
//   } catch (e) {
//     print(e);
//     return false;
//   }
// }
