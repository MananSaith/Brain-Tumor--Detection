import 'package:brain_tumor/constant/font_weight.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/colorclass.dart';
import '../../constant/routes_get.dart';
import '../../constant/string_constant.dart';

class GetStartScreen extends StatelessWidget {
  const GetStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyColors.scaffoldBack,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                MyText.logo,
                color: Colors.black,
                width: width * 0.3,
                height: height * 0.18,
              ),
              Text(
                MyText.get1,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 27,
                  fontWeight: MyFontWeight.bold,
                ),
              ),
              SizedBox(
                height: height * 0.025,
              ),
              Text(
                MyText.get2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: MyFontWeight.regular,
                ),
              ),
              SizedBox(
                height: height * 0.06,
              ),
              ElevatedButton(
                  style: TextButton.styleFrom(
                      backgroundColor: MyColors.theme,
                      minimumSize: Size(width * 0.55, height * 0.05)),
                  onPressed: () {
                    Get.offAllNamed(Routes.login);
                  },
                  child: Text(
                    MyText.getStart,
                    style: TextStyle(
                        fontWeight: MyFontWeight.samiBold,
                        fontSize: 18,
                        color: MyColors.black),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
