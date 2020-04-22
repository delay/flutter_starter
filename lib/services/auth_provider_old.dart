import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_gravatar/simple_gravatar.dart';
import 'package:flutter_starter/models/models.dart';
import 'package:flutter_starter/services/services.dart';
import 'package:flutter_starter/constants/constants.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  Registering,
  ActionComplete,
}
/*
The UI will depends on the Status to decide which screen/action to be done.

- Uninitialized - Checking user is logged or not, the Splash Screen will be shown
- Authenticated - User is authenticated successfully, Home Page will be shown
- Authenticating - Sign In button just been pressed, progress bar will be shown
- Unauthenticated - User is not authenticated, login page will be shown
- Registering - User just pressed registering, progress bar will be shown
- ActionComplete - User has finished Action (turn off spinner)

Take note, this is just an idea. You can remove or further add more different
status for your UI or widgets to listen.
 */

class AuthProvider extends ChangeNotifier {
  //static String userPath(String uid) => 'users/$uid';

  //final _firestoreService = FirestoreService.instance;
  //Firebase Auth object
  FirebaseAuth _auth;

  //Default status
  Status _status = Status.Uninitialized;

  Status get status => _status;

  Stream<UserModel> get userFirebaseAuthStream =>
      _auth.onAuthStateChanged.map(_userFromFirebaseAuth);

  Future<FirebaseUser> get userFirebaseAuth => _auth.currentUser();

  AuthProvider() {
    //initialise object
    _auth = FirebaseAuth.instance;

    //listener for authentication changes such as user sign in and sign out
    _auth.onAuthStateChanged.listen(onAuthStateChanged);
  }

  //Create user from DB based on the given FirebaseUser
  Future<UserModel> userFirestore(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return userFirestoreStream(uid: user.uid).single;
  }

  //Create user object based on the given FirebaseUser
  UserModel _userFromFirebaseAuth(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return UserModel(uid: user.uid, email: user.email);
  }

  Stream<UserModel> userFirestoreStream({@required String uid}) =>
      User().documentStream;

  //Method to detect live auth changes such as user sign in and sign out
  Future<void> onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _userFromFirebaseAuth(firebaseUser);
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  //Method for new user registration using email and password
  Future<UserModel> registerWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      _status = Status.Registering;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((result) {
        print('uID: ' + result.user.uid);
        print('email: ' + result.user.email);
        //get photo url from gravatar if user has one
        Gravatar gravatar = Gravatar(email);
        String gravatarUrl = gravatar.imageUrl(
          size: 200,
          defaultImage: GravatarImage.retro,
          rating: GravatarRating.pg,
          fileExtension: true,
        );
        UserModel _newUser = UserModel(
            uid: result.user.uid,
            email: result.user.email,
            name: name,
            photoUrl: gravatarUrl);
        _auth.signInWithEmailAndPassword(email: email, password: password);
        User().upsert(_newUser.toJson());
        return userFirestore(result.user);
      });
      _status = Status.Unauthenticated;
      notifyListeners();
      return null;
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

  //handles updating the user when updating profile
  Future<bool> updateUser(
      UserModel user, String oldEmail, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      _auth
          .signInWithEmailAndPassword(email: oldEmail, password: password)
          .then((_firebaseUser) {
        _firebaseUser.user.updateEmail(user.email);
        User().upsert(user.toJson());
        _status = Status.ActionComplete;
        notifyListeners();
        return true;
      });
      _status = Status.ActionComplete;
      notifyListeners();
      return false;
    } catch (e) {
      _status = Status.ActionComplete;
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
