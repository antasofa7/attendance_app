import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/methods.dart/methods.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/widgets/widgets.dart';
import '../controllers/profile_controller.dart';

class UpdateProfilePage extends GetView<ProfileController> {
  const UpdateProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Update Profile')),
        body: Form(
          key: controller.formKey,
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Add Employee', style: Get.textTheme.titleLarge),
                  IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.close,
                        color: Get.iconColor,
                      ))
                ],
              ),
              const SizedBox(
                height: 24.0,
              ),
              ...customTextFormField(
                  label: 'NIP',
                  readOnly: true,
                  controller: controller.nipController,
                  validator: (value) => F.validator('NIP', value ?? '')),
              ...customTextFormField(
                  label: 'Email',
                  readOnly: true,
                  controller: controller.emailController,
                  marginBottom: 32.0,
                  validator: (value) => F.validator('Email', value ?? '')),
              ...customTextFormField(
                  label: 'Name',
                  controller: controller.nameController,
                  validator: (value) => F.validator('Name', value ?? '')),
              Obx(() => CustomButton(
                    label: controller.isLoading(true)
                        ? 'Loading...'
                        : 'Update Profile',
                    onPressed: controller.isLoading.isTrue
                        ? null
                        : controller.updateProfile,
                  ))
            ],
          ),
        ));
  }
}
