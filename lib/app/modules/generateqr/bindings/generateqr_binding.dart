import 'package:get/get.dart';

import '../controllers/generateqr_controller.dart';

class GenerateqrBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenerateqrController>(
      () => GenerateqrController(),
    );
  }
}
