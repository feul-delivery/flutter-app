import 'package:FD_flutter/services/auth.dart';
import 'package:FD_flutter/shared/StarterPage.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../wrapper.dart';

class SplashScreen extends StatefulWidget {
  static Map<String, String> mapLang;
  static String lang;
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isFirstTime = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () async {
//where the user type will be backapped
      String _type = await _getUserTypeFromSharedPref();
      setState(() {
        AuthService.type = _type;
      });
      SplashScreen.lang = await _getUserLangFromSharedPref();
      if (SplashScreen.lang == 'FR') {
        setState(() {
          SplashScreen.mapLang = mapFR;
        });
      } else {
        setState(() {
          SplashScreen.mapLang = mapEN;
        });
      }

      await _getIsFirstTimeFromSharedPref();
      if (!_isFirstTime) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Wrapper()));
      } else {
        await _isFirstTimeChangeState();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => StarterPage()));
      }
    });
  }

//user type from shared prefs
  Future<String> _getUserTypeFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('typeAccount') == null) {
      return null;
    } else {
      return prefs.getString('typeAccount');
    }
  }

  Future<String> _getUserLangFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('lang') == null) {
      return 'FR';
    } else {
      return prefs.getString('lang');
    }
  }

  Future<void> _getIsFirstTimeFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isFirstTime') == null) {
      setState(() {
        _isFirstTime = true;
      });
    } else {
      setState(() {
        _isFirstTime = prefs.getBool('isFirstTime');
      });
    }
  }

  Future<void> _isFirstTimeChangeState() async {
    final prefs = await SharedPreferences.getInstance();
    if (_isFirstTime) {
      setState(() => _isFirstTime = false);
      await prefs.setBool('isFirstTime', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFF0F5),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              width: MediaQuery.of(context).size.width * 2 / 3,
              height: MediaQuery.of(context).size.width * 2 / 3,
              child: Hero(
                tag: 'logo',
                child: Image(
                  image: AssetImage('assets/splash.png'),
                  fit: BoxFit.fill,
                ),
              )),
        ]),
      ),
    );
  }
}

