import 'package:parcial1/ui/controller/GameController.dart';
import 'package:parcial1/ui/pages/MyHome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.lazyPut<GameController>(() => GameController());
  runApp(MyHome());
}
