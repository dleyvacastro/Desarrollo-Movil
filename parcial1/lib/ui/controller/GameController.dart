import 'dart:math';

import 'package:get/get.dart';
import 'package:parcial1/ui/pages/SelectNumber.dart';

import '../pages/Game.dart';

class GameController extends GetxController {
  int mode = 3;
  int difficulty = 0;
  String number = "";

  void setMode(int value) {
    mode = value;
  }

  void setNumber(String text) {
    number = text;
  }

  void setDifficulty(int value) {
    difficulty = value;
  }

  String getMode() {
    return mode == 3 ? "Seleccione un modo" : mode == 1 ? "Solitario" : "Versus";
  }

  String getDifficulty() {
    return difficulty == 0 ? "Seleccione una dificultad" : difficulty == 1 ? "Facil" : difficulty == 2 ? "Medio" : "Dificil";
  }

  void validateGame() {
    if (mode == 1) { // solitaio
      if (difficulty == 0) {
        Get.snackbar("Error", "Seleccione una dificultad");
      } else {
        generateNumber();
        print(number);
        Get.to(() => Game());
      }
    } else if (mode == 2) { // versus
      Get.to(() => SelectNumber());
    } else {
      Get.snackbar("Error", "Seleccione un modo");
    }
  }

  bool validateNumber(String userNumber) {
    var valid = true;
    for (var i = 0; i < userNumber.length; i++) {
      for (var j = 0; j < userNumber.length; j++) {
        if (i != j) {
          if (userNumber[i] == userNumber[j]) {
            valid = false;
          }
        }
      }
    }
    return valid;
  }

  void generateNumber() {
    var rng = new Random();
    var itertimes = 0;

    if (difficulty == 1) {
      itertimes = 3;
    } else if (difficulty == 2) {
      itertimes = 4;
    } else if (difficulty == 3) {
      itertimes = 5;
    }
    number = "";

    for (var i = 0; i < itertimes; i++) {
      var newNumber = rng.nextInt(9);
      while (number.contains(newNumber.toString())) {
        newNumber = rng.nextInt(9);
      }
      number += newNumber.toString();
    }

  }



}