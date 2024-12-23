import 'package:get/get.dart';

import '../controllers/firebase Auth/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}
