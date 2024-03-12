import 'package:flutter/material.dart';
import 'package:flutter3/shared/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

showToast(String data) {
  ScaffoldMessenger.of(navigatorKey.currentState!.context)
      .showSnackBar(SnackBar(
    content: Text(data),
  ));
}

setUserId() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('userId', userId);
}

Future getUserId() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString('userId');
}
