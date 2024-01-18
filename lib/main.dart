import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:kw_calculator/models/house.dart';
import 'package:kw_calculator/models/house_division.dart';
import 'package:kw_calculator/modules/dashboard/dashboard_binding.dart';
import 'package:kw_calculator/routes/routes.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive
    ..init(directory.path)
    ..registerAdapter(HouseDivisionAdapter())
    ..registerAdapter(HouseAdapter());
  await Hive.openBox<House>('hive_box');
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
      initialBinding: DashboardBinding(),
    );
  }
}
