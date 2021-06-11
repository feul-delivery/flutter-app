// Widget getBodyDone() {
//     DateTime dateC = DateTime.parse(widget.document['dateheurec']);
//     DateTime dateL = DateTime.parse(widget.document['dateheurel']);
//     int colorV = int.parse(widget.document['color'].toString());
//     Color myColor = Color(colorV);
//     print(colorV);
//     return ListView(
//       children: <Widget>[
//         SizedBox(
//           height: 10,
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
//                     "Ref:",
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
//                   widget.document.reference.documentID,
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
//                     "Date de commande:",
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
//                   "${dateC.day}/${dateC.month}/${dateC.year} ${DateFormat.Hm().format(dateC)}",
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
//                     Icons.done,
//                     color: Colors.black54,
//                     size: 18,
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Text(
//                     "Date de livrisent:",
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
//                   "${dateL.day}/${dateL.month}/${dateL.year} ${DateFormat.Hm().format(dateL)}",
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
//                     Icons.person,
//                     color: Colors.black54,
//                     size: 18,
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Text(
//                     "livreur de commande:",
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
//                   livreur,
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
//                     "${Language.mapLang['matricule']}",
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
//                   widget.document['matricule'],
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
//                 crossAxisAlignment: CrossAxisAlignment.center,
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
//                   SizedBox(
//                     width: 60,
//                   ),
//                   Container(
//                     width: 60,
//                     height: 20,
//                     color: myColor,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 27,
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
//                   widget.document['idtype'],
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
//                     widget.document['adresse'],
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
