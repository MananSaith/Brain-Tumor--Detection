import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

import '../../constant/string_constant.dart'; // Import MediaType here

class ImageStorageController extends GetxController {
  Rx<File?> image = Rx<File?>(null);
  final picker = ImagePicker();
  XFile? pickFile;
  RxString resultMessage = MyText.result.obs;

  void galleryCameraFun() {
    Get.bottomSheet(
      backgroundColor: const Color.fromARGB(115, 245, 245, 245),
      SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(
                Icons.image,
                size: 50,
              ),
              onPressed: () {
                galleryImage();
                Get.back();
              },
            ),
            const SizedBox(width: 60),
            IconButton(
              icon: const Icon(
                Icons.camera_alt,
                size: 50,
              ),
              onPressed: () {
                cameraImage();
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future galleryImage() async {
    try {
      pickFile =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 90);
      if (pickFile != null) {
        image.value = File(pickFile!.path);
        Uint8List byte = await pickFile!.readAsBytes();
        _uploadImage(byte);
      }
    } catch (e) {
      Get.snackbar('Error', 'Issue selecting image from gallery',
          snackPosition: SnackPosition.TOP);
    }
  }

  Future cameraImage() async {
    try {
      pickFile =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 90);
      if (pickFile != null) {
        image.value = File(pickFile!.path);
        Uint8List byte = await pickFile!.readAsBytes();
        _uploadImage(byte);
      }
    } catch (e) {
      Get.snackbar('Error', 'Issue taking image with camera',
          snackPosition: SnackPosition.TOP);
    }
  }

  Future<void> _uploadImage(Uint8List byte) async {
    if (image.value == null) return;
    try {
      final uri = Uri.parse(MyText.basicUrl);
      var request = http.MultipartRequest('POST', uri);

      // Add file as bytes
      request.files.add(http.MultipartFile.fromBytes(
        'file',
        byte,
        filename: image.value!.path.split('/').last,
        contentType: MediaType('image', 'jpeg'),
      ));
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await http.Response.fromStream(response);
        final jsonResponse = jsonDecode(responseData.body);
        resultMessage.value =
            'Prediction: ${jsonResponse['class']}\n Confidence:${((jsonResponse['confidence'] as double) * 100).toStringAsFixed(2)}%';
        // this will store data into data into local data
        final box = Hive.box("history");
        final key = DateTime.now().microsecondsSinceEpoch.toString();
        box.put(key, {
          "class": "${jsonResponse['class']}",
          "confidence":
              "Confidence:${((jsonResponse['confidence'] as double) * 100).toStringAsFixed(2)}%",
          "time": DateTime.now(),
          "image": byte,
        });
      } else {
        resultMessage.value =
            'Failed to upload image (Code: ${response.statusCode})';
      }
    } catch (e) {
      resultMessage.value = 'Failed to connect with server';
    }
  }
}
