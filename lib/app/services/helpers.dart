// ignore_for_file: deprecated_member_use

import 'package:url_launcher/url_launcher.dart';

class Helpers {
  
    // pour les sites
  static Future<void> goTowebsite(String website) async {
    if (await canLaunch(website)) {
      await launch(website);
    } else {
      throw "Could not launch $website";
    }
  }
}