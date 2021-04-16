// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';

// class HtmlMap extends StatefulWidget {
//   HtmlMap({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _HtmlMapState createState() => new _HtmlMapState();
// }

// const htmlData = """
//     <html lang="en">
// <head>
//     <meta charset="UTF-8">
//     <meta http-equiv="X-UA-Compatible" content="IE=edge">
//     <meta name="viewport" content="width=device-width, initial-scale=1.0">
//     <title>Document</title>
// </head>
// <body>
//     <iframe src="https://www.google.com/maps/embed?pb=!1m26!1m12!1m3!1d847709.7558871384!2d-6.477773418175439!3d33.90597261022609!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!4m11!3e6!4m3!3m2!1d34.012299999999996!2d-6.8484!4m5!1s0xd9f8b7a7b5bc573%3A0x47c56a6ea67c5491!2sRue%20Niger%2C%20F%C3%A8s%2030050%2C%20Morocco!3m2!1d34.015793699999996!2d-4.9864543!5e0!3m2!1sen!2sma!4v1618502248458!5m2!1sen!2sma" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
// </body>
// </html>
//     """;

// class _HtmlMapState extends State<HtmlMap> {
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: AppBar(
//         title: Text('flutter_html Example'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Html(
//           data: htmlData,
//           //Optional parameters:
//           onLinkTap: (url) {
//             print("Opening $url...");
//           },
//           onImageTap: (src) {
//             print(src);
//           },
//           onImageError: (exception, stackTrace) {
//             print(exception);
//           },
//         ),
//       ),
//     );
//   }
// }
