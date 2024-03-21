import 'package:flutter/widgets.dart';

import '../widgets/widgets.dart';

List<Widget> customTextFormField(
    {required TextEditingController controller,
    String? Function(String?)? validator,
    required String label,
    double? marginBottom}) {
  return [
    CustomTextFormField(
      label: label,
      controller: controller,
      validator: validator,
    ),
    SizedBox(
      height: marginBottom ?? 20.0,
    ),
  ];
}
