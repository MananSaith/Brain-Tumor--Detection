import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/routes_get.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final usernameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  var check = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    usernameController.clear();
    mobileNumberController.clear();
    super.onInit();
  }

  void login() async {
    check(true);
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Check if email is verified
      User? user = userCredential.user;
      if (user != null && user.emailVerified) {
        check(false);
        Get.offNamed(Routes.home);
      } else {
        check(false);
        await _auth.signOut(); // Sign out the user if not verified
        Get.offAllNamed(Routes.login);
        Get.snackbar("Error", "Email not verified. Please verify your email.");
      }
    } catch (e) {
      check(false);
      Get.snackbar("Error", e.toString());
    }
  }

  void signup() async {
    check(true);
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      await userCredential.user?.sendEmailVerification();
      check(false);
      Get.offNamed(Routes.emailVerification);
    } catch (e) {
      check(false);
      Get.snackbar("Error", e.toString());
    }
    check(false);
  }

  void checkEmailVerification() async {
    User? user = _auth.currentUser;
    await user?.reload();
    if (user != null && user.emailVerified) {
      _saveUserToFirestore(user);
      Get.offAllNamed(Routes.home);
    } else {
      Get.snackbar("Error", "Email not verified yet.");
    }
  }

  void _saveUserToFirestore(User user) async {
    final firestore = FirebaseFirestore.instance;
    await firestore.collection('users').doc(user.uid).set({
      'username': usernameController.text,
      'email': user.email,
      "password": passwordController.text,
      "mobileNumber": mobileNumberController.text,
      "uid": user.uid
    });
  }

  void resetPassword() async {
    if (emailController.text.isEmpty) {
      Get.snackbar("Error", "Please enter your email address.");
      return;
    }

    try {
      await _auth.sendPasswordResetEmail(email: emailController.text);
      Get.snackbar(
        "Success",
        "Password reset email sent. Please check your inbox.",
      );
      Get.offAllNamed(Routes.login);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  bool isLoggedIn() {
    final user = _auth.currentUser;
    if (user != null) {
      return user.emailVerified; // Ensure email is verified
    }
    return false;
  }
}
