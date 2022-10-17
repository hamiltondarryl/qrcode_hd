// ignore_for_file: deprecated_member_use, unused_local_variable, avoid_print

import 'package:string_validator/string_validator.dart';
import 'package:url_launcher/url_launcher.dart';

/* 
    Classe pour la gestion des actions
 */
class Helpers {

  // Methode pour accéder à un site 
  static Future<void> goTowebsite(String website) async {
    if (await canLaunch(website)) {
      await launch(website);
    } else {
      throw "Could not launch $website";
    }
  }

  // Methode pour envoyer un mail
  static Future<void> makeEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launch(launchUri.toString());
  }

  // Methode pour valider la data provenant du Scanner de QR code
  static List validator({String? data}) {

    if (isJson(data!)) {
      return ['json', 'Données en json', data];
    }

    if (isEmail(data)) {
      return ['email', 'Une adresse email', data];
    }

    if (isURL(data)) {
      return ['url', 'Une url', data];
    }

    if (isIP(data)) {
      return ['ip', 'Une IP', data];
    }

    return ['string', 'Chaine de caratére', data];
  }
}
