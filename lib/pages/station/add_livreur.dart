import 'package:FD_flutter/modules/user.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AddLivreur extends StatefulWidget {
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
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.justify,
                  ),
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
                            "${document['nom']}".toUpperCase() +
                                " " +
                                toBeginningOfSentenceCase(
                                    "${document['prenom']}".toLowerCase()),
                            style: textStyle,
                          ),
                          subtitle: Text(
                            '+212${document['tele']}'.toLowerCase(),
                            style: moreStyle,
                          ),
                          trailing: List.from(document?.data['requests'] == null
                                      ? []
                                      : document?.data['requests'])
                                  .contains(_user.uid)
                              ? IconButton(
                                  icon: Icon(Icons.done),
                                  onPressed: () {
                                    _showModalDialogDeleteRequest(
                                        document, _user.uid);
                                  },
                                )
                              : IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    _showModalDialogConfRequest(
                                        document, _user.uid);
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

  Future<void> _showModalDialogConfRequest(
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
                          _sendRequest(document.documentID, uid);
                          setState(() {});
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
                      'êtes-vous sûr de vouloir envoyer une invitation à travailler à ${toBeginningOfSentenceCase(document['prenom'])}' +
                          '${document['nom']}'.toUpperCase() +
                          '?',
                      textAlign: TextAlign.justify,
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

  Future<void> _showModalDialogDeleteRequest(
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
                          _deleteRequest(document.documentID, uid);
                          setState(() {});
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
                      "êtes-vous sûr de vouloir supprimer l'invitation à travailler que vous avez envoyée à ${toBeginningOfSentenceCase(document['prenom'])} " +
                          '${document['prenom']}'.toUpperCase() +
                          " ?",
                      textAlign: TextAlign.justify,
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

  Future<bool> _sendRequest(String documentID, String uid) {
    Firestore.instance.collection('client').document(documentID).setData({
      'requests': FieldValue.arrayUnion([uid])
    }, merge: true).then((value) {
      return true;
    }).catchError((onError) {
      return false;
    });
  }

  Future<bool> _deleteRequest(String documentID, String uid) {
    Firestore.instance.collection('client').document(documentID).setData({
      'requests': FieldValue.arrayRemove([uid])
    }, merge: true).then((value) {
      return true;
    }).catchError((onError) {
      return false;
    });
  }
}
