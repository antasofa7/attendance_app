import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/functions.dart';
import '../../../../core/widgets/widgets.dart';

class EmployeeController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController nipController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController adminPassController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var isLoading = false.obs;
  var isAddEmployeeLoading = false.obs;

  Future<void> addEmployee() async {
    if (adminPassController.text.isEmpty) {
      Get.snackbar('Error', 'Password is required');
      return;
    }
    isAddEmployeeLoading(true);
    try {
      // admin login
      String? adminEmail = _auth.currentUser?.email;
      UserCredential? adminCredential;

      if (adminEmail != null) {
        adminCredential = await _auth.signInWithEmailAndPassword(
            email: adminEmail, password: adminPassController.text);
      }

      if (adminCredential != null) {
        // employee login
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
                email: emailController.text, password: 'rahasia1234');

        User? user = userCredential.user;

        if (user != null) {
          String uid = user.uid;
          // create user
          await _firestore.collection('employee').doc(uid).set({
            'nip': nipController.text,
            'name': nameController.text,
            'email': emailController.text,
            'uid': uid,
            'createdAt': DateTime.now().toIso8601String()
          }).then((_) {
            nipController.text = '';
            nameController.text = '';
            emailController.text = '';
            Get.back();

            // send email verification
            user.sendEmailVerification().then((value) {
              F.alert(
                  title: 'Success',
                  message: 'Please check your email to verification',
                  isError: false);
            });
            _auth.signOut().then((_) => _auth
                    .signInWithEmailAndPassword(
                        email: adminEmail ?? '',
                        password: adminPassController.text)
                    .then((_) {
                  Get.back();
                  Get.back();
                  F.alert(
                      title: 'Success',
                      message: 'Add employee is successful!',
                      isError: false);
                  isAddEmployeeLoading(false);
                }));
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      isAddEmployeeLoading(false);
      if (e.code == 'weak-password') {
        F.alert(
          title: 'Something went wrong.',
          message: 'The password provided is too weak.',
        );
      } else if (e.code == 'email-already-in-use') {
        F.alert(
          title: 'Something went wrong',
          message: 'The account already exist for that email.',
        );
      } else if (e.code == 'wrong-password') {
        F.alert(
            title: 'Something went wrong.',
            message: 'Wrong password provided for that user.');
      }
    } catch (e) {
      isAddEmployeeLoading(false);
      F.alert(
        title: 'Something went wrong',
        message: e.toString(),
      );
    }
  }

  Future<void> checkAdminCredential() async {
    if (formKey.currentState!.validate()) {
      Get.bottomSheet(BottomSheet(
          onClosing: () {
            isLoading(false);
          },
          builder: (_) => Column(children: [
                Text(
                  'Admin Credential',
                  style: Get.textTheme.titleMedium,
                ),
                const SizedBox(height: 24.0),
                Text(
                  'Enter password to check admin credentials!',
                  style: Get.textTheme.bodyMedium,
                ),
                const SizedBox(height: 16.0),
                CustomTextFormField(
                  controller: adminPassController,
                  label: 'Admin Password',
                  validator: (value) => F.validator('Password', value ?? ''),
                ),
                const SizedBox(height: 24.0),
                Obx(() => CustomButton(
                      label: isAddEmployeeLoading(true)
                          ? 'Loading...'
                          : 'Add Employee',
                      onPressed:
                          isAddEmployeeLoading.isTrue ? null : addEmployee,
                    ))
              ])));
    }
  }
}