Map<String, String> mapFR = {
  'home': 'Accueil',
  'hello': 'Bonjour',
  'explore': 'Explorer',
  'profile': 'Profil',
  'change': 'Modifier',
  'orders': 'Commandes',
  'order': 'Commander',
  'signin': 'Se connecter',
  'register': "S'inscrire",
  'welcomeback': 'Nous Saluons Le Retour',
  'password': 'mot de passe',
  'login': 'connexion',
  'cancel': 'Annuler',
  'createaccount': 'Créer un Compte',
  'editprofile': 'Modifier le profil',
  'changeemail': "Changer l'e-mail",
  'settings': 'Les paramètres',
  'changepassword': 'Changer le mot de passe',
  'account': 'Compte',
  'signout': 'Se déconnecter',
  'passwordvalidator': 'entrez un mot de passe de plus de 6 caractères.',
  'passwordmatch': "La confirmation ne correspond pas au mot de passe.",
  'emailvalidator': 'Veuillez saisir une adresse e-mail valide',
  'nointernet': 'Vérifiez votre connection internet',
  'sendemail': 'Envoyer un e-mail',
  'forgetpassword': 'Mot de passe oublié?',
  'ERROR_INVALID_EMAIL': 'Votre adresse e-mail semble incorrecte.',
  'ERROR_WRONG_PASSWORD': 'Votre mot de passe est incorrect.',
  'ERROR_USER_NOT_FOUND': "L'utilisateur avec cet e-mail n'existe pas.",
  'ERROR_USER_DISABLED': "L'utilisateur avec cet e-mail a été désactivé.",
  'ERROR_TOO_MANY_REQUESTS': "Trop de demandes. Réessayez plus tard.",
  'ERROR_OPERATION_NOT_ALLOWED':
      "La connexion avec e-mail et mot de passe n'est pas activée.",
  'UNDEFINED_ERROR': "Une erreur non définie s'est produite.",
  'accounttype': 'Type de compte',
  'customer': 'Client',
  'enterprise': 'Entreprise',
  'oldpassword': 'Ancien mot de passe',
  'changenewpassword': 'Changer le nouveau mot de passe',
  'error': 'Erreur',
  'validate': 'Valider',
  'newemail': 'Nouvel e-mail',
  'enterpassword': 'tapez votre mot de passe',
  'changenewemail': 'changer le nouvel e-mail',
  'aboutus': 'À propos de nous',
  'changelang': 'Changer la langue',
  'fr': 'français',
  'en': 'Anglais',
  'rateus': 'Evaluez nous',
  'submit': 'Soumettre',
  'favorite': 'Favoris',
  'bestweek': 'Le meilleur de la semaine',
  'closetoyou': 'Près de vous',
  'call': 'Appel',
  'mail': 'Courrier',
  'pictures': 'Photos',
  'typehere': 'écrivez ici',
  'personalinfo': 'Information personnelle',
  'firstname': 'Prénom',
  'lastname': 'Nom',
  'phone': 'Tél',
  'city': 'Ville',
  'sexe': 'Sexe',
  'address': 'Adresse',
  'deliverymen': 'Livreurs',
  'time': "Heure",
  'placeorder': 'Passer une commande',
  'finish': 'Terminer',
  'cod': 'Paiement à la livraison',
  'card': 'Carte de crédit',
  'next': 'Suivant',
  'required': 'Champs obligatoires',
  'carcolor': 'Couleur de la voiture',
  'pickcolor': 'Choisissez une couleur',
  'matricule': 'Matricule',
  'choose': 'Choisir',
  'confirm': 'Confirmer',
  'modepay': 'Mode de paiement',
  'pay': 'Payer',
  'viewall': 'Voir tout',
  'LOCATION_PERMISSION_DENIED':
      'Access to the location service has been declined',
  'dragchoose': 'Faites glisser pour choisir',
  'detail': 'Détail',
  'orderdetail': 'Détail du commande',
  'number': 'Numéro',
  'ftype': 'Type de carburant',
  'show': 'Afficher',
  'areyousure': 'êtes-vous sûr?',
  'usedlang': 'vous utilisez déjà cette langue',
  'accesslocation': "nous avons besoin d'accéder à votre emplacement",
  'locateme': 'Localiser moi',
  'delete': 'Effacer',
  'stnolv': "cette station n'a pas de livreurs",
  'deliveredASAP': 'sera livré dès que possible'
};
Map<String, String> mapEN = {
  'home': 'Home',
  'hello': 'Hello',
  'change': 'Change',
  'explore': 'Explore',
  'profile': 'Profile',
  'orders': 'Orders',
  'order': 'Order',
  'signin': 'Sign in',
  'register': "Register",
  'welcomeback': 'Welcome Back',
  'password': 'password',
  'login': 'Log in',
  'createaccount': 'Create an account',
  'editprofile': 'Edit profile',
  'changeemail': "Change email",
  'settings': 'Settings',
  'changepassword': 'change password',
  'account': 'Account',
  'detail': 'Detail',
  'orderdetail': 'Order detail',
  'signout': 'Sign out',
  'passwordvalidator': 'enter a password 6+ chars long.',
  'passwordmatch': 'confirmation do not match the password.',
  'emailvalidator': 'Please supply a valid email',
  'nointernet': 'Check your internet connection',
  'sendemail': 'Send Email',
  'cancel': 'Cancel',
  'forgetpassword': 'Forgot your password?',
  'ERROR_INVALID_EMAIL': 'Your email address appears to be malformed.',
  'ERROR_WRONG_PASSWORD': 'Your password is wrong.',
  'ERROR_USER_NOT_FOUND': 'User with this email doesn\'t exist.',
  'ERROR_USER_DISABLED': 'User with this email has been disabled.',
  'ERROR_TOO_MANY_REQUESTS': 'Too many requests. Try again later.',
  'ERROR_OPERATION_NOT_ALLOWED':
      'Signing in with Email and Password is not enabled.',
  'UNDEFINED_ERROR': 'An undefined Error happened.',
  'accounttype': 'Account type',
  'customer': 'Customer',
  'enterprise': 'Enterprise',
  'oldpassword': 'Old password',
  'changenewpassword': 'Change the new password',
  'error': 'Error',
  'validate': 'Validate',
  'newemail': 'New email',
  'enterpassword': 'enter your password',
  'changenewemail': 'change new email',
  'aboutus': 'About us',
  'changelang': 'Change the language',
  'fr': 'French',
  'en': 'English',
  'rateus': 'Rate us',
  'submit': 'Submit',
  'favorite': 'Favorites',
  'bestweek': 'The best of the week',
  'closetoyou': 'Close to you',
  'call': 'Appel',
  'mail': 'Mail',
  'pictures': 'Pictures',
  'typehere': 'type here',
  'personalinfo': 'Personal information',
  'firstname': 'First name',
  'lastname': 'Last name',
  'phone': 'Phone',
  'city': 'City',
  'sexe': 'Gender',
  'address': 'Address',
  'deliverymen': 'Deliverymen',
  'placeorder': 'Place an order',
  'time': "Time",
  'finish': 'Finish',
  'cod': 'Cash on delivery',
  'card': 'Credit Card',
  'next': 'Next',
  'confirm': 'Confirm',
  'required': 'Required',
  'carcolor': 'Car Color',
  'pickcolor': 'Pick a color',
  'matricule': 'Registration number',
  'choose': 'Choose',
  'modepay': 'Payment method',
  'pay': 'Pay',
  'viewall': 'View all',
  'LOCATION_PERMISSION_DENIED':
      "L'accès au service de localisation a été refusé",
  'dragchoose': 'Drag to choose',
  'number': 'Number',
  'ftype': 'Fuel type',
  'show': 'Show',
  'areyousure': 'are you sure?',
  'usedlang': 'you are already using this language',
  'accesslocation': 'we need access to your location',
  'locateme': 'Locate me',
  'delete': 'Delete',
  'stnolv': 'this station does not have delivery men',
  'deliveredASAP': 'will be delivered ASAP'
};
