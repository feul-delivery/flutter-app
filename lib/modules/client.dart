import 'package:FD_flutter/modules/order.dart';

class Client {
  String nom;
  String prenom;
  String email;
  String sexe;
  String cin;
  String tele;
  String photoURL;
  String ville;
  List<Order> clientOrders;
  Client(
      {this.nom,
      this.prenom,
      this.email,
      this.sexe,
      this.cin,
      this.tele,
      this.photoURL,
      this.ville,
      this.clientOrders});
}
