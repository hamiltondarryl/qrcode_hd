// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../services/helpers.dart';
import '../controllers/generateqr_controller.dart';

class GenerateqrView extends GetView<GenerateqrController> {
  const GenerateqrView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text('Générer QR Code'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          width: double.infinity,
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Obx(() => Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: QrImageView(
                      data: controller.qrText.value,
                      size: 250.0,
                    ),
                  )),
              Obx(
                () => Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                          text: 'Le Qr Code correspond à :',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.green)),
                      TextSpan(
                        text: ' ${controller.qrText}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(
                () => controller.nameFileDowload.value == 'Hamilton Darryl'
                    ? const SizedBox.shrink()
                    : Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                                text: 'Nom du fichier en galerie:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.green)),
                            TextSpan(
                              text: ' ${controller.nameFileDowload.value}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
              ),
              Form(
                  key: controller.keyForm,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.inputQr,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Vous n'avez rien entrer";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          hintText: "Veuillez entrer votre expression",
                          hintStyle: TextStyle(
                              color: Colors.grey.shade400, fontSize: 15),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton(
                          style: ButtonStyle(
                              side: MaterialStateProperty
                                  .resolveWith<BorderSide>((states) =>
                                      const BorderSide(color: Colors.green)),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (states) => Colors.green),
                              shape: MaterialStateProperty.resolveWith<
                                  OutlinedBorder>((_) {
                                return RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20));
                              })),
                          onPressed: () {
                            if (controller.keyForm.currentState!.validate()) {
                              controller.changeValue();
                            }
                          },
                          child: const Text(
                            'Générer',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton(
                          style: ButtonStyle(
                              side: MaterialStateProperty
                                  .resolveWith<BorderSide>((states) =>
                                      const BorderSide(color: Colors.green)),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (states) => Colors.white),
                              shape: MaterialStateProperty.resolveWith<
                                  OutlinedBorder>((_) {
                                return RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20));
                              })),
                          onPressed: () {
                            controller.generator();
                          },
                          child: const Text(
                            'Télécharger QR Code',
                            style: TextStyle(color: Colors.green, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  )),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                      onPressed: () {
                        Helpers.goTowebsite(
                            'https://hamiltondarryl.github.io/me/');
                      },
                      child: const Text(
                        "Réalisé par Hamilton Darryl (Développeur fullstack)",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black54),
                      ))),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
