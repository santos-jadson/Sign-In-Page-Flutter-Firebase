import 'package:basic_login_page/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ModelUser _firebaseUser(User user) {
    return user != null ? ModelUser(id: user.uid) : null;
  }


  Stream<ModelUser> get user {
    return _auth.authStateChanges()
    //.map((User user) => _firebaseUser(user));
    .map(_firebaseUser);
  }


  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _firebaseUser(user);

    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _firebaseUser(user);
    }catch(e) {
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _firebaseUser(user);
    }catch(e) {
      print(e.toString());
      return null;
    }
  }


  Future signOut() async {
    try {
      return await _auth.signOut();
    }catch(e) {
      print(e.toString());
      return null;
    }
  }
}