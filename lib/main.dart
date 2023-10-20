import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kw_calculator/bindings/main_bindings.dart';
import 'package:kw_calculator/pages/dashboard.dart';
import 'package:kw_calculator/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/dashboard',
      getPages: appRoutes(),
      debugShowCheckedModeBanner: false,
      initialBinding: MainBinding(),
    );
  }
}
