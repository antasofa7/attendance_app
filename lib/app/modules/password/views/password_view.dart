import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/methods.dart/methods.dart';
import '../../../../core/widgets/widgets.dart';
import '../controllers/password_controller.dart';

class PasswordView extends GetView<PasswordController> {
  const PasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PasswordView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...customTextFormField(
                  controller: controller.passwordController,
                  label: 'New Password'),
              CustomButton(
                  label: 'Change Password',
                  onPressed: controller.changePassword)
            ],
          ),
        ),
      ),
    );
  }
}
