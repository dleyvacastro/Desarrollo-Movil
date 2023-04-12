import 'dart:math';
import 'package:get/get.dart';
import 'package:parcial1/ui/pages/SelectNumber.dart';
import '../pages/Game.dart';
import '../pages/MyHome.dart';

class GameController extends GetxController {
  int mode = 3;
  int difficulty = 0;
  String number = "";
  String currentGame = "";
  int cowsScore = 0;
  int bullsScore = 0;
  int triesCount = 0;
  var currPlayer = "A"; // player that gives the number
  var playerAScore = 0.obs;
  var playerBScore = 0.obs;
  var aPrevTries = 0.obs;
  var bPrevTries = 0.obs;
  var startedVersus = false.obs;
  var currentCows = [].obs;
  var hintUsed = false;

  var myhomeReset = (){}.obs;

  void setMode(int value) {
    mode = value;
  }

  void setNumber(String text) {
    number = text;
  }

  void setDifficulty(int value) {
    currentGame = difficulty == 1 ? "***" : difficulty == 2 ? "****" : "*****";
    difficulty = value;
  }

  void setCurrentGame(String text) {
    currentGame = text;
  }

  int getTries(){
    return triesCount;
  }

  String getMode() {
    return mode == 3 ? "Seleccione un modo" : mode == 1 ? "Solitario" : "Versus";
  }

  String getDifficulty() {
    return difficulty == 0 ? "Seleccione una dificultad" : difficulty == 1 ? "Facil" : difficulty == 2 ? "Medio" : "Dificil";
  }

  void validateGame() {
    triesCount = 0;
    setDifficulty(difficulty);
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
    if (userNumber.length > 5 || userNumber.length < 3) {
      valid = false;
    }
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
      var newNumber = rng.nextInt(10);
      while (number.contains(newNumber.toString())) {
        newNumber = rng.nextInt(10);
      }
      number += newNumber.toString();
    }

  }

  void resetGame() {
    number = "";
    currentGame = "";
    cowsScore = 0;
    bullsScore = 0;
    currPlayer = currPlayer == "A" ? "B" : "A";
  }

  String getWinner(){
    if (playerAScore.value > playerBScore.value) {
      return "A";
    } else if (playerAScore.value < playerBScore.value) {
      return "B";
    } else {
      return "Empate";
    }
  }
  bool validateVersus(String userNumber) {
    cowsScore = 0;
    bullsScore = 0;
    if (validateNumber(userNumber)) {
      if (userNumber.length == number.length) {
        for (var i = 0; i < userNumber.length; i++) {
          for (var j = 0; j < userNumber.length; j++) {
            if (i == j) {
              if (userNumber[i] == number[j]) {
                currentGame = currentGame.replaceRange(i, i + 1, userNumber[i]);
                bullsScore++;
              }
            } else {
              if (userNumber[i] == number[j]) {
                cowsScore++;
                if (!currentCows.value.contains(userNumber[i])){
                  currentCows.value.add(userNumber[i]);
                }
              }
            }
          }
        }
        triesCount++;
      } else {
        Get.snackbar("Error", "El numero debe tener ${number.length} digitos");
      }
    } else {
      Get.snackbar("Error", "El numero no puede tener digitos repetidos y debe tener entre 3 y 5 digitos");
    }

    if (bullsScore == number.length) {
      startedVersus.value = startedVersus.value ? false : true;
      print("vs $startedVersus");
      if (currPlayer == "A") {
        bPrevTries.value = triesCount;
      } else {
        aPrevTries.value = triesCount;
      }
      if (startedVersus.value) {
         if (aPrevTries.value < bPrevTries.value) {
           playerAScore.value++;
         } else if (aPrevTries.value > bPrevTries.value) {
           playerBScore.value++;
         } else if (aPrevTries.value == bPrevTries.value) {
           playerAScore.value++;
           playerBScore.value++;
         }
      }
      resetGame();
      myhomeReset.value();
      return true;
    }
    return false;
  }

  void useHint() {
    hintUsed = true;

    for (var i = 0; i < number.length; i++) {
      if (!currentGame.contains(number[i])) {
        currentGame = currentGame.replaceRange(i, i + 1, number[i]);
        triesCount += 5;
        break;
      }
    }
  }


}

