// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool readOnly;

  const CustomTextFormField(
      {super.key,
      required this.label,
      required this.controller,
      this.validator,
      this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        validator: validator,
        readOnly: readOnly,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(16.0),
            labelText: label,
            border: const OutlineInputBorder()));
  }
}
