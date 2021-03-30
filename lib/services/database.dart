import 'package:FD_flutter/modules/client.dart';
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

  Future<void> updateUserType(String account, String email) async {
    return await userCollection.document(email).setData({
      'account': account,
    });
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
      'emaim': email,
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

  // User userDataFromSnapshot(DocumentSnapshot snapshot) {
  //   return User(
  //     uid: uid,
  //     account: snapshot.data['account'],
  //   );
  // }

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
    String cin,
    String sexe,
    String tele,
    String statut,
    String uidentreprise,
  ) async {
    return await livreurCollection.document(uid).setData({
      'nom': nom,
      'prenom': prenom,
      'email': email,
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

  Future<void> newOrderData(
    int ordernum,
    double volume,
    String adresse,
    DateTime dateheurec,
    DateTime dateheurel,
    String matricule,
    String color,
    double prixtotal,
    String statut,
    String methode,
    String uidclient,
    String uidstation,
    String uidlivreur,
    String idtype,
  ) async {
    return await ordersCollection.document().setData({
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
      'uidclient': uidclient,
      'uidstation': uidstation,
      'uidlivreur': uidlivreur,
      'idtype': idtype,
    });
  }

  Future<int> countOrdersDocuments(String uid) async {
    QuerySnapshot _myDoc = await ordersCollection
        .where('uidclient', isEqualTo: uid)
        .getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    return _myDocCount.length; // Count of Documents in Collection
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
    List<dynamic> types,
  }) async {
    if (types == null) {
      return await entrepriseCollection.document(uid).setData({
        'titre': titre,
        'description': description,
        'tele': tele,
        'email': email,
        'adresse': address,
      }, merge: true);
    } else {
      return await entrepriseCollection.document(uid).setData({
        'titre': titre,
        'description': description,
        'tele': tele,
        'email': email,
        'adresse': address,
        'type': types
      }, merge: true);
    }
  }

  // get livreur stream
  Stream<QuerySnapshot> get entreprise {
    return entrepriseCollection.snapshots();
  }

  Future<Entreprise> entrepriseData() async {
    String title;
    String description;
    String phone;
    String address;
    String email;
    String photoURL;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
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
      address = await value.data['adresse'];
      photoURL = await value.data['photoURL'];
    });
    return Entreprise(
        titre: title,
        description: description,
        tele: phone,
        email: email,
        adresse: address,
        photoURL: photoURL);
  }

  Future<Client> clientData() async {
    String nom;
    String prenom;
    String email;
    String cin;
    String phone;
    String ville;
    String sexe;
    String photoURL;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    await Firestore.instance
        .collection('client')
        .document(uid)
        .get()
        .then((value) async {
      nom = await value.data['nom'];
      prenom = await value.data['prenom'];
      email = await value.data['email'];

      cin = await value.data['cin'];
      phone = await value.data['tele'];
      ville = await value.data['ville'];
      sexe = await value.data['sexe'];
      photoURL = await value.data['photoURL'];
    });
    return Client(
        sexe: sexe,
        nom: nom,
        cin: cin,
        prenom: prenom,
        tele: phone,
        email: email,
        ville: ville,
        photoURL: photoURL);
  }
}
