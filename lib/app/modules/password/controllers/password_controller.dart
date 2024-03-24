import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/functions.dart';
import '../../../routes/app_pages.dart';

enum PasswordType { change, forgot }

class PasswordController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  PasswordType type = Get.arguments;

  var isLoading = false.obs;

  Future<void> changePassword() async {
    if (formKey.currentState?.validate() ?? false) {
      if (passwordController.text != 'rahasia1234') {
        try {
          User? currentUser = _auth.currentUser;

          await currentUser?.updatePassword(passwordController.text);

          await _auth.signOut();

          await _auth.signInWithEmailAndPassword(
              email: currentUser?.email ?? '',
              password: passwordController.text);

          Get.offAllNamed(Routes.HOME);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            F.alert(
                title: 'Something went wrong.',
                message: 'The password provided is too weak.');
          }
        } catch (e) {
          F.alert(title: 'Something went wrong', message: e.toString());
        }
      } else {
        F.alert(
            title: 'Something went wrong.',
            message: 'Don\'t use same password!');
      }
    }
  }

  Future<void> resetPassword() async {
    if (formKey.currentState?.validate() ?? false) {
      isLoading(true);
      try {
        await _auth.sendPasswordResetEmail(email: emailController.text);
        F.alert(
            title: 'Success',
            message: 'Reset password has been sent to your email!',
            isError: false);
        Get.back();
      } catch (e) {
        F.alert(title: 'Something went wrong', message: e.toString());
      } finally {
        isLoading(false);
      }
    }
  }
}
