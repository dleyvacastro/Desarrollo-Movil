import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/GameController.dart';

class Game extends StatefulWidget {
  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  GameController controller = Get.find();

  void showInvalidDialog(context, String message) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => Dialog(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 15),
                  Text(message, style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () {
                      Get.offAllNamed('/');
                    },
                    child: const Text('Volver al inicio'),
                  ),
                ],
              ),
            ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.gameSetState.value = () {
      setState(() {});
    };
    return Scaffold(
        appBar: AppBar(
          title: Text(controller.getMode() == 'Solitario'
              ? 'Solitario - ${controller.getDifficulty()}'
              : 'Versus - Jugador ${controller.getCurrPlayer() == "A" ? "B" : "A"}'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: ListView(
            children: [
              Row(children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Text(
                    'Puntos: ${controller.cowsScore}',
                    style: const TextStyle(fontSize: 40),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Text(
                    'Famas: ${controller.bullsScore}',
                    style: const TextStyle(fontSize: 40),
                  ),
                ),
              ]),
              Container(
                margin: const EdgeInsets.all(10),
                child: Text(
                  'Intentos: ${controller.getTries()}',
                  style: const TextStyle(fontSize: 30),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(controller.number.length,
                        (index) => controller.numberPicker(context, index))),
              ),
              Container(
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: controller.getCurrTry().contains("*")
                            ? Colors.grey
                            : Theme.of(context).primaryColor),
                    onPressed: () {
                      if (controller.getCurrTry().contains("*")) {
                        return;
                      }
                      var win = controller.gameHandler(controller.getCurrTry());
                      print("Current try: ${controller.getCurrTry()}");
                      print("Current game: ${controller.getCurrenGame()}");
                      if (win) {
                        if (controller.startedVersus.value ||
                            controller.getMode() == 'Solitario') {
                          showInvalidDialog(
                              context, "Ganaste en ${controller.getTries()} intentos.");
                        } else {
                          showInvalidDialog(context,
                              "Ganaste en ${controller.getTries()} intentos.\nGanador Jugador ${controller.getWinner()}");
                        }
                      }
                      setState(() {});
                    },
                    child: const Text('Probar'),
                  )),
              Container(
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    var winHint = controller.useHint();
                    if (winHint) {
                      if (controller.startedVersus.value ||
                          controller.getMode() == 'Solitario') {
                        showInvalidDialog(context,
                            "Ganaste en ${controller.getTries()} intentos.");
                      } else {
                        showInvalidDialog(context,
                            "Ganaste en ${controller.getTries()} intentos\nGanador Jugador ${controller.getWinner()}");
                      }
                    }
                    setState(() {});
                  },
                  child: const Text('PISTA'),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: Text(
                  'Puntos: ${controller.currentCows.value}',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ));
  }
}
