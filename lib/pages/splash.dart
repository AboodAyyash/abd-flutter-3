import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter3/firebase/service.dart';
import 'package:flutter3/pages/auth/login.dart';
import 'package:flutter3/pages/home.dart';
import 'package:flutter3/service/service.dart';
import 'package:flutter3/shared/shared.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    start();
  }

  void start() {
    Timer(Duration(seconds: 1), () {
      getUserId().then((value) {
        print(value);
        if (value == null) {
          Navigator.pushReplacement<void, void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const LoginPage(),
            ),
          );
        } else {
          userId = value;

          getFirebaseDocumentData(collectionName: "users", documentId: userId)
              .then((userValue) {
            userData = userValue;
            print(userData);
            Navigator.pushReplacement<void, void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const MyHomePage(),
              ),
            );
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
