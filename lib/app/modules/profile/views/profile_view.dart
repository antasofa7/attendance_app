import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../password/controllers/password_controller.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ProfileView'),
          centerTitle: true,
        ),
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: controller.streamUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(
                    child: Text('Failed to retrieve user data!'));
              }

              Map<String, dynamic>? userData = snapshot.data?.data();

              return ListView(
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: const ShapeDecoration(shape: CircleBorder()),
                    child: Image.network(
                      'https://ui-avatars.com/api/?name=${userData?['name']}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Text('${userData?['name']}'),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text('${userData?['email']}'),
                  const SizedBox(
                    height: 32.0,
                  ),
                  _itemTile(
                    'Update Profile',
                    icon: Icons.person,
                    onPressed: () =>
                        Get.toNamed(Routes.UPDATE_PROFILE, arguments: userData),
                  ),
                  _itemTile(
                    'Change Password',
                    icon: Icons.key_rounded,
                    onPressed: () => Get.toNamed(Routes.PASSWORD,
                        arguments: PasswordType.change),
                  ),
                  if (userData?['role'] == 'admin')
                    _itemTile(
                      'Add Employee',
                      icon: Icons.person_add_alt_rounded,
                      onPressed: () => Get.toNamed(Routes.EMPLOYEE),
                    ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  _itemTile('Logout',
                      icon: Icons.logout_rounded, onPressed: controller.logout)
                ],
              );
            }));
  }

  ListTile _itemTile(String label,
      {IconData? icon, void Function()? onPressed}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: onPressed,
    );
  }
}
