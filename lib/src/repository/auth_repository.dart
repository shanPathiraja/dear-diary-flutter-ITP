import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> login(String email, String password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password).then((value) => value.user!);
  }

  Future<void> logout() {
    return _auth.signOut();
  }

  Future<User>getUser() {
    return Future.value(_auth.currentUser!);
  }

  Future<bool> isSignedIn() {
    return Future.value(_auth.currentUser != null);
  }

  Future<UserCredential> register(String email, String password) {
    return _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Stream<String?> get onAuthStateChanged {
    return _auth.authStateChanges().asyncMap((user) => user?.uid);
  }
}