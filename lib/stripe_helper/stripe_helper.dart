// ignore_for_file: use_build_context_synchronously, prefer_const_constructors
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:e_market/constants/constants.dart';
import 'package:e_market/constants/routes.dart';
import 'package:e_market/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:e_market/provider/app_provider.dart';
import 'package:e_market/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

class StripeHelper {
  static StripeHelper instance = StripeHelper();

  Map<String, dynamic>? paymentIntent;
  Future<void> makePayment(String amount, BuildContext context) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'XOF');

      var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: "FRA", currencyCode: "XOF", testEnv: true);

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent![
                      'client_secret'], //Gotten from payment intent
                  style: ThemeMode.light,
                  merchantDisplayName: 'Aziz Cissé',
                  googlePay: gpay))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet(context);
    } catch (err) {
      showMessage(err.toString());
    }
  }

  displayPaymentSheet(BuildContext context) async {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        bool value = await FirebaseFirestoreHelper.instance
            .uploadOrderedProductFirebase(
                appProvider.getBuyProductList, context, "Payé");

        appProvider.clearBuyProduct();
        if (value) {
          Future.delayed( Duration(seconds: 2), () {
            Routes.instance
                .push(widget: CustomBottomBar(), context: context);
          });
        }
      });
    } catch (e) {
      showMessage(e.toString());
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51ONIKBBOekIlBfnzInmHWmgVFRYu7dhS3VdTE67nXMHDao8Lw6XxplY3KwnwtO3PEdCx9J5WMW7D4KFxeBNnCZ4O00WMwFCoqy',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
