// import 'package:flutter/material.dart';

// class ReclamtionDetail extends StatefulWidget {
//   final int id;
//   final String code;
//   final String date;
//   final String time;
//   final String couleur;
//   final String matricule;
//   final String type;
//   final String address;
//   final String message;

//   const ReclamtionDetail(
//       {Key key,
//       this.id,
//       this.code,
//       this.date,
//       this.time,
//       this.couleur,
//       this.matricule,
//       this.type,
//       this.address,
//       this.message})
//       : super(key: key);

//   _ReclamationDetailState createStateful() => _ReclamationDetailState();

//   @override
//   State<StatefulWidget> createState() {
//     throw UnimplementedError();
//   }
// }

// class _ReclamationDetailState extends State<ReclamationDetail> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Details",
//           style: TextStyle(),
//         ),
//         centerTitle: true,
//         backgroundcolor: Colors.black,
//         elevation: 1,
//       ),
//       body: getBody(),
//     );
//   }

//   Widget getBody() {
//     return ListView(
//       children: <Widget>[
//         SizedBox(
//           height: 30,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Icon(
//                     Icons.format_list_numbered_sharp,
//                     color: Colors.black54,
//                     size: 18,
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Text(
//                     "Number:",
//                     style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.black54),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Center(
//                 child: Text(
//                   widget.code,
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Icon(
//                     Icons.date_range_sharp,
//                     color: Colors.black54,
//                     size: 18,
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Text(
//                     "Date:",
//                     style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.black54),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Center(
//                 child: Text(
//                   widget.date,
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Icon(
//                     Icons.timer,
//                     color: Colors.black54,
//                     size: 18,
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Text(
//                     "Time:",
//                     style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.black54),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Center(
//                 child: Text(
//                   widget.time,
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Icon(
//                     Icons.note_add,
//                     color: Colors.black54,
//                     size: 18,
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Text(
//                     "Registration number:",
//                     style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.black54),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Center(
//                 child: Text(
//                   widget.matricule,
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Icon(
//                     Icons.color_lens,
//                     color: Colors.black54,
//                     size: 18,
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Text(
//                     "Color:",
//                     style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.black54),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Center(
//                 child: Text(
//                   widget.couleur,
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Icon(
//                     Icons.track_changes_sharp,
//                     color: Colors.black54,
//                     size: 18,
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Text(
//                     "Fuel type:",
//                     style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.black54),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Center(
//                 child: Text(
//                   widget.type,
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Icon(
//                     Icons.place,
//                     color: Colors.black54,
//                     size: 18,
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Text(
//                     "Address",
//                     style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.black54),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Center(
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(28, 0, 28, 0),
//                   child: Text(
//                     widget.address,
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Icon(
//                     Icons.place,
//                     color: Colors.black54,
//                     size: 18,
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Text(
//                     "Message",
//                     style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.black54),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Center(
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(28, 0, 28, 0),
//                   child: Text(
//                     widget.message,
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         Container(
//             color: Colors.black,
//             child: FlatButton(
//                 onPressed: () {},
//                 child: Text('Respond to Complaint !',
//                     style: TextStyle(color: Colors.white, fontSize: 15))))
//       ],
//     );
//   }
// }

// class ReclamationDetail {
//   String get date => null;

//   String get time => null;

//   String get matricule => null;

//   String get couleur => null;

//   String get type => null;

//   String get address => null;

//   String get message => null;

//   String get code => null;
// }
