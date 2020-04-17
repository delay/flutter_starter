import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_gravatar/simple_gravatar.dart';
import 'package:flutter_starter/models/models.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  Registering
}
/*
The UI will depends on the Status to decide which screen/action to be done.

- Uninitialized - Checking user is logged or not, the Splash Screen will be shown
- Authenticated - User is authenticated successfully, Home Page will be shown
- Authenticating - Sign In button just been pressed, progress bar will be shown
- Unauthenticated - User is not authenticated, login page will be shown
- Registering - User just pressed registering, progress bar will be shown

Take note, this is just an idea. You can remove or further add more different
status for your UI or widgets to listen.
 */

class AuthProvider extends ChangeNotifier {
  //Firebase Auth object
  FirebaseAuth _auth;

  //Default status
  Status _status = Status.Uninitialized;

  Status get status => _status;

  Stream<FirebaseUserAuthModel> get user =>
      _auth.onAuthStateChanged.map(_userFromFirebase);

  AuthProvider() {
    //initialise object
    _auth = FirebaseAuth.instance;

    //listener for authentication changes such as user sign in and sign out
    _auth.onAuthStateChanged.listen(onAuthStateChanged);
  }

  //Create user object based on the given FirebaseUser
  FirebaseUserAuthModel _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }

    return FirebaseUserAuthModel(
        uid: user.uid,
        email: user.email,
        displayName: user.displayName,
        phoneNumber: user.phoneNumber,
        photoUrl: user.photoUrl);
  }

  //Method to detect live auth changes such as user sign in and sign out
  Future<void> onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _userFromFirebase(firebaseUser);
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  //Method for new user registration using email and password
  Future<FirebaseUserAuthModel> registerWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      _status = Status.Registering;
      notifyListeners();
      final AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      var gravatar = Gravatar(email);
      var gravatarUrl = gravatar.imageUrl(
        size: 200,
        defaultImage: GravatarImage.retro,
        rating: GravatarRating.pg,
        fileExtension: true,
      );
      UserUpdateInfo updateUser = UserUpdateInfo();
      updateUser.displayName = name;
      updateUser.photoUrl = gravatarUrl;
      result.user.updateProfile(updateUser);
      return _userFromFirebase(result.user);
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return null;
    }
  }

  //Method to handle user sign in using email and password
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  //Method to handle password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  //Method to handle user signing out
  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }
}
