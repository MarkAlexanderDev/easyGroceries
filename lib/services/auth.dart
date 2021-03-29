import 'package:foodz/services/local_storage/consts.dart';
import 'package:foodz/services/local_storage/local_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;

  Future<User> googleSignIn() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential googleCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      final UserCredential result =
          await _auth.signInWithCredential(googleCredential);
      final User firebaseUser = result.user;
      final token = await _auth.currentUser.getIdToken();
      await localStorage.setStringData(SHARED_PREF_KEY_FIREBASE_TOKEN, token);
      return firebaseUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await localStorage.eraseData();
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}

final AuthService authService = AuthService();
