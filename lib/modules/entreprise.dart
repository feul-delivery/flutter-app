import 'package:FD_flutter/modules/livreur.dart';
import 'package:FD_flutter/modules/order.dart';

class Entreprise {
  String titre;
  String description;
  String tele;
  String email;
  String adresse;
  String photoURL;
  int like;
  int dislike;
  List<Livreur> workerslist;
  List<Order> entrepriseOrders;
  Entreprise(
      {this.titre,
      this.description,
      this.tele,
      this.email,
      this.adresse,
      this.photoURL,
      this.like,
      this.dislike,
      this.workerslist,
      this.entrepriseOrders});
}
