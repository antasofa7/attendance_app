import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
                ..._textFormField(
                    label: 'NIP',
                    controller: controller.nipController,
                    validator: (value) =>
                        controller.validator('NIP', value ?? '')),
                ..._textFormField(
                    label: 'Name',
                    controller: controller.nameController,
                    validator: (value) =>
                        controller.validator('Name', value ?? '')),
                ..._textFormField(
                    label: 'Email',
                    controller: controller.emailController,
                    marginBottom: 32.0,
                    validator: (value) =>
                        controller.validator('Email', value ?? '')),
                SizedBox(
                  height: 50.0,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        await controller.addEmployee();
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Get.theme.primaryColor),
                          foregroundColor: MaterialStatePropertyAll(
                              Get.theme.colorScheme.onPrimary),
                          fixedSize: const MaterialStatePropertyAll(
                              Size.fromWidth(double.infinity))),
                      child: const Text('Add Employee')),
                )
              ],
            ),
          ),
        ),
      ),
      isDismissible: false,
      backgroundColor: Get.theme.cardColor,
    );
  }

  List<Widget> _textFormField(
      {required TextEditingController controller,
      String? Function(String?)? validator,
      required String label,
      double? marginBottom}) {
    return [
      TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(16.0),
              labelText: label,
              border: const OutlineInputBorder())),
      SizedBox(
        height: marginBottom ?? 20.0,
      ),
    ];
  }
}
