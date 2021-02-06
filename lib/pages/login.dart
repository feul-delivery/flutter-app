import 'package:feul_delivery/animations/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:feul_delivery/pages/StarterPage.dart';
import 'package:feul_delivery/pages/station/index_st.dart';
import 'package:feul_delivery/pages/singup.dart';
import 'package:feul_delivery/pages/client/index_cl.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final txtlogin = TextEditingController();
    final txtpassword = TextEditingController();
    return WillPopScope(
      onWillPop: () {
        return Navigator.push(
            context, MaterialPageRoute(builder: (context) => StarterPage()));
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Colors.red[900].withOpacity(1),
          leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => StarterPage()));
            },
            icon: Icon(
              Icons.arrow_back,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [Colors.red[900], Colors.red[900], Colors.red[600]])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(
                        1,
                        Text(
                          "Bonjour,",
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    FadeAnimation(
                        1.3,
                        Text(
                          "Nous saluons le retour",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          FadeAnimation(
                              1.4,
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromRGBO(225, 95, 27, .3),
                                          blurRadius: 20,
                                          offset: Offset(0, 10))
                                    ]),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextField(
                                        controller: txtlogin,
                                        decoration: InputDecoration(
                                            hintText: "Email",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextField(
                                        controller: txtpassword,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            hintText: "Mot de passe",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          FadeAnimation(
                              1.5,
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Entrer votre email"),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                    bottom: 0.0,
                                                    left: 0.0,
                                                    right: 0.0,
                                                    top: 0.0),
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color: Colors
                                                                .grey[200]))),
                                                child: TextField(
                                                  obscureText: true,
                                                  decoration: InputDecoration(
                                                      hintText: "Email",
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      border: InputBorder.none),
                                                ),
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            Row(children: [
                                              FlatButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    "Fermer",
                                                    style: TextStyle(
                                                        color: Colors.red[900]),
                                                  )),
                                              FlatButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    "Envoyer",
                                                    style: TextStyle(
                                                        color: Colors.red[900]),
                                                  )),
                                            ]),
                                          ],
                                        );
                                      });
                                },
                                child: Text(
                                  "mot de passe oublié?",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              )),
                          SizedBox(
                            height: 30,
                          ),
                          FadeAnimation(
                              1.2,
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 50),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.red[900]),
                                child: Center(
                                  child: FlatButton(
                                    onPressed: () {
                                      if (txtlogin.text == 'user' &&
                                          txtpassword.text == 'user') {
                                        Navigator.pushReplacement(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                child: Cl()));
                                      } else {
                                        if (txtlogin.text == 'admin' &&
                                            txtpassword.text == 'admin') {
                                          Navigator.pushReplacement(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType.fade,
                                                  child: St()));
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  new AlertDialog(
                                                    title: Text('Erreur'),
                                                    content: Text(
                                                        'le login ou mot de passe sont incorects'),
                                                    actions: [
                                                      FlatButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop(false);
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Text(
                                                            'Ok',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .red[900]),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ));
                                        }
                                      }
                                    },
                                    child: Text(
                                      "Se connecter",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          FadeAnimation(
                              1.7,
                              Text(
                                "vous êtes nouveau ici?",
                                style: TextStyle(color: Colors.grey),
                              )),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: FadeAnimation(
                                    1.8,
                                    Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.blue),
                                      child: Center(
                                          child: FlatButton(
                                        hoverColor: Colors.black,
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType.fade,
                                                  child: SignupPage()));
                                        },
                                        child: Text(
                                          "Créer un nouveau compte",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              letterSpacing: 2.0),
                                        ),
                                      )),
                                    )),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
