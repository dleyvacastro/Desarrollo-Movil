
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
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Select Number'),
          ),
          body: Center(
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Ingrese un numero (no digitos repetidos)',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (controller.validateNumber(_controller.text)) {
                      controller.setNumber(_controller.text);
                      Get.to(() => Game());
                    } else {
                      Get.snackbar('Error', 'El numero no puede tener digitos repetidos',
                          snackPosition: SnackPosition.BOTTOM);
                    }
                  },
                  child: const Text('Start Game'),
                ),
              ],
            ),
          )),
    );
  }
}
