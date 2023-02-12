
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqldatabase/Screen/view/HomeScreen.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {'/': (context) => HomeScreen()},
  ));
}
