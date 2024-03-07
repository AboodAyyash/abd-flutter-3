import 'package:flutter/material.dart';
import 'package:flutter3/shared/shared.dart';

showToast(String data) {
  ScaffoldMessenger.of(navigatorKey.currentState!.context)
      .showSnackBar(SnackBar(
    content: Text(data),
  ));
}
