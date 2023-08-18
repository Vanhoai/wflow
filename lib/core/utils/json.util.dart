import 'dart:convert';

import 'package:flutter/material.dart';

class JsonHelper {
  static Future<dynamic> readJson(AssetBundle rootBundle) async {
    final String response = await rootBundle.loadString('assets/sample.json');
    final data = await json.decode(response);
    return data;
  }
}
