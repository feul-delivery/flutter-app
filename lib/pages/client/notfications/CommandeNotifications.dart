// import 'package:FD_flutter/pages/client/widgets/StationWidget.dart';
// import 'package:FD_flutter/shared/text_styles.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:outline_material_icons/outline_material_icons.dart';
// import 'package:provider/provider.dart';
// import '../../../modules/user.dart';

// class CommandeNotifications extends StatefulWidget {
//   @override
//   _CommandeNotificationsState createState() => _CommandeNotificationsState();
// }

// class _CommandeNotificationsState extends State<CommandeNotifications> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: StreamBuilder<QuerySnapshot>(
//           stream: Firestore.instance
//               .collection('orders')
//               .where('uidlivreur', isGreaterThan: null)
//               .where('statut', isEqualTo: 'waiting')
//               .where('uidclient', isEqualTo: Provider.of<User>(context).uid)
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return Container(
//                 width: MediaQuery.of(context).size.height * 1 / 5,
//                 child: Center(
//                   child: Icon(
//                     OMIcons.error,
//                     color: Color(0xFF1763B9),
//                   ),
//                 ),
//               );
//             }
//             switch (snapshot.connectionState) {
//               case ConnectionState.none:
//                 return Container(
//                   color: darkGray,
//                   child: Center(
//                     child: Icon(OMIcons.error, color: Colors.white54),
//                   ),
//                 );

//               case ConnectionState.waiting:
//                 return Container(
//                   color: darkGray,
//                   child: Center(
//                     child: customeCircularProgress,
//                   ),
//                 );

//               default:
//                 if (snapshot?.data?.documents?.length == 0) {
//                   return Center(child: Text('aucun notifcation'));
//                 }
//                 return ListView.builder(
//                   itemCount: snapshot.data.documents.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     double _prixTotal = double.tryParse(
//                         '${snapshot.data.documents[index]['prixtotal']}');
//                     return ListTile(
//                         leading: Container(
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.orange,
//                             borderRadius: BorderRadius.circular(50),
//                           ),
//                           child: Icon(
//                             OMIcons.timer,
//                             color: Colors.white,
//                           ),
//                         ),
//                         title: Text(
//                           '${snapshot.data.documents[index]['ordernum']}',
//                           style: tileTitleStyleW,
//                         ),
//                         subtitle: Text(
//                           """${DateFormat.Hm().format(DateTime.parse(snapshot.data.documents[index]['dateheurec']))} - ${DateTime.parse(snapshot.data.documents[index]['dateheurec']).day}/${DateTime.parse(snapshot.data.documents[index]['dateheurec']).month}/${DateTime.parse(snapshot.data.documents[index]['dateheurec']).year}""",
//                           style: smallTileGray,
//                         ),
//                         trailing: Text(
//                           '${_prixTotal.toStringAsFixed(2)} Dh',
//                           style: moreStyleWhite,
//                         ));
//                   },
//                 );
//             }
//           }),
//     );
//   }
// }
