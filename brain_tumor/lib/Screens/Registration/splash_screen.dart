import 'package:brain_tumor/constant/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/colorclass.dart';
import '../../constant/routes_get.dart';
import '../../controllers/firebase Auth/auth_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Future.delayed(const Duration(seconds: 2), () {
      final isLoggedIn = Get.find<AuthController>().isLoggedIn();
      Get.offNamed(isLoggedIn ? Routes.home : Routes.getStart);
    });

    return Scaffold(
      backgroundColor: MyColors.scaffoldBack,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              MyText.logo,
              color: Colors.black,
              width: width * 0.3,
              height: height * 0.18,
            ),
            Text(
              MyText.appName,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              MyText.app1,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
