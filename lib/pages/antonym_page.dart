import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:msa/drawer.dart';
import 'package:http/http.dart' as http;

class Antonym extends StatefulWidget {
  @override
  AntonymPage createState() => AntonymPage();
}

class AntonymPage extends State<Antonym> {
  final _formkey = GlobalKey<FormState>();
  final myController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String antonymWord;
  List<Data> _listOfEverything = <Data> []; // List of all data got from API
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Antonym'),
      ),
      drawer: MyDrawer(),
      body: Form(
        key: _formkey,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: (MediaQuery.of(context).size.height)*(0.1), left: (MediaQuery.of(context).size.width)*(0.3), right: (MediaQuery.of(context).size.width)*(0.3)),
              child: Text(
                'Enter word to find antonyms',
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
                      antonymWord = myController.text;
                      getAntonyms(antonymWord);
                      FocusScope.of(context).unfocus(); //For dismissing keyboard after pressing button
                    }
                  },
                  child: Text('Get Antonyms'),
                )
            ),
            allTheListViews()
          ],
        ),
      ),
    );
  }

  void getAntonyms(String word) async{

    final String APIkey = 'l203j4ca2m14m2iv71mcpwqrxo1omaxzj0pfgl63zuq92gtd8';
    final String url = 'https://api.wordnik.com/v4/word.json/$word/relatedWords?useCanonical=true&relationshipTypes=antonym&limitPerRelationshipType=100&api_key=$APIkey';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        _listOfEverything.clear(); // So that if used it a 2nd time, previous data is not shown again
        _listOfEverything.add(
            (Data.fromJson(json.decode(response.body))));
        _count = _listOfEverything[0].antonyms.length;
        showSnackBar('Found $_count antonym');
      });
    } else if (response.statusCode == 404){
      setState(() {
        _listOfEverything.clear();
        _count = 0;
      });
      showSnackBar('No antonyms found');
    }
    else {
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
                "Antonym ${position+1}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(_listOfEverything[0].antonyms[position]),
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
  List<dynamic> antonyms;
  Data({this.antonyms});

  factory Data.fromJson(List<dynamic> json) {
    return Data(
        antonyms: json[0]['words']);
  }
}
