import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class ExtensionsUtils {
  static showSnackBar(BuildContext context, String data) {
    var snackBar = SnackBar(content: Text(data));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static makeCall(String number) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: number,
    );
    await launchUrl(launchUri);

  }

  static bool isNumberValid(String data) {
    data = data.trim();
    if (data.isNotEmpty && data.length != 10) {
      return false;
    }
    try {
      int num = int.parse(data);
      // 12343
      int firstDigit = (num / 1000000) as int;
      if (firstDigit == 6 ||
          firstDigit == 7 ||
          firstDigit == 8 ||
          firstDigit == 9) {
        return true;
      }
    } catch (_) {}
    return false;
  }

}
