import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController nipController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addEmployee() async {
    if (formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
                email: emailController.text, password: 'rahasia1234');

        String? uid = userCredential.user?.uid;

        if (uid != null) {
          await _firestore.collection('employee').doc(uid).set({
            'nip': nipController.text,
            'name': nameController.text,
            'email': emailController.text,
            'uid': uid,
            'createdAt': DateTime.now().toIso8601String()
          }).then((value) {
            nipController.text = '';
            nameController.text = '';
            emailController.text = '';
            Get.back();
          });
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar(
              'Something went wrong.', 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar('Something went wrong',
              'The account already exist for that email.');
        }
      } catch (e) {
        Get.snackbar('Something went wrong', e.toString());
      }
    }
  }

  String? validator(String label, String value) {
    // if (value.isEmpty || !value.contains('@')) {
    //   return 'Please enter a valid email address.';
    // }
    if (value.isEmpty) {
      return '$label is required!';
    }
    return null;
  }
}
