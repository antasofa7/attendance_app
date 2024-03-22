import 'package:get/get.dart';

class F {
  F._();

  static String? validator(String label, String value) {
    // if (value.isEmpty || !value.contains('@')) {
    //   return 'Please enter a valid email address.';
    // }
    if (value.isEmpty) {
      return '$label is required!';
    }
    return null;
  }

  static void alert(
      {required String title,
      required String message,
      bool isError = true}) async {
    Get.snackbar(title, message,
        colorText: Get.theme.colorScheme.onPrimaryContainer,
        backgroundColor: isError
            ? Get.theme.colorScheme.error
            : Get.theme.colorScheme.primaryContainer);
  }
}
