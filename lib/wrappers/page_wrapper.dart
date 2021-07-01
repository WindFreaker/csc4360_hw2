import 'package:flutter/material.dart';

class PageWrapper {

  static void addOnTop(BuildContext context, String pageName) {
    Navigator.pushNamed(context, pageName);
  }

  static void addOnTopWithData(BuildContext context, String pageName, Map<String, dynamic> data) {
    Navigator.pushNamed(context, pageName, arguments: data);
  }

  static Map<String, dynamic> getDataFromPrevious(BuildContext context) {
    return ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
  }

  static void replaceEverything(BuildContext context, String pageName) {
    Navigator.pushNamedAndRemoveUntil(context, pageName, (route) => false);
  }

}

// this file is just a simple wrapper for all the Navigator commands I use
// all this does for me is helps me better understand each command and what it does
// this also keeps small bugs from cropping up in individual use cases