import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';

class User {
  User({@required this.uid});
  final String uid;
}

abstract class AuthBase {
  Stream<User> get onAuthStateChanged;
  Future<User> currentUser();
  Future<String> emailFromFirebase();
  //Future<User> signInAnonymously();
  //Future<User> signInWithGoogle();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> createUserWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = firebase_auth.FirebaseAuth.instance;

  // ignore: deprecated_member_use
  User _userFromFirebase(firebase_auth.User user) {
    if (user == null) {
      return null;
    }
    return User(uid: user.uid);
  }

  @override
  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  @override
  Future<User> currentUser() async {
    // ignore: await_only_futures
    final user = await _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }

  Future<String> emailFromFirebase() async {
    // ignore: await_only_futures
    final user = await _firebaseAuth.currentUser;
    return user.email;
  }

  /*@override
  Future<User> signInAnonymously() async
  {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }*/

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  /*Future<User> signInWithGoogle() async
  {
    //GoogleSignIn googleSignIn = GoogleSignIn();
    final googleSignIn = GoogleSignIn();
    //GoogleSignInAccount googleAccount = await googleSignIn.signIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount!=null)
    {
      //GoogleSignInAuthentication googleAuth = await googleAccount.authentication;
      final googleAuth = await googleAccount.authentication;
      if(googleAuth.accessToken != null && googleAuth.idToken!=null)
      {
        final authResult = await _firebaseAuth.signInWithCredential
        (
          GoogleAuthProvider.getCredential
          (
            idToken: googleAuth.idToken, 
            accessToken: googleAuth.accessToken,
          ),
        );
        return _userFromFirebase(authResult.user);
      }
      else
      {
        throw PlatformException
        (
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message : 'Missing Google Authentication',
        );
      }
    }
    else
    {
      throw PlatformException
      (
        code: 'ERROR_ABORTED_BY_USER',
        message : 'Sign in aborted by user',
      );
    }
  }*/
  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

Auth auth = new Auth();
