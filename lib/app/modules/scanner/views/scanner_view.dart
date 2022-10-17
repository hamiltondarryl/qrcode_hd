// ignore_for_file: annotate_overrides, avoid_unnecessary_containers, sized_box_for_whitespace, avoid_print, unnecessary_string_interpolations

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_json_viewer/flutter_json_viewer.dart';
import 'package:get/get.dart';
import 'package:qrcode_hd/app/data/images.dart';
import 'package:qrcode_hd/app/services/helpers.dart';
import '../controllers/scanner_controller.dart';

class ScannerView extends GetView<ScannerController> {
  ScannerView({Key? key}) : super(key: key);

  final controller = Get.put(ScannerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          title: const Text('Scanner QR Code'),
        ),
        body: Container(
          padding:
              const EdgeInsets.only(top: 50, left: 30, right: 30, bottom: 50),
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(ImageApp.scanQr, height: 170),
                        Container(
                          width: double.infinity,
                          height: 45,
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
                              controller.scanQrCode();
                            },
                            child: const Text(
                              'Lancer le scan',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                  child: Obx(
                () => Container(
                  child: controller.isLoading.value
                      ? retunedWiget()
                      : const Center(child: Text('Pas de données')),
                ),
              ))
            ],
          ),
        ));
  }

  Widget retunedWiget() {

    // Afiichage JSON
    if (controller.type.value == 'json') {
      return Container(
        child: ListView(
          children: [
            Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                    text: 'Type de données :',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.green)),
                TextSpan(
                  text: ' ${controller.libelle.value}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ],
            ),
            ),
            const SizedBox(height: 20),
             Container(
                width: double.infinity,
                height: 45,
                child: OutlinedButton(
                  style: ButtonStyle(
                      side: MaterialStateProperty.resolveWith<BorderSide>(
                          (states) => const BorderSide(color: Colors.green)),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (states) => Colors.green),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                          (_) {
                        return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20));
                      })),
                  onPressed: () {
                      var json = jsonDecode(controller.dataResult.value) ;
                      Get.bottomSheet(
                        Container(
                           padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
                          height: Get.height / 0.5,
                          child: JsonViewer(json),
                        ),
                        backgroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                  },
                  child: const Text(
                    'Consulter le Json',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
          ]),
      );
    }
    // Affiche URL
    if (controller.type.value == 'url'  || controller.type.value =='ip') {
      return  Container(
      child: ListView(
        children: [
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                    text: 'Type de données :',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.green)),
                TextSpan(
                  text: ' ${controller.libelle.value}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ],
            ),
          ),
         const SizedBox(height: 10),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                    text: 'Données :',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.green)),
                TextSpan(
                  text: " ${controller.dataResult.value.substring(0, 30)} ${  controller.dataResult.value.length > 30 ?'...' :'' }",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
             Container(
                width: double.infinity,
                height: 45,
                child: OutlinedButton(
                  style: ButtonStyle(
                      side: MaterialStateProperty.resolveWith<BorderSide>(
                          (states) => const BorderSide(color: Colors.green)),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (states) => Colors.green),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                          (_) {
                        return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20));
                      })),
                  onPressed: () {
                      Get.bottomSheet(
                        Container(
                          padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
                          height: Get.height / 4,
                          child: Column(
                            children: [
                              const Text('Vous pouvez cliquer sur le lien 😊 ', style:  TextStyle(fontSize: 18),),
                              const SizedBox(height: 20),
                              TextButton(
                                onPressed: (){
                                  Helpers.goTowebsite(controller.dataResult.value);
                                },
                                 child: Text('${controller.dataResult.value}', style: const TextStyle(fontSize: 18),) 
                                 ),
                            ],
                          ),
                        ),
                        backgroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                  },
                  child: const Text(
                    'Consulter l\'url',
                    style:  TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
        ],
      ),
    );
    }

    // Affiche email
    if (controller.type.value == 'email') {
      return  Container(
      child: ListView(
        children: [
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                    text: 'Type de données :',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.green)),
                TextSpan(
                  text: ' ${controller.libelle.value}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ],
            ),
          ),
         const SizedBox(height: 10),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                    text: 'Données :',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.green)),
                TextSpan(
                  text: " ${controller.dataResult.value.substring(0, 30)} ${controller.dataResult.value.length > 30 ?'...' :'' }",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
             Container(
                width: double.infinity,
                height: 45,
                child: OutlinedButton(
                  style: ButtonStyle(
                      side: MaterialStateProperty.resolveWith<BorderSide>(
                          (states) => const BorderSide(color: Colors.green)),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (states) => Colors.green),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                          (_) {
                        return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20));
                      })),
                  onPressed: () {
                      Get.bottomSheet(
                        Container(
                          padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
                          height: Get.height / 4,
                          child: Column(
                            children: [
                              const Text('Vous pouvez cliquer sur l\'email 😊 ', style:  TextStyle(fontSize: 18),),
                              const SizedBox(height: 20),
                              TextButton(
                                onPressed: (){
                                  Helpers.makeEmail(controller.dataResult.value);
                                },
                                 child: Text('${controller.dataResult.value}', style: const TextStyle(fontSize: 18),) 
                                 ),
                            ],
                          ),
                        ),
                        backgroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                  },
                  child: const Text(
                    'Consulter l\'email',
                    style:  TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
        ],
      ),
    );
    }
    
    // Affichage par defaut 
    return Container(
      child: ListView(
        children: [
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                    text: 'Type de données :',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.green)),
                TextSpan(
                  text: ' ${controller.libelle.value}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ],
            ),
          ),
         const SizedBox(height: 10),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                    text: 'Données :',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.green)),
                TextSpan(
                  text: " ${controller.dataResult.value.substring(0, 30)} ${  controller.dataResult.value.length > 30 ?'...' :'' }",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
             Container(
                width: double.infinity,
                height: 45,
                child: OutlinedButton(
                  style: ButtonStyle(
                      side: MaterialStateProperty.resolveWith<BorderSide>(
                          (states) => const BorderSide(color: Colors.green)),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (states) => Colors.green),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                          (_) {
                        return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20));
                      })),
                  onPressed: () {
                      Get.bottomSheet(
                        Container(
                          padding: const EdgeInsets.all(20),
                          height: Get.height / 0.5,
                          child: Text('${controller.dataResult.value}'),
                        ),
                        backgroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                  },
                  child:  Text(
                    'Consulter ${controller.type.value}',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
