import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/GameController.dart';
import 'Game.dart';

class SelectNumber extends StatefulWidget {
  @override
  State<SelectNumber> createState() => _SelectNumberState();
}

class _SelectNumberState extends State<SelectNumber> {
  final TextEditingController _controller = TextEditingController();
  final GameController controller = Get.find();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Elige un Número Jugador ${controller.getCurrPlayer()}'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: TextField(
                controller: _controller,
                // keyboardType: controller.getDifficulty() != "Letal" ?  TextInputType.number : TextInputType.text,
                decoration: const InputDecoration(
                  hintText: 'Ingrese un numero (no digitos repetidos)',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.validateNumber(_controller.text)) {
                  controller.setNumber(_controller.text);
                  controller.setCurrentGame("*" * _controller.text.length);
                  Get.to(() => Game());
                } else {
                  !controller.startedVersus.value
                      ? Get.snackbar('Error',
                          'El numero no puede tener digitos repetidos y debe tener entre 3 y 5 digitos',
                          snackPosition: SnackPosition.BOTTOM)
                      : Get.snackbar('Error',
                          'El numero debe tener ${controller.gameLength.value} digitos');
                }
              },
              child: const Text('Start Game'),
            ),
          ],
        ),
      ),
    );
  }
}
