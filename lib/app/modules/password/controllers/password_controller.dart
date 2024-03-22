import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/functions.dart';
import '../../../routes/app_pages.dart';

class PasswordController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

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
}
