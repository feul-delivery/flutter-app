import 'package:FD_flutter/modules/livreur.dart';

class Entreprise {
  final String titre;
  final String description;
  final String tele;
  final String email;
  final String adresse;
  final int like;
  final int dislike;
  List<Livreur> list;
  Entreprise(
      {this.titre,
      this.description,
      this.tele,
      this.email,
      this.adresse,
      this.like,
      this.dislike,
      this.list});
}
