import 'package:final_crackteck/routes/app_routes.dart';
import 'package:final_crackteck/routes/route_generator.dart';
import 'package:flutter/material.dart';

import 'constants/app_strings.dart';


void main() {
  runApp(const CrackTechApp());
}

class CrackTechApp extends StatelessWidget {
  const CrackTechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.roleSelection,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}