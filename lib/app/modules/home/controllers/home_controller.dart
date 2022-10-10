import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  var qrText = 'Hamilton Darryl'.obs;
  final keyForm = GlobalKey<FormState>();
  TextEditingController inputQr = TextEditingController();

  void changeValue(){
    qrText.value = inputQr.text;
     inputQr.clear();
  }

}
