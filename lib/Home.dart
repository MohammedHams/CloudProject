import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  StreamSubscription<QuerySnapshot> streamSubscription;

  List<DocumentSnapshot> snapshot;
  CollectionReference collectionReference =
      Firestore.instance.collection("TopPost");
  @override
  void initState() {
    streamSubscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        snapshot = datasnapshot.documents;
      });
    });

    super.initState();
  }

  TextEditingController name = TextEditingController();
  String textValue;
  var checkbox1 = false;
  Widget build(BuildContext context) {
    var inputDecoration = InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Colors.red, width: 2, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(10),
      ),
    );
    return Scaffold(
        appBar: AppBar(
          title: Text("first app"),
          backgroundColor: Colors.purple,
          elevation: 10,
          centerTitle: false,
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.search),
              onPressed: () => debugPrint("search"),
            ),
            new IconButton(
              icon: new Icon(Icons.add),
              onPressed: () => debugPrint("add"),
            ),
          ],
        ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text("cod with abd"),
                accountEmail: new Text("aaa @gmai;.com"),
                decoration: new BoxDecoration(color: Colors.purple),
                currentAccountPicture: Image.asset("lib/image/images.jpg"),
              ),
              new ListTile(
                title: new Text("first page"),
                leading: Icon(
                  Icons.search,
                  color: Colors.red,
                ),
              ),
              new ListTile(
                title: new Text("second page"),
                leading: Icon(
                  Icons.security,
                  color: Colors.green,
                ),
              ),
              new ListTile(
                title: new Text("theard page"),
                leading: Icon(Icons.send, color: Colors.blue),
              ),
              new ListTile(
                title: new Text("forth page"),
                leading: Icon(
                  Icons.settings,
                  color: Colors.cyan,
                ),
              ),
              new Divider(
                height: 10.0,
                color: Colors.grey,
              ),
              new ListTile(
                title: new Text("close"),
                trailing: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
        body: new ListView(
          children: <Widget>[
            new Container(
              height: 200,
              child: new ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 10.0,
                    margin: EdgeInsets.all(5.0),
                    child: new Container(
                      margin: EdgeInsets.all(10.0),
                      child: new Column(
                        children: <Widget>[
                          new ClipRRect(
                            borderRadius: new BorderRadius.circular(10.0),
                            child: new Image.network(
                                snapshot[index].data["url"],
                                height: 120.0,
                                width: 150.0,
                                fit: BoxFit.cover),
                          ),
                          new SizedBox(
                            height: 10.0,
                          ),
                          new Text(
                            snapshot[index].data["title"],
                            style:
                                TextStyle(fontSize: 19.0, color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }

  void Pleaseclicme() async {
    setState(() => textValue = name.text);
  }

  void onChangeFeaild(val) async {
    setState(() => textValue = name.text);
    print(val);
  }

  void checkboxChange(bool val) {
    setState(() {
      checkbox1 = true;
    });
    print(val);
  }
}
