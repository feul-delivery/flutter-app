import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference clientCollection =
      Firestore.instance.collection('client');

  final CollectionReference livreurCollection =
      Firestore.instance.collection('livreur');

  final CollectionReference ordersCollection =
      Firestore.instance.collection('orders');

  final CollectionReference entrepriseCollection =
      Firestore.instance.collection('entreprise');

  Future<void> updateClientData(
      String idclient,
      String nom,
      String prenom,
      String email,
      String password,
      String sexe,
      String cin,
      String tele,
      int idVille) async {
    return await clientCollection.document(uid).setData({
      'idclient': idclient,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'password': password,
      'sexe': sexe,
      'cin': cin,
      'tele': tele,
      'idville': idVille,
    });
  }

  // get client stream
  Stream<QuerySnapshot> get client {
    return clientCollection.snapshots();
  }

  Future<void> updateLivreurData(
    String idLivreur,
    String nom,
    String prenom,
    String email,
    String password,
    String cin,
    String sexe,
    String tele,
    String statut,
    String identreprise,
  ) async {
    return await livreurCollection.document(uid).setData({
      'idclient': idLivreur,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'password': password,
      'cin': cin,
      'sexe': sexe,
      'tele': tele,
      'statut': statut,
      'identreprise': identreprise,
    });
  }

  // get livreur stream
  Stream<QuerySnapshot> get livreur {
    return livreurCollection.snapshots();
  }

  Future<void> updateOrdersData(
    String idorder,
    String volume,
    String adresse,
    String dateheurec,
    String dateheurel,
    String matricule,
    String color,
    String prixtotal,
    String statut,
    String methode,
    String idclient,
    String idtype,
  ) async {
    return await ordersCollection.document(uid).setData({
      'idorder': idorder,
      'volume': volume,
      'adresse': adresse,
      'dateheurec': dateheurec,
      'dateheurel': dateheurel,
      'matricule': matricule,
      'color': color,
      'prixtotal': prixtotal,
      'statut': statut,
      'methode': methode,
      'idclient': idclient,
      'idtype': idtype,
    });
  }

  // get livreur stream
  Stream<QuerySnapshot> get orders {
    return ordersCollection.snapshots();
  }

  Future<void> updateEntrepriseData(
    String identreprise,
    String titre,
    String description,
    String tele,
    String email,
    String adresse,
    String like,
    String dislike,
  ) async {
    return await entrepriseCollection.document(uid).setData({
      'idorder': identreprise,
      'volume': titre,
      'adresse': description,
      'dateheurec': tele,
      'dateheurel': email,
      'matricule': adresse,
      'color': like,
      'prixtotal': dislike,
    });
  }

  // get livreur stream
  Stream<QuerySnapshot> get entreprise {
    return entrepriseCollection.snapshots();
  }
}
