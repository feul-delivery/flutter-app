import 'package:FD_flutter/pages/client/station_cl.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class FavorisCl extends StatefulWidget {
  //static List<String> favList;
  @override
  _FavorisClState createState() => _FavorisClState();
}

class _FavorisClState extends State<FavorisCl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      //Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          'Favorites',
          style: pageTitle,
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('entreprise')
                .getDocuments()
                .asStream(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: Icon(
                  Icons.error,
                  color: Colors.black,
                ));
              }

              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(child: Icon(Icons.error, color: Colors.black));
                case ConnectionState.waiting:
                  return SizedBox(
                      child: Center(
                          child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.black),
                              backgroundColor: Colors.white)));
                default:
                  return new ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      children: snapshot.data?.documents
                          ?.map((DocumentSnapshot document) {
                        return _createCard(document);
                      })?.toList());
              }
            }),
      ),
    );
  }

  ListTile _createCard(DocumentSnapshot document) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushReplacement(PageTransition(
            type: PageTransitionType.leftToRight,
            child: StationProfilCl(doc: document)));
      },
      leading: InkWell(
          onTap: () {
            Navigator.of(context).pushReplacement(PageTransition(
                type: PageTransitionType.leftToRight,
                child: StationProfilCl(doc: document)));
          },
          child: Container(
            child: Icon(Icons.near_me_sharp, color: Colors.white),
          )),
      title: Text('${document.data['titre']}', style: moreStyleWhite),
      trailing: IconButton(
          icon: Icon(Icons.favorite, color: Colors.white), onPressed: null),
    );
  }
}
