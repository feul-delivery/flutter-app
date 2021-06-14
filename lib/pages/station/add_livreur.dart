import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddLivreur extends StatefulWidget {
  const AddLivreur({Key key}) : super(key: key);

  @override
  _AddLivreurState createState() => _AddLivreurState();
}

class _AddLivreurState extends State<AddLivreur> {
  TextEditingController searchController = TextEditingController();
  String searchTerm;
  @override
  Widget build(BuildContext context) {
    final User _user = Provider.of<User>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text(
          "Nouveau Livreur",
          style: pageTitleX.copyWith(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.west, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info),
                SizedBox(width: 10),
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Text(
                      "pour ajouter un livreur demandez-lui de créer un compte client, retrouvez-le avec l'email ci-dessous puis invitez-le à rejoindre votre équipe",
                      style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: searchController,
                textInputAction: TextInputAction.search,
                onChanged: (value) {
                  setState(() {
                    searchTerm = value;
                  });
                },
                decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: "Tapez un Email",
                    labelStyle: hintStyleB,
                    suffixIcon: IconButton(
                      onPressed: () => searchController.clear(),
                      icon: Icon(Icons.clear),
                      color: Colors.black26,
                    )),
              )),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: (searchTerm == null || searchTerm.trim() == '')
                  ? Firestore.instance.collection('client').snapshots()
                  : Firestore.instance
                      .collection('client')
                      .where('email', isGreaterThanOrEqualTo: searchTerm)
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Icon(Icons.cancel, color: Colors.black);
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return SizedBox(
                        child: Center(child: customeCircularProgress));
                  case ConnectionState.none:
                    return Icon(Icons.error_outline, color: Colors.black);
                  case ConnectionState.done:
                    return Icon(
                      Icons.done,
                      color: Colors.black,
                    );
                  default:
                    return new ListView(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                      return new ListTile(
                          title: Text(
                            "${document['nom']} ${document['prenom']}"
                                .toUpperCase(),
                            style: textStyle,
                          ),
                          subtitle: Text(
                            '+212${document['tele']}'.toLowerCase(),
                            style: moreStyle,
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              _showModalDialogConfAdd(document, _user.uid);
                            },
                          ));
                    }).toList());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showModalDialogConfAdd(
      DocumentSnapshot document, String uid) async {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          'Confirmation',
                          style: pageTitleW.copyWith(color: Colors.black),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _addClToLv(document, uid);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width * 1 / 5,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.black),
                          child: Center(
                            child: Text(
                              'Confirmer',
                              style: buttonStyle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'êtes-vous sûr de vouloir ajouter ${document['nom']} ${document['prenom']} à votre personnel ?',
                      style:
                          textStyle.copyWith(color: Colors.black, fontSize: 18),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Future<bool> _addClToLv(DocumentSnapshot document, String uid) async {
  String _clientUID = document.documentID;
  String _nom = await document['nom'];
  String _prenom = await document['prenom'];
  String _email = await document['email'];
  String _cin = await document['cin'];
  String _sexe = await document['sexe'];
  String _tele = document['tele'];
  String _photoURL = await document['photoURL'];

  await Firestore.instance.collection('livreur').document(_clientUID).setData({
    'nom': _nom.toLowerCase(),
    'prenom': _prenom.toLowerCase(),
    'email': _email.toLowerCase(),
    'cin': _cin.toLowerCase(),
    'sexe': _sexe.toLowerCase(),
    'tele': _tele.toLowerCase(),
    'photoURL': _photoURL.toLowerCase(),
    'dateajoute': DateTime.now().toString(),
    'statut': 'inactif',
    'uidentreprise': uid,
  }).whenComplete(() async => await _clientRemoval(_email, _clientUID));

  return true;
}

_clientRemoval(String email, String uid) async {
  await Firestore.instance
      .collection('user')
      .document(email)
      .updateData({'account': 'livreur'});
  await Firestore.instance.collection('client').document(uid).delete();
  await Firestore.instance
      .collection('order')
      .where('uidclient', isEqualTo: uid)
      .getDocuments()
      .then((value) async {
    for (DocumentSnapshot doc in value.documents) {
      await Firestore.instance
          .collection('order')
          .document(doc.documentID)
          .delete();
    }
  });
}
