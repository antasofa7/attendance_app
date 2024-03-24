import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/methods.dart/methods.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../routes/app_pages.dart';
import '../../password/controllers/password_controller.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
          children: [
            const SizedBox(
              height: 100.0,
            ),
            Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    ...customTextFormField(
                        label: 'Email',
                        controller: controller.emailController,
                        validator: (value) =>
                            F.validator('Email', value ?? '')),
                    ...customTextFormField(
                        label: 'Password',
                        controller: controller.passwordController,
                        validator: (value) =>
                            F.validator('Password', value ?? ''),
                        marginBottom: 32.0),
                    Obx(() => CustomButton(
                          label: controller.isLoading.isTrue
                              ? 'Loading...'
                              : 'Login',
                          onPressed: controller.isLoading.isTrue
                              ? null
                              : controller.login,
                        )),
                    TextButton(
                        onPressed: () => Get.to(Routes.LOGIN,
                            arguments: PasswordType.forgot),
                        child: const Text('Lupa Password?'))
                  ],
                ))
          ]),
    );
  }
}
