// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:e_market/constants/routes.dart';
import 'package:e_market/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:e_market/provider/app_provider.dart';
import 'package:e_market/screens/apropos/apropos.dart';
import 'package:e_market/screens/change_password/change_password.dart';
import 'package:e_market/screens/edit_profile/edit_profile.dart';
import 'package:e_market/screens/favourite_screen/favourite_screen.dart';
import 'package:e_market/widgets/primary_button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Compte",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                appProvider.getUserInformation.image == null
                    ? Icon(
                        Icons.person_outline,
                        size: 120,
                      )
                    : CircleAvatar(
                        backgroundImage:
                            NetworkImage(appProvider.getUserInformation.image!),
                        radius: 60,
                      ),
                Text(
                  appProvider.getUserInformation.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  appProvider.getUserInformation.email,
                ),
                const SizedBox(
                  height: 12.0,
                ),
                SizedBox(
                  width: 180,
                  child: PrimaryButton(
                    title: "Modifier Profil",
                    onPressed: () {
                      Routes.instance
                          .push(widget: EditProfile(), context: context);
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.shopping_bag_outlined, color: Colors.red),
                  title: Text("Vos Commandes"),
                ),
                ListTile(
                  onTap: () {
                    Routes.instance
                        .push(widget: FavouriteScreen(), context: context);
                  },
                  leading: Icon(Icons.favorite_outline, color: Colors.red),
                  title: Text("Vos Favoris"),
                ),
                ListTile(
                  onTap: () {
                    Routes.instance.push(widget: Apropos(), context: context);
                  },
                  leading: Icon(Icons.info_outlined, color: Colors.red),
                  title: Text("A Propos"),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.support_outlined, color: Colors.red),
                  title: Text("Vos Supports"),
                ),
                ListTile(
                  onTap: () {
                    Routes.instance
                        .push(widget: ChangePassword(), context: context);
                  },
                  leading: Icon(Icons.password_outlined, color: Colors.red),
                  title: Text("Changer Mot de Passe"),
                ),
                ListTile(
                  onTap: () {
                    FirebaseAuthHelper.instance.signOut();
                    setState(() {});
                  },
                  leading: Icon(Icons.exit_to_app, color: Colors.red),
                  title: Text(
                    "Déconnexion",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                SizedBox(height: 12.0),
                Text("Version 1.0.0"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
