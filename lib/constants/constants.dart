// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 20.0,
  );
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Builder(builder: (context) {
      return SizedBox(
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: Color(0xffe16555),
            ),
            SizedBox(
              height: 18.0,
            ),
            Container(
              margin: EdgeInsets.only(left: 7),
              child: Text("Chargement..."),
            ),
          ],
        ),
      );
    }),
  );

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

String getMessageFromErrorCode(String errorCode) {
  switch (errorCode) {
    case "ERREUR_EMAIL_DÉJÀ_UTILISÉ":
      return "Adresse E-Mail déjà utilisée. Accédez à la page de connexion.";
    case "Le compte existe avec des identifiants différents":
      return "Adresse e-Mail déjà utilisée. Accédez à la page de connexion.";
    case "Email déjà utilisé":
      return "Adresse E-Mail déjà utilisée. Accédez à la page de connexion.";
    case "ERREUR_MOT_DE_PASSE_INCORRECT":
    case "Mot de passe incorrect":
      return "Mot de passe incorrect";
    case "ERREUR_UTILISATEUR_INTROUVABLE":
      return "Aucun utilisateur trouvé avec cet email.";
    case "Utilisateur non trouvé":
      return "aucun utilisateur trouvé avec cet email.";
    case "ERREUR_UTILISATEUR_DÉSACTIVÉ":
      return "Utilisateur désactivé.";
    case "utilisateur désactivé":
      return "Utilisateur désactivé.";
    case "ERREUR_TROP_DE_DEMANDES":
      return "Trop de demandes pour se connecter à ce compte.";
    case "Opération non autorisée":
      return "Trop de demandes pour se connecter à ce compte.";
    case "FONCTIONNEMENT_PAR_ERREUR_NON_AUTORISÉ":
      return "Trop de demandes pour se connecter à ce compte.";
    case "ERREUR_EMAIL_INVALIDE":
      return "Adresse email invalide.";
    case "Email invalide":
      return "Adresse email invalide.";
    default:
      return "La connexion a échoué. Veuillez réessayer.";
  }
}


bool loginValidation(String email, String password) {
  if (email.isEmpty && password.isEmpty) {
    showMessage("Les deux champs sont vides");
    return false;
  } else if (email.isEmpty) {
    showMessage("L'e-mail est vide");
    return false;
  } else if (password.isEmpty) {
    showMessage("Le mot de passe est vide");
    return false;
  } else {
    return true;
  }
}


bool signUpValidation(
    String email, String password, String name, String phone) {
  if (email.isEmpty && password.isEmpty && name.isEmpty && phone.isEmpty) {
    showMessage("Tous les champs sont vides");
    return false;
  } else if (name.isEmpty) {
    showMessage("Le champ prénom et nom est vide");
    return false;
  } else if (email.isEmpty) {
    showMessage("L'e-mail est vide");
    return false;
  } else if (phone.isEmpty) {
    showMessage("Le téléphone est vide");
    return false;
  } else if (password.isEmpty) {
    showMessage("Le mot de passe est vide");
    return false;
  } else {
    return true;
  }
}
