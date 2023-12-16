// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously
import 'package:e_market/constants/constants.dart';
import 'package:e_market/constants/routes.dart';
import 'package:e_market/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:e_market/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:e_market/widgets/primary_button/primary_button.dart';
import 'package:e_market/widgets/top_titles/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
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
                title: "S'Inscrire",
                subtitle: "Bienvenue à sur l'application E-Market",
              ),
              SizedBox(height: 36.0),
              TextFormField(
                controller: name,
                decoration: InputDecoration(
                  hintText: "Prénom et Nom",
                  prefixIcon: Icon(
                    Icons.person_2_outlined,
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  hintText: "example@gmail.com",
                  prefixIcon: Icon(
                    Icons.email_outlined,
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              TextFormField(
                controller: phone,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "+221 77 xxx xx xx",
                  prefixIcon: Icon(
                    Icons.phone_outlined,
                  ),
                ),
              ),
              SizedBox(height: 12.0),
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
                title: "S'Inscrire",
                onPressed: () async {
                  bool isValidated = signUpValidation(
                    email.text,
                    password.text,
                    name.text,
                    phone.text,
                  );
                  if (isValidated) {
                    bool isLogined = await FirebaseAuthHelper.instance
                        .signUp(name.text, email.text, password.text, context);
                    if (isLogined) {
                      Routes.instance.pushAndRemoveUntil(
                          widget: CustomBottomBar(), context: context);
                    }
                  }
                },
              ),
              SizedBox(height: 24.0),
              Center(
                child: Text("Avez-vous déjà un compte?"),
              ),
              SizedBox(height: 12.0),
              Center(
                child: CupertinoButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Se Connecter",
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
