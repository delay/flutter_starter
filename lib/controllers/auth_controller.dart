import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_gravatar/simple_gravatar.dart';
import 'package:flutter_starter/localizations.dart';
import 'package:flutter_starter/models/models.dart';
import 'package:flutter_starter/ui/auth/auth.dart';
import 'package:flutter_starter/ui/ui.dart';
import 'package:flutter_starter/ui/components/components.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();
  AppLocalizations_Labels labels;
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
  signInWithEmailAndPassword() async {
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
      Get.snackbar(labels.auth.signInErrorTitle, labels.auth.signInError,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 7),
          backgroundColor: Colors.black,
          colorText: Colors.white);
    }
  }

  // User registration using email and password
  registerWithEmailAndPassword() async {
    showLoadingIndicator();
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
        emailController.clear();
        passwordController.clear();
        hideLoadingIndicator();
      });
    } catch (error) {
      hideLoadingIndicator();
      Get.snackbar(labels.auth.signUpErrorTitle, error.message,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Colors.black,
          colorText: Colors.white);
    }
  }

  //handles updating the user when updating profile
  Future<void> updateUser(
      UserModel user, String oldEmail, String password) async {
    try {
      showLoadingIndicator();
      await _auth
          .signInWithEmailAndPassword(email: oldEmail, password: password)
          .then((_firebaseUser) {
        _firebaseUser.user
            .updateEmail(user.email)
            .then((value) => _updateUserFirestore(user, _firebaseUser.user));
      });
      hideLoadingIndicator();
      Get.snackbar(labels.auth.updateUserSuccessNoticeTitle,
          labels.auth.updateUserSuccessNotice,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 5),
          backgroundColor: Colors.black,
          colorText: Colors.white);
    } on PlatformException catch (error) {
      //List<String> errors = error.toString().split(',');
      // print("Error: " + errors[1]);
      hideLoadingIndicator();
      print(error.code);
      String authError;
      switch (error.code) {
        case 'ERROR_WRONG_PASSWORD':
          authError = labels.auth.wrongPasswordNotice;
          break;
        default:
          authError = labels.auth.unknownError;
          break;
      }
      Get.snackbar(labels.auth.wrongPasswordNoticeTitle, authError,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Colors.black,
          colorText: Colors.white);
    }
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
    showLoadingIndicator();
    try {
      await _auth.sendPasswordResetEmail(email: emailController.text);
      hideLoadingIndicator();
      Get.snackbar(
          labels.auth.resetPasswordNoticeTitle, labels.auth.resetPasswordNotice,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 5),
          backgroundColor: Colors.black,
          colorText: Colors.white);
    } catch (error) {
      hideLoadingIndicator();
      Get.snackbar(labels.auth.resetPasswordFailed, error.message,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Colors.black,
          colorText: Colors.white);
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
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    return _auth.signOut();
  }
}
