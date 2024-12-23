import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/colorclass.dart';
import '../../controllers/firebase Auth/auth_controller.dart';

class EmailVerificationScreen extends StatelessWidget {
  EmailVerificationScreen({super.key});
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.theme, // Assuming greenish theme
      body: Center(
        child: SingleChildScrollView(
          // Allow content to scroll on smaller screens
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center text horizontally
            children: [
              // Animated checkmark (optional):
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                child: const Icon(
                  Icons.check_circle_outline,
                  size: 100,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                "Check your email for verification.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () => authController.checkEmailVerification(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: MyColors.theme,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text("Click Verification"),
              ),
              const SizedBox(height: 10.0),
              const Text(
                "Didn't receive an email? Check your spam folder or request a new one.",
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
