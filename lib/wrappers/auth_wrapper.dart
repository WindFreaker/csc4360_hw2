import 'package:firebase_auth/firebase_auth.dart';

class AuthWrapper {

  static String getUserID() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  static bool checkIfSignedIn() {
    return FirebaseAuth.instance.currentUser == null;
  }

  static void signOut() {
    FirebaseAuth.instance.signOut();
  }

  static Future<void> signUp({required email, required password}) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    );
  }

  static Future<void> signIn({required email, required password}) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
    );
  }

}