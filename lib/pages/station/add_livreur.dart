import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

class AddLivreur extends StatefulWidget {
  const AddLivreur({Key key}) : super(key: key);

  @override
  _AddLivreurState createState() => _AddLivreurState();
}

class _AddLivreurState extends State<AddLivreur> {
  TextEditingController searchController = TextEditingController();
  String searchTerm;
  String message = '';
  @override
  Widget build(BuildContext context) {
    final User _user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEFF0F5),
        title: Text(
          "New Deliveryman",
          style: pageTitleX,
        ),
        leading: IconButton(
          icon: Icon(OMIcons.arrowBack, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
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
                    labelText: "Type an email",
                    labelStyle: hintStyle,
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
                            '${document['tele']}'.toLowerCase(),
                            style: moreStyle,
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              _showModalDialogConfAdd(document, _user.uid);
                              if (message != '') {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  duration: Duration(seconds: 1),
                                  content: Text(
                                    message,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.black,
                                ));
                              } else {
                                message = '';
                              }
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
              height: MediaQuery.of(context).size.height * 1 / 4,
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: TextButton(
                          child: Text(
                            'Cancel',
                            style: hintStyle,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            setState(() {
                              message = 'Canceled';
                            });
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _addClToLv(document, uid);
                          Navigator.of(context).pop();
                          setState(() {
                            message = 'Done';
                          });
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
                              'Confirm',
                              style: buttonStyle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Confirmation',
                    style: titleStyle,
                  ),
                  Text('${document['nom']} ${document['prenom']} will '),
                  Text('work for you?'),
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
