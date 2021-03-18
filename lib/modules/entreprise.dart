import 'package:FD_flutter/modules/livreur.dart';

class Entreprise {
  String titre;
  String description;
  String tele;
  String email;
  String adresse;
  String photoURL;
  int like;
  int dislike;
  List<Livreur> list;
  Entreprise(
      {this.titre,
      this.description,
      this.tele,
      this.email,
      this.adresse,
      this.photoURL,
      this.like,
      this.dislike,
      this.list});
}
