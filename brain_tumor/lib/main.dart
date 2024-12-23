import 'package:brain_tumor/Screens/Navigators/history.dart';
import 'package:brain_tumor/constant/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Binding/auth_binding.dart';
import 'Screens/Navigators/navigator_screen.dart';
import 'Screens/Registration/email_verification_screen.dart';
import 'Screens/Registration/forgetpasswordscreen.dart';
import 'Screens/Registration/get_start_screen.dart';
import 'Screens/Registration/login_screen.dart';
import 'Screens/Registration/signup_screen.dart';
import 'Screens/Registration/splash_screen.dart';
import 'constant/routes_get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter("BrainTumor");
  await Hive.openBox("history");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: MyText.appName,
      initialBinding: AuthBinding(), // Bind controllers
      initialRoute: Routes.splash, // Start with SplashScreen
      getPages: [
        GetPage(name: Routes.splash, page: () => const SplashScreen()),
        GetPage(name: Routes.login, page: () => LoginScreen()),
        GetPage(name: Routes.signup, page: () => const SignupScreen()),
        GetPage(
            name: Routes.emailVerification,
            page: () => EmailVerificationScreen()),
        GetPage(name: Routes.home, page: () => BrainTumorDetectionScreen()),
        GetPage(name: Routes.getStart, page: () => const GetStartScreen()),
        GetPage(
            name: Routes.forgetPassword, page: () => ForgetPasswordScreen()),
        GetPage(name: Routes.history, page: () => const History()),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}
