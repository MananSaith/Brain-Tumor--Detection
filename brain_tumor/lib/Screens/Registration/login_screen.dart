import 'package:brain_tumor/constant/colorclass.dart';
import 'package:brain_tumor/constant/font_weight.dart';
import 'package:brain_tumor/constant/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/routes_get.dart';
import '../../controllers/firebase Auth/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.put(AuthController());

  bool check = true;

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    // final  width= MediaQuery.of(context).size.width;
    final formKey = GlobalKey<FormState>();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: MyColors.scaffoldBack,
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;
          return Column(
            children: [
              // Top-aligned logo
              Padding(
                padding: const EdgeInsets.only(top: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      MyText.image1,
                      height: screenHeight * 0.2,
                    ),
                  ],
                ),
              ),

              // Spacer to push the container to the bottom
              const Spacer(),

              // Bottom-aligned replacement widget
              Container(
                height: screenHeight * 0.7,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                decoration: BoxDecoration(
                  color: MyColors.theme,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.025),
                      Text(
                        MyText.login,
                        style: TextStyle(
                          color: MyColors.black,
                          fontSize: 17,
                          fontWeight: MyFontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.025),
                      TextFormField(
                        controller: authController.emailController,
                        decoration: InputDecoration(
                          labelText: MyText.email,
                          labelStyle: const TextStyle(color: Colors.black),
                          filled: true,
                          fillColor: MyColors.themeLight,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0,
                              color: MyColors.themeLight,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30.0)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email address';
                          } else if (!RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: screenHeight * 0.035),
                      TextFormField(
                        controller: authController.passwordController,
                        obscureText: check,
                        decoration: InputDecoration(
                          labelText: MyText.password,
                          labelStyle: const TextStyle(color: Colors.black),
                          suffixIcon: IconButton(
                            icon: Icon(
                              check
                                  ? Icons.remove_red_eye
                                  : Icons
                                      .visibility_off, // Toggle between eye icons
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                check = !check; // Toggle password visibility
                              });
                            },
                          ),
                          filled: true,
                          fillColor: MyColors.themeLight,
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                        ),
                         validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.forgetPassword);
                            },
                            child: Text(
                              MyText.forgetPassword,
                              style: TextStyle(
                                color: MyColors.black,
                                fontSize: 14,
                                fontWeight: MyFontWeight.regular,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.035),
                      Obx(() {
                        return authController.check.value
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    authController.login();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: MyColors.themeLight,
                                  minimumSize:
                                      Size(screenWidth, screenHeight * 0.05),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0,
                                    vertical: 15.0,
                                  ),
                                ),
                                child: Text(
                                  MyText.login,
                                  style: TextStyle(
                                    fontWeight: MyFontWeight.samiBold,
                                    fontSize: 16,
                                    color: MyColors.black,
                                  ),
                                ),
                              );
                      }),
                      SizedBox(height: screenHeight * 0.025),
                      const Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.black,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Or"),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.black,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.signup);
                        },
                        child: Text(
                          MyText.dont,
                          style: TextStyle(
                            color: MyColors.black,
                            fontSize: 15,
                            fontWeight: MyFontWeight.regular,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }));
  }
}
