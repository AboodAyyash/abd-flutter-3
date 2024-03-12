import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter3/firebase_options.dart';
import 'package:flutter3/pages/auth/login.dart';
import 'package:flutter3/pages/auth/signup.dart';
import 'package:flutter3/pages/home.dart';
import 'package:flutter3/pages/splash.dart';
import 'package:flutter3/shared/shared.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en', supportedLocales: ['en', 'ar']);
  runApp(LocalizedApp(delegate, MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        localizationDelegate
      ],
      supportedLocales: localizationDelegate.supportedLocales,
      locale: localizationDelegate.currentLocale,
      navigatorKey: navigatorKey,
      home: const SplashPage(),
    );
  }
}
