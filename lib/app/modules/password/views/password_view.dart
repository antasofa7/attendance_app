import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/password_controller.dart';
import 'change_password_widget.dart';
import 'forgot_password_widget.dart';

class PasswordView extends GetView<PasswordController> {
  const PasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${controller.type.name} PasswordView'),
        centerTitle: true,
      ),
      body: controller.type == PasswordType.change
          ? const ChangePasswordWidget()
          : const ForgotPasswordWidget(),
    );
  }
}
