import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:msa/drawer.dart';
import 'package:http/http.dart' as http;
import 'meaning_page_explain.dart';


class Meaning extends StatefulWidget{
  Meaning({Key key}) : super(key: key);
  @override
    MeaningPage createState() => MeaningPage();
  }

class MeaningPage extends State<Meaning>{
  final _formkey = GlobalKey<FormState>();
  final myController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>(); // For snackbar
  String meaningWord;
  List<Data> _listOfEverything = <Data> []; // List of all data got from API
  int _count = 0; // For how many definitions found
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // For the snackbar
      appBar: AppBar(
        title: Text('Meaning'),
      ),
      drawer: MyDrawer(),
      body: Form(
        key: _formkey,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: (MediaQuery.of(context).size.height)*(0.1), left: (MediaQuery.of(context).size.width)*(0.3), right: (MediaQuery.of(context).size.width)*(0.3)),
              child: Text(
                'Enter word to find its meaning and more information about it',
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
                    meaningWord = myController.text;
                    getMeaning(meaningWord);
                    FocusScope.of(context).unfocus(); //For dismissing keyboard after pressing button
                  }
                },
                child: Text('Get Meaning'),
              )
            ),
            allTheListViews()
          ],
        )
      ),
    );
  }
  void getMeaning(String word) async{

    final String APIkey = 'l203j4ca2m14m2iv71mcpwqrxo1omaxzj0pfgl63zuq92gtd8';
    final String url = 'https://api.wordnik.com/v4/word.json/$word/definitions?limit=99&includeRelated=false&useCanonical=true&includeTags=false&api_key=$APIkey';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        _listOfEverything.clear(); // So that if used it a 2nd time, previous data is not shown again
        _count = 0;
      });
      int i = 0;
      try { // Couldn't figure out how to find how many definitions exist so used try catch block
        while (true) {
          setState(() {
            var stuff = Data.fromJson(json.decode(response.body), i);
            if(stuff.definition != null){
              _listOfEverything.add(
                  (stuff));
              _count++;
            }
            i++;
          });
        }
      }
      catch(error){
        print(error);
        showSnackBar('Found $_count definitions');
      }
    } else {
      print(response.statusCode);
      showSnackBar('An error occured');
    }
  }
  void showSnackBar(String message) { // For the snackbar
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 1),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
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
                "Definition ${position+1}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(_listOfEverything[position].definition),
              trailing: GestureDetector(
                child: Icon(
                  Icons.info_outline,
                  color: Colors.grey,
                ),
                onTap: (){ // Goes to new page to show other data
                  Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) {
                        return MeaningExplaination(_listOfEverything, position, meaningWord);
                      }
                  ));
                },
              ),
            ),
          );
        }
    );
  }
}

class Data{ // For the API data storage and to decode JSON
  String definition;
  String source;
  String link;
  String partsOfSpeech;
  List<dynamic> example;

  Data({this.definition, this.link, this.partsOfSpeech,this.source,this.example});

  factory Data.fromJson(List<dynamic> json, int position) {
    return Data(
        definition: json[position]['text'],
        link: json[position]['wordnikUrl'],
        partsOfSpeech: json[position]['partOfSpeech'],
        example: json[position]['exampleUses'],
        source: json[position]['attributionText']);
  }
}
