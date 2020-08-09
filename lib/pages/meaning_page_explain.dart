import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class MeaningExplaination extends StatefulWidget{
  final List<dynamic> listOfEverything;
  final int position;
  final String word;

  MeaningExplaination(this.listOfEverything, this.position, this.word);
  @override
  State<StatefulWidget> createState() {
    return MeaningExplainationState(this.listOfEverything, this.position, this.word);
  }
}

class MeaningExplainationState extends State<MeaningExplaination> {
  List<dynamic> listOfEverything;
  int position;
  String word;
  MeaningExplainationState(this.listOfEverything, this.position, this.word);

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
                Text(this.word, style: TextStyle(
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
                Text("Part Of Speech",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.00),
                ),
                Container(
                  height: 10.00,
                ),
                Text(this.listOfEverything[this.position].partsOfSpeech,
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
                Text("Provided by ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.00),
                ),
                Container(
                  height: 10.00,
                ),
                Text(this.listOfEverything[this.position].source.substring(5), // Used substring method to remove 5 (doesn't sound good with from in the string)
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
                Text("Example ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.00),
                ),
                Container(
                  height: 10.00,
                ),
                Text(exampleString(this.listOfEverything[this.position].example),

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

  String exampleString(List<dynamic> letters) {
    if (letters.isNotEmpty) {
      return(letters[0]['text']);
    }
    else {
      return 'No example found';
    }
  }
}