import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/methods.dart/methods.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/widgets/widgets.dart';
import '../controllers/employee_controller.dart';

class EmployeeView extends GetView<EmployeeController> {
  const EmployeeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EmployeeView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EmployeeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEmployeeSheet,
        child: const Icon(Icons.person_add_alt),
      ),
    );
  }

  Future<dynamic> _addEmployeeSheet() {
    return Get.bottomSheet(
      Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    controller: controller.nipController,
                    validator: (value) => F.validator('NIP', value ?? '')),
                ...customTextFormField(
                    label: 'Name',
                    controller: controller.nameController,
                    validator: (value) => F.validator('Name', value ?? '')),
                ...customTextFormField(
                    label: 'Email',
                    controller: controller.emailController,
                    marginBottom: 32.0,
                    validator: (value) => F.validator('Email', value ?? '')),
                CustomButton(
                    label: 'Add Employee', onPressed: controller.addEmployee)
              ],
            ),
          ),
        ),
      ),
      isDismissible: false,
      backgroundColor: Get.theme.cardColor,
    );
  }
}
