import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

const scaffoldBackground = Color(0xFFEFF0F5);
const titleStyleNew =
    TextStyle(letterSpacing: 1.2, fontSize: 25, fontWeight: FontWeight.w900);

const titleStyle = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 20,
  letterSpacing: 1.5,
);
const pageTitle = TextStyle(
  fontWeight: FontWeight.w300,
  color: Colors.black,
);
const pageTitleX =
    TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black);
const hintStyle = TextStyle(
  color: Colors.black54,
  fontWeight: FontWeight.w300,
);
const hintStyleWhite = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w200,
);
const buttonStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w500,
  letterSpacing: 1.3,
);
const buttonStyleBlack = TextStyle(
  color: Colors.black54,
  fontWeight: FontWeight.w500,
  letterSpacing: 1.3,
);
const buttonRegisterStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 17,
    letterSpacing: 2.0);
const moreStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w300,
);
const moreStyleWhite = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w300,
);
const textStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w400,
);
const textStyleWhite = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w400,
);
const strongTextStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w500,
  fontSize: 15,
);
const subTitleStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w400,
  fontSize: 20,
);
const tileTitleStyle =
    TextStyle(fontSize: 18.5, fontWeight: FontWeight.w400, color: Colors.black);

const filterStyle = TextStyle(fontSize: 17.0, color: Colors.black);

const tileItemStyle = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.9,
    color: Colors.black);

const smallTileName =
    TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black);
const smallTileP =
    TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black);
const smallTileGray =
    TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black45);

Widget customeCircularProgress = Container(
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
        color: Colors.blue[700], borderRadius: BorderRadius.circular(50)),
    child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
        backgroundColor: Colors.blue[700]));
Widget customErrorWidget = Center(
    child: Container(
  padding: EdgeInsets.all(5),
  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
  child: Center(
    child: Icon(
      OMIcons.error,
      color: Colors.blue[700],
    ),
  ),
));
