import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
//import 'package:google_sign_in/google_sign_in.dart';
//import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_gravatar/simple_gravatar.dart';
import 'package:flutter_starter/localizations.dart';
import 'package:flutter_starter/models/models.dart';
import 'package:flutter_starter/ui/auth/auth.dart';
import 'package:flutter_starter/ui/ui.dart';
import 'package:flutter_starter/ui/components/components.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;
  Rx<FirebaseUser> firebaseUser = Rx<FirebaseUser>();
  Rx<UserModel> fireStoreUser = Rx<UserModel>();
  final RxBool admin = false.obs;

  @override
  void onReady() async {
    //run every time auth state changes
    ever(firebaseUser, handleAuthChanged);
    firebaseUser.value = await getUser;
    firebaseUser.bindStream(user);
    super.onInit();
  }

  @override
  void onClose() {
    nameController?.dispose();
    emailController?.dispose();
    passwordController?.dispose();
    super.onClose();
  }

  handleAuthChanged(_firebaseUser) async {
    //get user data from firestore
    if (_firebaseUser?.uid != null) {
      fireStoreUser.bindStream(streamFirestoreUser());
      await isAdmin();
    }

    if (_firebaseUser == null) {
      Get.offAll(SignInUI());
    } else {
      Get.offAll(HomeUI());
    }
  }

  // Firebase user one-time fetch
  Future<FirebaseUser> get getUser => _auth.currentUser();

  // Firebase user a realtime stream
  Stream<FirebaseUser> get user => _auth.onAuthStateChanged;

  //Streams the firestore user from the firestore collection
  Stream<UserModel> streamFirestoreUser() {
    print('streamFirestoreUser()');
    if (firebaseUser?.value?.uid != null) {
      return _db
          .document('/users/${firebaseUser.value.uid}')
          .snapshots()
          .map((snapshot) => UserModel.fromMap(snapshot.data));
    }

    return null;
  }

  //get the firestore user from the firestore collection
  Future<UserModel> getFirestoreUser() {
    if (firebaseUser?.value?.uid != null) {
      return _db
          .document('/users/${firebaseUser.value.uid}')
          .get()
          .then((documentSnapshot) => UserModel.fromMap(documentSnapshot.data));
    }

    return null;
  }

  //Method to handle user sign in using email and password
  signInWithEmailAndPassword(BuildContext context) async {
    final labels = AppLocalizations.of(context);
    showLoadingIndicator();
    try {
      await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      emailController.clear();
      passwordController.clear();
      hideLoadingIndicator();
    } catch (error) {
      hideLoadingIndicator();
      Get.snackbar('labels.auth.signInErrorTitle', labels.auth.signInError,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 15),
          backgroundColor: Colors.black);
    }
  }

  // User registration using email and password
  registerWithEmailAndPassword() async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((result) async {
        print('uID: ' + result.user.uid);
        print('email: ' + result.user.email);
        //get photo url from gravatar if user has one
        Gravatar gravatar = Gravatar(emailController.text);
        String gravatarUrl = gravatar.imageUrl(
          size: 200,
          defaultImage: GravatarImage.retro,
          rating: GravatarRating.pg,
          fileExtension: true,
        );
        //create the new user object
        UserModel _newUser = UserModel(
            uid: result.user.uid,
            email: result.user.email,
            name: nameController.text,
            photoUrl: gravatarUrl);
        //update the user in firestore
        _updateUserFirestore(_newUser, result.user);
      });
    } catch (error) {
      Get.snackbar("Error Creating User", error.message,
          snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 15));
    }
  }

  //handles updating the user when updating profile
  Future<bool> updateUser(
      UserModel user, String oldEmail, String password) async {
    bool _result = false;
    await _auth
        .signInWithEmailAndPassword(email: oldEmail, password: password)
        .then((_firebaseUser) {
      _firebaseUser.user.updateEmail(user.email);
      _updateUserFirestore(user, _firebaseUser.user);
      _result = true;
    });
    return _result;
  }

  //updates the firestore users collection
  void _updateUserFirestore(UserModel user, FirebaseUser firebaseUser) {
    _db
        .document('/users/${firebaseUser.uid}')
        .setData(user.toJson(), merge: true);
  }

  //password reset email
  Future<void> sendPasswordResetEmail(BuildContext context) async {
    final labels = AppLocalizations.of(context);
    try {
      await _auth.sendPasswordResetEmail(email: emailController.text);
      Get.snackbar("Password Reset Email Sent", labels.auth.resetPasswordNotice,
          snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 5));
    } catch (e) {
      Get.snackbar("Password Reset Email Failed", e.message,
          snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 15));
    }
  }

  //check if user is an admin user
  isAdmin() async {
    await getUser.then((user) async {
      DocumentSnapshot adminRef =
          await _db.collection('admin').document(user?.uid).get();
      if (adminRef.exists) {
        admin.value = true;
      } else {
        admin.value = false;
      }
      update();
    });
  }

  // Sign out
  Future<void> signOut() {
    return _auth.signOut();
  }
}

/* Not currently used functions for managing 
google, apple and anonymous signin 
https://github.com/fireship-io/flutter-firebase-quizapp-course


final GoogleSignIn _googleSignIn = GoogleSignIn();
// Determine if Apple Signin is available on device
  Future<bool> get appleSignInAvailable => AppleSignIn.isAvailable();

  /// Sign in with Apple
  Future<FirebaseUser> appleSignIn() async {
    try {
      final AuthorizationResult appleResult =
          await AppleSignIn.performRequests([
        AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);

      if (appleResult.error != null) {
        // handle errors from Apple
      }

      final AuthCredential credential =
          OAuthProvider(providerId: 'apple.com').getCredential(
        accessToken:
            String.fromCharCodes(appleResult.credential.authorizationCode),
        idToken: String.fromCharCodes(appleResult.credential.identityToken),
      );

      AuthResult firebaseResult = await _auth.signInWithCredential(credential);
      FirebaseUser user = firebaseResult.user;

      // Update user data
      updateUserData(user);

      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  /// Sign in with Google
  Future<FirebaseUser> googleSignIn() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      AuthResult result = await _auth.signInWithCredential(credential);
      FirebaseUser user = result.user;

      Gravatar gravatar = Gravatar(user.email);
      String gravatarUrl = gravatar.imageUrl(
        size: 200,
        defaultImage: GravatarImage.retro,
        rating: GravatarRating.pg,
        fileExtension: true,
      );
      UserModel _newUser = UserModel(
          uid: user.uid,
          email: user.email,
          name: user.displayName,
          photoUrl: gravatarUrl);
      // _auth.signInWithEmailAndPassword(email: email, password: password);
      UserData(collection: 'users').upsert(_newUser.toJson());

      // Update user data
      updateUserData(user);

      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  /// Anonymous Firebase login
  Future<FirebaseUser> anonLogin() async {
    AuthResult result = await _auth.signInAnonymously();
    FirebaseUser user = result.user;

    updateUserData(user);
    return user;
  }

    /// Updates the User's data in Firestore on each new login
  Future<void> updateUserData(FirebaseUser user) {
    DocumentReference reportRef = _db.collection('reports').document(user.uid);
    return reportRef.setData({'uid': user.uid, 'lastActivity': DateTime.now()},
        merge: true);
  }
  */
