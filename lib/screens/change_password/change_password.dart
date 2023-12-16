// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously
import 'package:e_market/constants/constants.dart';
import 'package:e_market/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:e_market/widgets/primary_button/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isShowPassword = true;
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Changement du mot de passe",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          TextFormField(
            controller: newpassword,
            obscureText: isShowPassword,
            decoration: InputDecoration(
              hintText: "Nouveau mot de passe",
              prefixIcon: Icon(
                Icons.password_sharp,
              ),
              suffixIcon: CupertinoButton(
                  onPressed: () {
                    setState(() {
                      isShowPassword = !isShowPassword;
                    });
                  },
                  padding: EdgeInsets.zero,
                  child: Icon(
                    Icons.visibility,
                    color: Colors.grey,
                  )),
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
          TextFormField(
            controller: confirmpassword,
            obscureText: isShowPassword,
            decoration: InputDecoration(
              hintText: "Confirmation du mot de passe",
              prefixIcon: Icon(
                Icons.password_sharp,
              ),
            ),
          ),
          SizedBox(
            height: 36.0,
          ),
          PrimaryButton(
            title: "Enregistrer",
            onPressed: () async {
              if (newpassword.text.isEmpty) {
                showMessage("Le nouveau mot de passe est vide");
              } else if (confirmpassword.text.isEmpty) {
                showMessage("La confirmation du mot de passe est vide");
              } else if (confirmpassword.text == newpassword.text) {
                FirebaseAuthHelper.instance
                    .changePassword(newpassword.text, context);
              } else {
                showMessage("Les deux mot de passe ne sont pas identiques");
              }
            },
          ),
        ],
      ),
    );
  }
}
