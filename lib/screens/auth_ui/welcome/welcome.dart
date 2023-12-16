// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:e_market/constants/asset_images.dart';
import 'package:e_market/constants/routes.dart';
import 'package:e_market/screens/auth_ui/login/login.dart';
import 'package:e_market/screens/auth_ui/signup/signup.dart';
import 'package:e_market/widgets/primary_button/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../widgets/top_titles/top_titles.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopTitles(
                title: "Salam, E-Market",
                subtitle: "Achetez n'importe quel article avec E-Market",
              ),
              Center(
                child: Image.asset(
                  AssetsImages.instance.salamImage,
                  scale: 1.0,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoButton(
                    onPressed: () {
                      Routes.instance.push(widget: SignUp(), context: context);
                    },
                    padding: EdgeInsets.zero,
                    child: Icon(
                      Icons.facebook,
                      color: Colors.blue,
                      size: 40,
                    ),
                  ),
                  SizedBox(width: 20),
                  CupertinoButton(
                    onPressed: () {
                      Routes.instance.push(widget: SignUp(), context: context);
                    },
                    padding: EdgeInsets.zero,
                    child: Image.asset(
                      AssetsImages.instance.googleLogo,
                      scale: 25.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 35),
              PrimaryButton(
                title: "Se Connecter",
                onPressed: () {
                  Routes.instance.push(widget: Login(), context: context);
                },
              ),
              SizedBox(height: 12),
              PrimaryButton(
                title: "S'Inscrire",
                onPressed: () {
                  Routes.instance.push(widget: SignUp(), context: context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
