// ignore_for_file: unused_local_variable, deprecated_member_use

import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
//import 'package:share_plus/share_plus.dart';

class GenerateqrController extends GetxController {


   var qrText = 'Hamilton Darryl'.obs;
  final keyForm = GlobalKey<FormState>();
  TextEditingController inputQr = TextEditingController();

  void changeValue(){
    qrText.value = inputQr.text;
     inputQr.clear();
  }

   void generator ()async {

    final qrValidationResult = QrValidator.validate(
      data: qrText.value,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );

    if (qrValidationResult.status == QrValidationStatus.valid) {

      final qrCode = qrValidationResult.qrCode;

      final painter = QrPainter.withQr(
        qr: qrCode!,
        color: const Color(0xFF000000),
        gapless: true,
        embeddedImageStyle: null,
        embeddedImage: null,
      );

      final tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      final ts = DateTime.now().millisecondsSinceEpoch.toString();
      String path = '$tempPath/$ts.png';

      final picData = await painter.toImageData(2048, format: ui.ImageByteFormat.png);
      await writeToFile(picData!, path);

      // ignore: unnecessary_string_interpolations
      //Share.shareFiles(['$path']);

      Get.snackbar('Felicitation!!', 'Votre QR code a été générer avec code info : ${qrText.value}');
    }

  }


      Future<void> writeToFile(ByteData data, String path) async {
      final buffer = data.buffer;
      await File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes)
      );
    }

}
