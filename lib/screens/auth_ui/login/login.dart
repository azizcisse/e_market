// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously
import 'package:e_market/constants/constants.dart';
import 'package:e_market/constants/routes.dart';
import 'package:e_market/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:e_market/screens/auth_ui/signup/signup.dart';
import 'package:e_market/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:e_market/widgets/primary_button/primary_button.dart';
import 'package:e_market/widgets/top_titles/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isShowPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back_ios_new),
              ),
              TopTitles(
                title: "Se Connecter",
                subtitle: "Bienvenue à sur l'application E-Market",
              ),
              SizedBox(height: 46.0),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  hintText: "example@gmail.com",
                  prefixIcon: Icon(
                    Icons.email_outlined,
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              TextFormField(
                controller: password,
                obscureText: isShowPassword,
                decoration: InputDecoration(
                  hintText: "Mot de passe",
                  prefixIcon: Icon(
                    Icons.password,
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
                    ),
                  ),
                ),
              ),
              SizedBox(height: 36.0),
              PrimaryButton(
                title: "Se Connecter",
                onPressed: () async {
                  bool isValidated = loginValidation(email.text, password.text);
                  if (isValidated) {
                    bool isLogined = await FirebaseAuthHelper.instance
                        .login(email.text, password.text, context);
                    if (isLogined) {
                      Routes.instance.pushAndRemoveUntil(
                          widget: CustomBottomBar(), context: context);
                    }
                  }
                },
              ),
              SizedBox(height: 24.0),
              Center(
                child: Text("Si vous n'avez compte?"),
              ),
              SizedBox(height: 12.0),
              Center(
                child: CupertinoButton(
                  onPressed: () {
                    Routes.instance.push(widget: SignUp(), context: context);
                  },
                  child: Text(
                    "Créer Compte",
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
