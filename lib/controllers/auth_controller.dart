import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quizzez/firebase/references.dart';
import 'package:quizzez/screens/screens.dart' show  HomeScreen, LoginScreen;
import 'package:quizzez/utils/utils.dart';
import 'package:quizzez/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  @override
  void onReady() {
    initAuth();
    super.onReady();
  }

  var email=TextEditingController().obs;
  var password=TextEditingController().obs;
  var username=TextEditingController().obs;

  late FirebaseAuth _auth;
  final _user = Rxn<User>();
  late Stream<User?> _authStateChanges;

  void initAuth() async {
    await Future.delayed(const Duration(seconds: 2)); // waiting in splash
    _auth = FirebaseAuth.instance;
    _authStateChanges = _auth.authStateChanges();
    _authStateChanges.listen((User? user) {
      _user.value = user;
    });
    navigateToHome();
  }

  Future<void> signInWithEmail() async {
    // final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      await _auth.createUserWithEmailAndPassword(email: email.value.text,password: password.value.text);
      await saveUser(email.value.text,password.value.text,username.value.text);
      navigateToHome();
    } on Exception catch (error) {
      AppLogger.e(error);
    }
  }

  Future<void> signOut() async {
    AppLogger.d("Sign out");
    try {
      await _auth.signOut();
      navigateToHome();
    } on FirebaseAuthException catch (e) {
      AppLogger.e(e);
    }
  }

  Future<void> saveUser( email,password,username) async {
    userFR
        .doc(email)
        .set({"email" : email, "name": username, "profilepic": ""});
    await _auth.signInWithEmailAndPassword(email: email,password: password);

  }

  User? getUser() {
    _user.value = _auth.currentUser;
    return _user.value;
  }

  bool isLogedIn() {
    return _auth.currentUser != null;
  }

  void navigateToHome() {
    Get.offAllNamed(HomeScreen.routeName);
  }

  void navigateToLogin() {
    Get.toNamed(LoginScreen.routeName);
  }

  // void navigateToHome() {
  //   Get.offAllNamed(HomeScreen.routeName);
  // }

  void showLoginAlertDialog() {
    Get.dialog(
      Dialogs.quizStartDialog(onTap: (){
        Get.back();
        navigateToLogin();
      }),
      barrierDismissible: false,
    );
  }
}
