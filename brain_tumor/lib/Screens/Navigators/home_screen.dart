

import 'package:brain_tumor/Screens/Navigators/history.dart';
import 'package:brain_tumor/Screens/Navigators/tumor_detail_screen.dart';
import 'package:brain_tumor/constant/routes_get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/colorclass.dart';
import '../../constant/font_weight.dart';
import '../../constant/string_constant.dart';
import '../../constant/textsize.dart';
import '../../controllers/firebase Auth/auth_controller.dart';
import '../../controllers/imagePacker/image_picker.dart';

class BrainTumorDetectionScreen extends StatelessWidget {
  BrainTumorDetectionScreen({super.key});

  final ImageStorageController imageController = Get.put(ImageStorageController());
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: MyColors.scaffoldBack,
      appBar: AppBar(
        backgroundColor: MyColors.theme,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.to(() => const History());
          },
          icon: const Icon(Icons.history),
        ),
        title: Text(MyText.appName),
        actions: [
          IconButton(
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signOut();
                authController.onInit();
                Get.snackbar("Alert", "You are logged out");
                Get.offAllNamed(Routes.getStart);
              } catch (e) {
                Get.snackbar("Error", "Check your internet connection");
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Container(
                width: double.infinity,
                child: Card(
                  color: Colors.grey.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Image Preview Container
                      Material(
                        elevation: 6,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Obx(() {
                            return imageController.image.value != null
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child:

                              Image.file(
                                imageController.image.value!,
                                fit: BoxFit.cover,
                              ),
                            )
                                : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Icon(CupertinoIcons.photo),

                            );
                          }),
                        ),
                      ),



                      // Result Text
                      Obx(() {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Text(
                              imageController.resultMessage.value,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Suggestions Card
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: MyColors.theme,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, color: Colors.white),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(MyText.line1,
                                style: const TextStyle(color: Colors.white)),
                            Text(MyText.line2,
                                style: const TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Analyze Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      imageController.galleryCameraFun();
                    },
                    icon: const Icon(Icons.photo),
                    label: Text(
                      "Upload",
                      style: TextStyle(
                        fontWeight: MyFontWeight.samiBold,
                        fontSize: ResponsiveTextSize.getSize(context, 50),
                        color: MyColors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 6,
                    ),
                  ),

                  ElevatedButton.icon(
                    onPressed: () {
                      if(imageController.resultConfidence.value>50){
                        Get.to(() => TumorDetailScreen(tumorType: imageController.resultClass.value, confidence: imageController.resultConfidence.value));

                      }
                    },
                    icon: const Icon(Icons.details),
                    label: Text(
                      MyText.analyze,
                      style: TextStyle(
                        fontWeight: MyFontWeight.samiBold,
                        fontSize: ResponsiveTextSize.getSize(context, 50),
                        color: MyColors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.theme,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 6,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
