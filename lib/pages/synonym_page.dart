import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:msa/drawer.dart';
import 'package:http/http.dart' as http;

class Synonym extends StatefulWidget {
  @override
  SynonymPage createState() => SynonymPage();
}

class SynonymPage extends State<Synonym> {
  final _formkey = GlobalKey<FormState>();
  final myController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String synonymWord;
  List<Data> _listOfEverything = <Data> []; // List of all data got from API
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Synonym'),
      ),
      drawer: MyDrawer(),
      body: Form(
        key: _formkey,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: (MediaQuery.of(context).size.height)*(0.1), left: (MediaQuery.of(context).size.width)*(0.3), right: (MediaQuery.of(context).size.width)*(0.3)),
              child: Text(
                'Enter word to find synonyms',
                style: TextStyle(
                    fontSize: 18.00
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: (MediaQuery.of(context).size.height)*(0.15), left: (MediaQuery.of(context).size.width)*(0.3), right: (MediaQuery.of(context).size.width)*(0.3)),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'Enter word',
                    hintStyle: TextStyle()
                ),
                textAlign: TextAlign.center,
                autocorrect: true,
                validator: (value) {
                  if(value.isEmpty){
                    return 'Enter a word';
                  }
                  return null;
                },
                controller: myController,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 30.00, left: (MediaQuery.of(context).size.width)*(0.3), right: (MediaQuery.of(context).size.width)*(0.3), bottom: 30.00),
                child: RaisedButton(
                  onPressed: () {
                    if(_formkey.currentState.validate()){
                      synonymWord = myController.text;
                      getSynonyms(synonymWord);
                      FocusScope.of(context).unfocus(); //For dismissing keyboard after pressing button
                    }
                  },
                  child: Text('Get Synonyms'),
                )
            ),
            allTheListViews()
          ],
        ),
      ),
    );
  }

  void getSynonyms(String word) async{

    final String APIkey = 'l203j4ca2m14m2iv71mcpwqrxo1omaxzj0pfgl63zuq92gtd8';
    final String url = 'https://api.wordnik.com/v4/word.json/$word/relatedWords?useCanonical=true&relationshipTypes=synonym&limitPerRelationshipType=100&api_key=$APIkey';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        _listOfEverything.clear(); // So that if used it a 2nd time, previous data is not shown again
        _listOfEverything.add(
            (Data.fromJson(json.decode(response.body))));
        _count = _listOfEverything[0].synonyms.length;
        showSnackBar('Found $_count synonyms');
      });
    } else {
      print(response.statusCode);
      showSnackBar('An error occured');
    }
  }

  ListView allTheListViews(){ // Displays all data collected from the API
    return ListView.builder(
        itemCount: _count,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int position){
          return Card(
            elevation: 3.0,
            child: ListTile(
              title: Text(
                "Synonym ${position+1}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(_listOfEverything[0].synonyms[position]),
            ),
          );
        }
    );
  }

  void showSnackBar(String message) { // For the snackbar
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 1),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}

class Data{ // For the API data storage and to decode JSON
  List<dynamic> synonyms;
  Data({this.synonyms});

  factory Data.fromJson(List<dynamic> json) {
    return Data(
        synonyms: json[0]['words']);
  }
}
