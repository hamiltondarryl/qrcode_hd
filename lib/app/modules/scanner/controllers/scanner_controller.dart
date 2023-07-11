// ignore_for_file: avoid_print, unused_local_variable, unrelated_type_equality_checks

import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:qrcode_hd/app/services/helpers.dart';

class ScannerController extends GetxController {
  var isLoading = false.obs;
  var type = ''.obs;
  var libelle = ''.obs;
  var dataResult = ''.obs;
  //var json = <String, dynamic>.obs;

  void scanQrCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Annuler', true, ScanMode.BARCODE);
      var resultat = Helpers.validator(data: qrCode);
      if (int.parse(resultat[2]) != -1) {
        type.value = resultat[0];
        libelle.value = resultat[1];
        dataResult.value = resultat[2];
        isLoading.value = true;
      }
    } on PlatformException {
      Get.snackbar('Erreur', 'Erreur rencontrée pendant le scan.');
    }
  }
}
