// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_version_checker/flutter_app_version_checker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:qrcode_hd/app/services/helpers.dart';

class HomeController extends GetxController {


 

  var qrText = 'Hamilton Darryl'.obs;
  final keyForm = GlobalKey<FormState>();
  TextEditingController inputQr = TextEditingController();
  DateTime currentBackPressTime = DateTime.now();
    final checker = AppVersionChecker();

  // Changement de valeur
  void changeValue(){
    qrText.value = inputQr.text;
     inputQr.clear();
  }

    // Quitter l'application
   Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Appuyer encore pour quitter');
      return Future.value(false);
    }

    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
    return Future.value(true);
  }

  //Vérifier si l'application a eu une mise à jour
   void checkVersion() async {
    var result = await checker.checkUpdate();
    if (result.canUpdate) {
       Get.dialog(
        AlertDialog(
          title: const Text('Télécharger la mise à jour', style: TextStyle(fontSize: 17),),
          content:  Text('Salut, j\'ose espérer que vous allez bien 😊! Vous pouvez dès maintenant télécharger la nouvelle version. \n De ${result.currentVersion} => ${result.newVersion}', style: const TextStyle(fontSize: 16)),
          actions: [
            TextButton(
              child: const Text("Fermer", style: TextStyle(fontSize: 16)),
              onPressed: () => Get.back(),
            ),
            TextButton(
              child: const Text("Télécharger", style: TextStyle(fontSize: 16)),
              onPressed: (){
                Helpers.goTowebsite('${result.appURL}');
              },
            ),
          ],
        ),
        barrierDismissible: false
      );
    }
      
  }

 @override
  void onInit() {
    super.onInit();
    checkVersion();
  }

}
