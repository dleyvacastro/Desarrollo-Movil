import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/GameController.dart';
import 'MyHome.dart';

class Game extends StatefulWidget {
  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {

  GameController controller = Get.find();
  final TextEditingController _controller = TextEditingController();

  void showInvalidDialog(context, String message) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 15),
              Text(message),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  Get.offAllNamed('/');
                },
                child: const Text('Volver al inicio'),
              ),
            ],
          ),
        )
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
          appBar: AppBar(
            title: Text(controller.getMode() == '1' ? 'Solitario' : 'Versus'),
          ),
          body: Center(
            child: Column(
              children: [
                Row(
                  children: [
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
                  ]
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Text(
                    'Intentos: ${controller.getTries()}',
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
                Row(
                  children: List.generate(controller.number.length, (index) {
                    setState(() {

                    });
                    return Container(
                      margin: const EdgeInsets.all(10),
                      child: Text(
                        controller.currentGame[index],
                        style: const TextStyle(fontSize: 50),
                      ),
                    );
                  }),
                ),
                TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Ingrese un numero (no digitos repetidos)',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                      var win = controller.validateVersus(_controller.text);

                      if (win) {
                        print('Ganaste');
                        if (controller.startedVersus.value){
                          showInvalidDialog(context, "Ganaste en ${controller.getTries()}");
                        }else{
                          showInvalidDialog(context, "Ganaste en ${controller.getTries()}\nGanador Jugador ${controller.getWinner()}");
                        }
                      }else{
                        setState(() {

                        });
                      }
                  },
                  child: const Text('Probar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.useHint();
                    setState(() {

                    });
                  },
                  child: const Text('HINT'),
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
          )
      );
  }
}
