import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class SlangsExplaination extends StatefulWidget{
  final List<dynamic> listOfEverything;
  final int position;
  final String slang;

  SlangsExplaination(this.listOfEverything, this.position, this.slang);
  @override
  State<StatefulWidget> createState() {
    return SlangsExplainationState(this.listOfEverything, this.position, this.slang);
  }
}

class SlangsExplainationState extends State<SlangsExplaination> {
  List<dynamic> listOfEverything;
  int position;
  String slang;
  SlangsExplainationState(this.listOfEverything, this.position, this.slang);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Definition ${this.position+1}'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: (MediaQuery.of(context).size.height)*0.02, left: (MediaQuery.of(context).size.width)*0.05, right: (MediaQuery.of(context).size.width)*0.05),
            child: Column(
              children: <Widget>[Text(
                "Word",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.00
                ),
              ),
                Container(
                  height: 10.00,
                ),
                Text(this.slang, style: TextStyle(
                    fontSize: 18.00
                ),)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: (MediaQuery.of(context).size.height)*0.05, left: (MediaQuery.of(context).size.width)*0.05, right: (MediaQuery.of(context).size.width)*0.05),
            child: Column(
              children: <Widget>[
                Text("Definition",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.00),
                ),
                Container(
                  height: 10.00,
                ),
                Text(this.listOfEverything[this.position].definition,
                  style: TextStyle(
                    fontSize: 18.00
                ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: (MediaQuery.of(context).size.height)*0.05, left: (MediaQuery.of(context).size.width)*0.05, right: (MediaQuery.of(context).size.width)*0.05),
            child: Column(
              children: <Widget>[
                Text("Example",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.00),
                ),
                Container(
                  height: 10.00,
                ),
                Text(this.listOfEverything[this.position].example,
                  style: TextStyle(
                    fontSize: 18.00
                ),)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: (MediaQuery.of(context).size.height)*0.05, left: (MediaQuery.of(context).size.width)*0.05, right: (MediaQuery.of(context).size.width)*0.05),
            child: Column(
              children: <Widget>[
                Text("Given by ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.00),
                ),
                Container(
                  height: 10.00,
                ),
                Text(this.listOfEverything[this.position].author, style: TextStyle(
                    fontSize: 18.00
                ),)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: (MediaQuery.of(context).size.height)*0.05, left: (MediaQuery.of(context).size.width)*0.33, right: (MediaQuery.of(context).size.width)*0.05),
            child: Row(
              children: <Widget>[
                Icon(
                Icons.thumb_up,
                ),
                Container(
                  width: 10.00,
                ),
                Text((this.listOfEverything[this.position].thumbsup).toString(),
                  style: TextStyle(
                      fontSize: 18.00
                  ),),
                Container(
                  width: 32.00,
                ),
                Icon(
                  Icons.thumb_down,
                ),
                Container(
                  width: 10.00,
                ),
                Text((this.listOfEverything[this.position].thumbsdown).toString(),
                style: TextStyle(
                    fontSize: 18.00
                ),),
              ],
            )
          ),
          Padding(
            padding: EdgeInsets.only(top: (MediaQuery.of(context).size.height)*0.05, left: (MediaQuery.of(context).size.width)*0.05, right: (MediaQuery.of(context).size.width)*0.05),
            child: Column(
              children: <Widget>[
                Linkify(
                  text: "Link - ${this.listOfEverything[this.position].link}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.00),
                  onOpen: (link) async{
                    if(await canLaunch(this.listOfEverything[this.position].link)){
                      await launch(this.listOfEverything[this.position].link);
                    }
                    else{
                      throw 'Failed to launch url';
                    }
                },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}