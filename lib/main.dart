import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photobackup/view/auth/splash_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'controller/auth_controller.dart';

Future<void> main() async {
  await Supabase.initialize(
      url: "https://sjsylpdwcakwargszvpt.supabase.co",
      anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNqc3lscGR3Y2Frd2FyZ3N6dnB0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTY4MzYyOTQsImV4cCI6MjA3MjQxMjI5NH0.3GSzVuiNfWG02UFA85C2Yw4NIz9bpOg66yneJMJaEOY");
  Get.put(AuthController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
        title: 'Photo Backup',
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
      );
    });
  }
}
