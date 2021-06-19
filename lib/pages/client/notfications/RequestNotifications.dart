// import 'package:FD_flutter/pages/client/widgets/StationWidget.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:outline_material_icons/outline_material_icons.dart';
// import '../../../modules/user.dart';
// import 'package:FD_flutter/shared/text_styles.dart';
// import 'dart:developer';

// class RequestNotifications extends StatefulWidget {
//   @override
//   _RequestNotificationsState createState() => _RequestNotificationsState();
// }

// class _RequestNotificationsState extends State<RequestNotifications> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: StreamBuilder<DocumentSnapshot>(
//           stream: Firestore.instance
//               .collection('client')
//               .document(Provider.of<User>(context).uid)
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
//                 List requestList = List.from(snapshot?.data['requests'] == null
//                     ? []
//                     : snapshot?.data['requests']);

//                 if (requestList.length == 0) {
//                   return Center(child: Text('aucun notifcation'));
//                 } else
//                   return ListView.builder(
//                     itemCount: requestList.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return StationWidget(id: requestList[index]);
//                     },
//                   );
//             }
//           }),
//     );
//   }
// }
