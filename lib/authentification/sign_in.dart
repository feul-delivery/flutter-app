import 'package:FD_flutter/services/auth.dart';
import 'package:FD_flutter/shared/FadeAnimation.dart';
import 'package:FD_flutter/shared/loading.dart';
import 'package:FD_flutter/shared/text_styles.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
              padding: EdgeInsets.only(top: 80),
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                Colors.red[800],
                Colors.red[600],
                Colors.red[400]
              ])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeAnimation(
                            0.2,
                            Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontFamily: 'Gotham',
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        FadeAnimation(
                            0.2,
                            Text(
                              "Welcome back",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Gotham',
                                fontWeight: FontWeight.w300,
                              ),
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
                                  0.2,
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color.fromRGBO(
                                                  225, 95, 27, .3),
                                              blurRadius: 20,
                                              offset: Offset(0, 10))
                                        ]),
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color:
                                                            Colors.grey[200]))),
                                            child: TextFormField(
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                  hintText: "Email",
                                                  hintStyle: hintStyle,
                                                  border: InputBorder.none),
                                              validator: (val) {
                                                if (val.isEmpty ||
                                                    !val.contains('@') ||
                                                    !val.contains('.')) {
                                                  return 'Please enter a valid email address.';
                                                }
                                                return null;
                                              },
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              onChanged: (val) {
                                                setState(() => email = val);
                                              },
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color:
                                                            Colors.grey[200]))),
                                            child: TextFormField(
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                  hintText: "Password",
                                                  hintStyle: hintStyle,
                                                  border: InputBorder.none),
                                              validator: (val) => val.length < 6
                                                  ? 'Enter a password 6+ chars long'
                                                  : null,
                                              onChanged: (val) {
                                                setState(() => password = val);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              FadeAnimation(
                                  0.2,
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Enter your email"),
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
                                                                color:
                                                                    Colors.grey[
                                                                        200]))),
                                                    child: TextField(
                                                      obscureText: true,
                                                      decoration: InputDecoration(
                                                          hintText: "Email",
                                                          hintStyle: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                          border:
                                                              InputBorder.none),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                Row(children: [
                                                  FlatButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text(
                                                        "Close",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .red[900]),
                                                      )),
                                                  FlatButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text(
                                                        "Submit",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .red[900]),
                                                      )),
                                                ]),
                                              ],
                                            );
                                          });
                                    },
                                    child: Text(
                                      "Forgot your password?",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Gotham',
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              FadeAnimation(
                                0.2,
                                Text(
                                  errorMessage,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: 'Gotham',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              FadeAnimation(
                                  0.2,
                                  InkWell(
                                    onTap: () async {
                                      if (_formKey.currentState.validate()) {
                                        setState(() => loading = true);

                                        dynamic user = await _auth
                                            .signInWithEmailAndPassword(
                                                email, password);
                                        if (user == null) {
                                          errorMessage = AuthService.error;
                                          setState(() {
                                            loading = false;
                                          });
                                        }
                                        setState(() {
                                          loading = false;
                                        });
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          80.0, 5.0, 80.0, 5.0),
                                      padding: EdgeInsets.fromLTRB(
                                          20.0, 20.0, 20.0, 20.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.red[700]),
                                      child: Center(
                                        child: Text(
                                          "Log in",
                                          style: buttonStyle,
                                        ),
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              FadeAnimation(
                                  0.2,
                                  Text(
                                    "you are new here?",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'Gotham',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: FadeAnimation(
                                        0.2,
                                        InkWell(
                                          hoverColor: Colors.black,
                                          onTap: () => widget.toggleView(),
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.blue[900]),
                                            child: Center(
                                                child: Text(
                                                    "Create a new account",
                                                    style:
                                                        buttonRegisterStyle)),
                                          ),
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
          );
  }
}
