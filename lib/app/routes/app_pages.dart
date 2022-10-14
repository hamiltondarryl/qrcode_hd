import 'package:get/get.dart';

import '../modules/generateqr/bindings/generateqr_binding.dart';
import '../modules/generateqr/views/generateqr_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/scanner/bindings/scanner_binding.dart';
import '../modules/scanner/views/scanner_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;
  static const SCANNER = Routes.SCANNER;
  static const GENERATEQR = Routes.GENERATEQR;


  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SCANNER,
      page: () =>  ScannerView(),
      binding: ScannerBinding(),
    ),
    GetPage(
      name: _Paths.GENERATEQR,
      page: () => const GenerateqrView(),
      binding: GenerateqrBinding(),
    ),
  ];
}
