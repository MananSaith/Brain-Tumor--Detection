import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/colorclass.dart';
import '../../constant/font_weight.dart';
import '../../controllers/firebase Auth/auth_controller.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      backgroundColor: MyColors.scaffoldBack,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Reset Password",
                        style: TextStyle(
                          color: MyColors.black,
                          fontSize: screenWidth * 0.06,
                          fontWeight: MyFontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      TextFormField(
                        controller: authController.emailController,
                        decoration: InputDecoration(
                          labelText: "Enter your email",
                          filled: true,
                          fillColor: MyColors.themeLight,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your email";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Obx(() {
                        return authController.check.value
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    authController.resetPassword();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: MyColors.themeLight,
                                  minimumSize: Size(
                                      screenWidth * 0.8, screenHeight * 0.06),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text(
                                  "Send Reset Link",
                                  style: TextStyle(
                                    color: MyColors.black,
                                    fontWeight: MyFontWeight.bold,
                                  ),
                                ),
                              );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
