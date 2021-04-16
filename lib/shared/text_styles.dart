import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

const scaffoldBackground = Color(0xFFEFF0F5);
const titleStyleNew =
    TextStyle(fontSize: 24, fontFamily: 'Quarion', fontWeight: FontWeight.w600);
const errorTextStyle = TextStyle(
    color: Colors.red,
    fontFamily: 'Quarion',
    fontSize: 14,
    fontWeight: FontWeight.w400);
const titleStyle = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 20,
  letterSpacing: 1.5,
  fontFamily: 'Quarion',
);
const pageTitle = TextStyle(
  fontWeight: FontWeight.w300,
  color: Colors.black,
  fontFamily: 'Quarion',
);
const pageTitleX = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    fontFamily: 'Quarion',
    color: Colors.black);
const pageTitleXW = TextStyle(
    fontSize: 20,
    fontFamily: 'Quarion',
    fontWeight: FontWeight.w700,
    color: Colors.white,
    letterSpacing: 1.2);
const hintStyle = TextStyle(
  color: Colors.black54,
  fontFamily: 'Quarion',
  fontWeight: FontWeight.w300,
);
const hintStyleWhite = TextStyle(
  color: Colors.white,
  fontFamily: 'Quarion',
  fontWeight: FontWeight.w200,
);
const buttonStyle = TextStyle(
  fontFamily: 'Quarion',
  color: Colors.white,
  fontWeight: FontWeight.w500,
  letterSpacing: 1.3,
);
const buttonStyleBlack = TextStyle(
  fontFamily: 'Quarion',
  color: Colors.black54,
  fontWeight: FontWeight.w500,
  letterSpacing: 1.3,
);
const buttonRegisterStyle = TextStyle(
    fontFamily: 'Quarion',
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 17,
    letterSpacing: 2.0);
const moreStyle = TextStyle(
    fontFamily: 'Quarion',
    color: Colors.black,
    fontWeight: FontWeight.w300,
    fontStyle: FontStyle.italic);
const moreStyleWhite = TextStyle(
  fontFamily: 'Quarion',
  color: Colors.white,
  fontWeight: FontWeight.w300,
);
const textStyle = TextStyle(
  fontFamily: 'Quarion',
  color: Colors.black,
  fontWeight: FontWeight.w400,
);
const textStyleWhite = TextStyle(
  fontFamily: 'Quarion',
  color: Colors.white,
  fontWeight: FontWeight.w400,
);
const strongTextStyle = TextStyle(
  fontFamily: 'Quarion',
  color: Colors.black,
  fontWeight: FontWeight.w500,
  fontSize: 15,
);
const subTitleStyle = TextStyle(
  fontFamily: 'Quarion',
  color: Colors.black,
  fontWeight: FontWeight.w400,
  fontSize: 20,
);
const tileTitleStyle = TextStyle(
    fontSize: 18.5,
    fontWeight: FontWeight.w400,
    fontFamily: 'Quarion',
    color: Colors.black);

const filterStyle =
    TextStyle(fontFamily: 'Quarion', fontSize: 17.0, color: Colors.black);

const tileItemStyle = TextStyle(
    fontSize: 24.0,
    fontFamily: 'Quarion',
    fontWeight: FontWeight.w800,
    letterSpacing: 0.9,
    color: Colors.black);

const smallTileName = TextStyle(
    fontSize: 17,
    fontFamily: 'Quarion',
    fontWeight: FontWeight.w800,
    color: Colors.black);
const smallTileP = TextStyle(
    fontSize: 16,
    fontFamily: 'Quarion',
    fontWeight: FontWeight.w400,
    color: Colors.black);
const smallTileGray = TextStyle(
    fontSize: 16,
    fontFamily: 'Quarion',
    fontWeight: FontWeight.w400,
    color: Colors.black45);

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
