import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../core/utils/functions.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nipController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var isLoading = false.obs;

  Map<String, dynamic> userData = Get.arguments;

  @override
  void onReady() {
    nipController.text = userData['nip'];
    nameController.text = userData['name'];
    emailController.text = userData['email'];

    super.onReady();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    isLoading(true);
    String? uid = _auth.currentUser?.uid;

    if (uid != null) {
      yield* _firestore.collection('employee').doc(uid).snapshots();
    }
    isLoading(false);
  }

  Future<void> updateProfile() async {
    if (formKey.currentState?.validate() ?? false) {
      isLoading(true);

      try {
        String uid = Get.arguments['uid'];

        await _firestore
            .collection('employee')
            .doc(uid)
            .update({'name': nameController.text});
        F.alert(title: 'Success', message: 'Update profile successfully!');
      } catch (e) {
        F.alert(
            title: 'Something went wrong', message: 'Update profile failed!');
      } finally {
        isLoading(false);
      }
    }
  }

  Future<void> logout() async {
    isLoading(true);
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut().then((_) => Get.offAllNamed(Routes.LOGIN));
    isLoading(false);
  }
}
