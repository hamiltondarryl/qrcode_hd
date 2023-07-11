// ignore_for_file: annotate_overrides, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrcode_hd/app/data/images.dart';
import 'package:qrcode_hd/app/services/helpers.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          width: double.infinity,
          padding:
              const EdgeInsets.only(top: 50, left: 30, right: 30, bottom: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(ImageApp.qrImage, height: 170),
              const SizedBox(
                height: 70,
              ),
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
                  onPressed: () => Get.toNamed(AppPages.GENERATEQR),
                  child: const Text(
                    'Générer et télécharger QR Code',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                height: 45,
                child: OutlinedButton(
                  style: ButtonStyle(
                      side: MaterialStateProperty.resolveWith<BorderSide>(
                          (states) => const BorderSide(color: Colors.green)),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (states) => Colors.white),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                          (_) {
                        return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20));
                      })),
                  onPressed: () => Get.toNamed(AppPages.SCANNER),
                  child: const Text(
                    'Scanner QR Code',
                    style: TextStyle(color: Colors.green, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 40),
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
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
