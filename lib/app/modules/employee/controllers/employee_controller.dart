import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/functions.dart';

class EmployeeController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController nipController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addEmployee() async {
    if (formKey.currentState!.validate()) {
      try {
        // user login
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
          });
        }
      } on FirebaseAuthException catch (e) {
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
        }
      } catch (e) {
        F.alert(
          title: 'Something went wrong',
          message: e.toString(),
        );
      }
    }
  }
}
