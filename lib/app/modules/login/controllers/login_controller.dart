import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/functions.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login() async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);

        User? user = userCredential.user;
        if (user != null) {
          if (user.emailVerified) {
            if (passwordController.text == 'rahasia1234') {
              Get.defaultDialog(
                  title: 'Change Password.',
                  middleText: 'Change your current password before login!',
                  actions: [
                    ElevatedButton(
                        onPressed: () => Get.toNamed(Routes.PASSWORD),
                        child: const Text('Change Password'))
                  ]);
            } else {
              Get.offAllNamed(Routes.HOME);
            }
          } else {
            Get.defaultDialog(
                title: 'Unverified Email',
                middleText: 'Please verify your email',
                actions: [
                  OutlinedButton(
                      onPressed: () => Get.back(), child: const Text('Cancel')),
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          await user.sendEmailVerification();
                          F.alert(
                              title: 'Success',
                              message:
                                  'Please check your email to verification',
                              isError: false);
                        } catch (e) {
                          F.alert(
                              title: 'Something went wrong.',
                              message: 'Failed to send verification email.');
                        }
                      },
                      child: const Text('Resend email'))
                ]);
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          F.alert(
              title: 'Something went wrong.',
              message: 'No user found for that email.');
        } else if (e.code == 'wrong-password') {
          F.alert(
              title: 'Something went wrong.',
              message: 'Wrong password provided for that user.');
        }
      } catch (e) {
        F.alert(title: 'Something went wrong', message: e.toString());
      }
    }
  }
}
