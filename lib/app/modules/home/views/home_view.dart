import 'package:attendance_app/core/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => Get.to(Routes.PROFILE),
              icon: const Icon(Icons.people))
        ],
      ),
      body: Center(
        child: Obx(() => CustomButton(
            label: controller.isLoading.isTrue ? 'Loading...' : 'Logout',
            onPressed: controller.isLoading.isTrue
                ? null
                : () {
                    controller.isLoading(true);
                    FirebaseAuth auth = FirebaseAuth.instance;
                    auth.signOut().then((_) => Get.offAllNamed(Routes.LOGIN));
                    controller.isLoading(false);
                  })),
      ),
    );
  }
}
