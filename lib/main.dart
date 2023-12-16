// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:e_market/constants/theme.dart';
import 'package:e_market/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:e_market/provider/app_provider.dart';
import 'package:e_market/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'firebase_helper/firebase_options/firebase_options.dart';
import 'screens/auth_ui/welcome/welcome.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51ONIKBBOekIlBfnz8AUMI1CNPGSOyJjL5l2XNy15nJ2oHFxon0nB7b2SiXnxIVnuEjzY6vSeD2xqlpDYDlCoca6100wDf8mmpW";
  await Firebase.initializeApp(
    options: DefaultFirebaseConfig.platformOptions,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AppProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-MARKET',
        theme: themeData,
        home: StreamBuilder(
            stream: FirebaseAuthHelper.instance.getAuthChange,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return CustomBottomBar();
              }
              return Welcome();
            }),
      ),
    );
  }
}
