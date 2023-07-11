// ignore_for_file: unused_local_variable, deprecated_member_use

import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateqrController extends GetxController {
  var qrText = 'Hamilton Darryl'.obs;
  var nameFileDowload = 'Hamilton Darryl'.obs;
  final keyForm = GlobalKey<FormState>();
  TextEditingController inputQr = TextEditingController();

  // Changement de valeur au niveau du champs de saisi
  void changeValue() {
    qrText.value = inputQr.text;
    inputQr.clear();
  }

  // Generation du Qr code
  void generator() async {
    nameFileDowload.value == qrText.value
        ? nameFileDowload.value = 'Hamilton Darryl'
        : null;

    final qrValidationResult = QrValidator.validate(
      data: qrText.value,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );

    // Verification si le QR code a été bien généré
    if (qrValidationResult.status == QrValidationStatus.valid) {
      final qrCode = qrValidationResult.qrCode;

      final painter = QrPainter.withQr(
        qr: qrCode!,
        color: const Color(0xFF000000),
        gapless: true,
        embeddedImageStyle: null,
        embeddedImage: null,
      );

      final tempDir = await getApplicationDocumentsDirectory();
      String tempPath = tempDir.path;
      final ts = DateTime.now().millisecondsSinceEpoch.toString();
      String path = '$tempPath/${qrText.value}-$ts.png';
      nameFileDowload.value = '${qrText.value}-$ts.png';

      final picData =
          await painter.toImageData(2048, format: ui.ImageByteFormat.png);
      await writeToFile(picData!, path);

      final success = await GallerySaver.saveImage(path);

      Get.snackbar(
          'Votre QR code a été généré', 'Le nom du fichier : $nameFileDowload');
    }
  }

  // Ecriture du fichier
  Future<void> writeToFile(ByteData data, String path) async {
    final buffer = data.buffer;
    await File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
}
