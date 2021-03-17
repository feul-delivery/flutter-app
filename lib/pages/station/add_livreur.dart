import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text("New Deliveryman"),
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
                      .where('email', isEqualTo: searchTerm)
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error');
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return SizedBox(
                        child: Center(
                            child: CircularProgressIndicator(
                                backgroundColor: Colors.red[900])));
                  case ConnectionState.none:
                    return Text('Oops no data');
                  case ConnectionState.done:
                    return Text('Done');
                  default:
                    return new ListView(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                      return new ListTile(
                          title:
                              Text("${document['nom']} ${document['prenom']}"),
                          subtitle: Text(document['tele']),
                          trailing: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              _addToLv(document);
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
}

Future<bool> _addToLv(DocumentSnapshot document) async {
  return true;
}
// Future<Livreur> _findEmail(String value) async {
//   String valeur = value;
//   Livreur lv;
//   List<DocumentSnapshot> documentList;
//   documentList = (await Firestore.instance
//           .collection('client')
//           .where("email", isEqualTo: value)
//           .getDocuments())
//       .documents;
//   for (DocumentSnapshot documentSnapshot in documentList) {
//     documentSnapshot.data.map((key, value) => {if (value == valeur) {

//     }});
//   }
//   return lv;
// }
