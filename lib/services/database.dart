import 'dart:ffi';

import 'package:FD_flutter/modules/client.dart';
import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/modules/entreprise.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference clientCollection =
      Firestore.instance.collection('client');

  final CollectionReference userCollection =
      Firestore.instance.collection('user');

  final CollectionReference livreurCollection =
      Firestore.instance.collection('livreur');

  final CollectionReference ordersCollection =
      Firestore.instance.collection('orders');

  final CollectionReference entrepriseCollection =
      Firestore.instance.collection('entreprise');

  Future<void> updateUserData(String account) async {
    return await userCollection.document(uid).setData({
      'account': account,
    });
  }

  Future<String> getAccountType() async {
    await Firestore.instance
        .collection('user')
        .document(uid)
        .get()
        .then((value) async {
      print(value.data['account'].toString());
      dynamic kk = await value.data['account'];
      print(kk);
      return await kk;
    });
    return null;
  }

  Future<void> updateClientData(String nom, String prenom, String email,
      String sexe, String cin, String tele, String ville) async {
    return await clientCollection.document(uid).updateData({
      'nom': nom,
      'prenom': prenom,
      'sexe': sexe,
      'cin': cin,
      'tele': tele,
      'ville': ville,
    });
  }

  Future<void> setClientData(String nom, String prenom, String email,
      String sexe, String cin, String tele, String ville) async {
    return await clientCollection.document(uid).setData({
      'nom': nom,
      'prenom': prenom,
      'emaim' : email,
      'sexe': sexe,
      'cin': cin,
      'tele': tele,
      'ville': ville,
    });
  }

  // get client stream
  Stream<QuerySnapshot> get client {
    return clientCollection.snapshots();
  }

  User userDataFromSnapshot(DocumentSnapshot snapshot) {
    return User(
      uid: uid,
      account: snapshot.data['account'],
    );
  }

  Client _clientFromSnapshot(DocumentSnapshot snapshot) {
    return Client(
        nom: snapshot.data['nom'],
        prenom: snapshot.data['prenom'],
        email: snapshot.data['email'],
        sexe: snapshot.data['sexe'],
        cin: snapshot.data['cin'],
        tele: snapshot.data['tele'],
        ville: snapshot.data['ville']);
  }

  // get user doc stream
  Stream<Client> get userData {
    return clientCollection.document(uid).snapshots().map(_clientFromSnapshot);
  }

  Future<void> updateLivreurData(
    String nom,
    String prenom,
    String email,
    String password,
    String cin,
    String sexe,
    String tele,
    String statut,
    String uidentreprise,
  ) async {
    return await livreurCollection.document(uid).setData({
      'uid': uid,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'password': password,
      'cin': cin,
      'sexe': sexe,
      'tele': tele,
      'statut': statut,
      'uidentreprise': uidentreprise,
    });
  }

  // get livreur stream
  Stream<QuerySnapshot> get livreur {
    return livreurCollection.snapshots();
  }

  Future<void> updateOrdersData(
    int ordernum,
    Double volume,
    String adresse,
    DateTime dateheurec,
    DateTime dateheurel,
    String matricule,
    String color,
    String prixtotal,
    String statut,
    String methode,
    String uidstation,
    String uidlivreur,
    String idtype,
  ) async {
    return await ordersCollection.document(uid + "/" + "$ordernum").setData({
      'ordernum': ordernum,
      'volume': volume,
      'adresse': adresse,
      'dateheurec': dateheurec,
      'dateheurel': dateheurel,
      'matricule': matricule,
      'color': color,
      'prixtotal': prixtotal,
      'statut': statut,
      'methode': methode,
      'uidstation': uidstation,
      'uidlivreur': uidlivreur,
      'idtype': idtype,
    });
  }

  // get livreur stream
  Stream<QuerySnapshot> get orders {
    return ordersCollection.snapshots();
  }

  Future<void> updateEntrepriseData({
    String titre,
    String description,
    String tele,
    String email,
    String address,
    String like,
    String dislike,
  }) async {
    return await entrepriseCollection.document(uid).setData({
      'titre': titre,
      'description': description,
      'tele': tele,
      'email': email,
      'adresse': address,
      'like': like,
      'dislike': dislike,
    });
  }

  // get livreur stream
  Stream<QuerySnapshot> get entreprise {
    return entrepriseCollection.snapshots();
  }

  Future<Entreprise> getDataEnt() async {
    String title;
    String description;
    String phone;
    String email;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    await Firestore.instance
        .collection('entreprise')
        .document(uid)
        .get()
        .then((value) async {
      title = await value.data['titre'];
      description = await value.data['description'];
      email = await value.data['email'];
      phone = await value.data['tele'];
      print(title);
      print(phone);
      return Entreprise(
          titre: title, description: description, email: email, tele: phone);
    });
    return Entreprise(titre: "HHHH");
  }
}
