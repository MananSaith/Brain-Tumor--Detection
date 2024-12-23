import 'package:brain_tumor/constant/routes_get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/colorclass.dart';
import '../../constant/font_weight.dart';
import '../../constant/string_constant.dart';
import '../../controllers/firebase Auth/auth_controller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthController authController = Get.find();

  bool check = true;
  final FocusNode emailFocusNode = FocusNode(); // FocusNode for email
  final FocusNode passwordFocusNode = FocusNode(); // FocusNode for password
  final FocusNode confirmFasswordFocusNode =
      FocusNode(); // FocusNode for password

  @override
  void dispose() {
    // Dispose FocusNodes when not needed
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.scaffoldBack,
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: MyColors.scaffoldBack,
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;
          return Column(
            children: [
              // Top-aligned logo
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    MyText.image,
                    height: screenHeight * 0.2,
                  ),
                ],
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
                        MyText.signup,
                        style: TextStyle(
                          color: MyColors.black,
                          fontSize: 17,
                          fontWeight: MyFontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      TextFormField(
                        controller: authController.emailController,
                        focusNode: emailFocusNode, // Add a focus node
                        textInputAction: TextInputAction
                            .next, // Keyboard action set to "Next"
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(
                              passwordFocusNode); // Move to the next field
                        },
                        decoration: InputDecoration(
                          labelText: MyText.email,
                          labelStyle: const TextStyle(color: Colors.black),
                          suffixIcon:
                              const Icon(Icons.email, color: Colors.black),
                          fillColor: MyColors.themeLight,
                          filled: true,
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
                      SizedBox(height: screenHeight * 0.03),
                      TextFormField(
                        controller: authController.passwordController,
                        obscureText: check,
                        focusNode: passwordFocusNode, // Add a focus node
                        textInputAction: TextInputAction
                            .next, // Keyboard action set to "Next"
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(
                              confirmFasswordFocusNode); // Move to the next field
                        },
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
                          fillColor: MyColors.themeLight,
                          filled: true,
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
                            return 'Please enter a password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      TextFormField(
                        controller: authController.confirmPasswordController,
                        obscureText: check,
                        focusNode: confirmFasswordFocusNode,
                        decoration: InputDecoration(
                          labelText: MyText.comfirmPassword,
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
                          fillColor: MyColors.themeLight,
                          filled: true,
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
                            return 'Please confirm your password';
                          } else if (value !=
                              authController.passwordController.text) {
                            return 'Passwords do not match';
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
                                    authController.signup();
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
                                  MyText.signup,
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
                      const SizedBox(height: 10.0),
                      TextButton(
                        onPressed: () {
                          Get.offNamed(Routes.login);
                        },
                        child: Text(
                          MyText.already,
                          style: const TextStyle(color: Colors.black),
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
