import 'package:brain_tumor/Screens/Navigators/history.dart';
import 'package:brain_tumor/constant/routes_get.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final ImageStorageController imageController =
      Get.put(ImageStorageController());
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
              Get.to(() =>const  History());
            },
            icon: const Icon(Icons.history)),
        title: Text(MyText.appName),
        actions: [
          IconButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  authController.onInit();
                  Get.snackbar("Alert", "you are logout");
                  Get.offAllNamed(Routes.getStart);
                } catch (e) {
                  Get.snackbar("Eroor", "check your internet connect");
                }
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Obx(() {
                  return imageController.image.value != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(
                              20), // Match the container's radius
                          child: Image.file(
                            imageController.image.value!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(
                              20), // Match the container's radius
                          child: Image.asset(
                            'assets/BrainlogoTumor.png',
                            color: Colors.black,
                            height: 30,
                          ),
                        );
                }),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Obx(() {
                return Text(
                  imageController.resultMessage.value,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }),
              SizedBox(
                height: height * 0.04,
              ),
              Container(
                width: width,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: MyColors.theme,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      MyText.line1,
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      MyText.line2,
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.07,
              ),
              ElevatedButton(
                onPressed: () {
                  imageController.galleryCameraFun();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.theme,
                  minimumSize: Size(width / 2, height * 0.05),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 15.0,
                  ),
                ),
                child: Text(
                  MyText.analyze,
                  style: TextStyle(
                    fontWeight: MyFontWeight.samiBold,
                    fontSize: ResponsiveTextSize.getSize(context, 50),
                    color: MyColors.black,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}


// const SizedBox(height: 20),
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     imageController.galleryCameraFun();
//                   },
//                   icon: const Icon(Icons.upload),
//                   label: const Text('Upload'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     foregroundColor: const Color.fromARGB(255, 13, 114, 109),
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 30.0, vertical: 15.0),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                   'Description',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 50),
//                 Obx(() {
//                   return Text(
//                     imageController.resultMessage.value,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   );
//                 }),
