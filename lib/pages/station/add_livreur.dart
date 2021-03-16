import 'package:flutter/material.dart';

class AddLivreur extends StatefulWidget {
  const AddLivreur({Key key}) : super(key: key);

  @override
  _AddLivreurState createState() => _AddLivreurState();
}

class _AddLivreurState extends State<AddLivreur> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text("New Deliveryman"),
      ),
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: searchController,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: "Type an email",
                    suffixIcon: IconButton(
                      onPressed: () => searchController.clear(),
                      icon: Icon(Icons.clear),
                      color: Colors.black26,
                    )),
              ))
        ],
      ),
    );
  }
}
