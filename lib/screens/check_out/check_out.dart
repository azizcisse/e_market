// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:e_market/constants/routes.dart';
import 'package:e_market/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:e_market/models/products_models/products_models.dart';
import 'package:e_market/provider/app_provider.dart';
import 'package:e_market/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:e_market/widgets/primary_button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget {
  final ProductModel singleProduct;
  const CheckOut({super.key, required this.singleProduct});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  int groupValue = 1;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Vérification Achat",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(height: 36.0),
            Container(
              height: 90,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 3.0,
                ),
              ),
              child: Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  Icon(Icons.money),
                  SizedBox(width: 12.0),
                  Text(
                    "Paiement à la livraison",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0),
            Container(
              height: 90,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 3.0,
                ),
              ),
              child: Row(
                children: [
                  Radio(
                    value: 2,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  Icon(Icons.money),
                  SizedBox(width: 12.0),
                  Text(
                    "Paiement en ligne",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 36.0),
            PrimaryButton(
              title: "Confirmer",
              onPressed: () async {
                appProvider.clearBuyProduct();
                appProvider.addBuyProduct(widget.singleProduct);

                bool value = await FirebaseFirestoreHelper.instance
                    .uploadOrderedProductFirebase(
                  appProvider.getBuyProductList,
                  context,
                  groupValue == 1
                      ? "Paiement à la livraison"
                      : "Paiement en ligne",
                );
                if (value) {
                  Future.delayed(
                      Duration(
                        seconds: 2,
                      ), () {
                    Routes.instance
                        .push(widget: CustomBottomBar(), context: context);
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
