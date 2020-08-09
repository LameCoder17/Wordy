import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:msa/drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:msa/pages/slangs_page_explain.dart';

class Slang extends StatefulWidget{
  Slang({Key key}) : super(key: key);
  @override
  SlangsPage createState() => SlangsPage();
}

class SlangsPage extends State<Slang>{
  final _formkey = GlobalKey<FormState>(); // For form validation
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>(); // For snackbar
  final myController = TextEditingController(); // To save data typed
  String slang; //Not exactly needed. Could maybe remove it
  List<Data> _listOfEverything = <Data> []; // List of all data got from API
  int _count = 0; // For how many definitions found
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // For the snackbar
      appBar: AppBar(
        title: Text('Slang'),
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
                  padding: EdgeInsets.only(top: 30.00, left: (MediaQuery.of(context).size.width)*(0.3), right: (MediaQuery.of(context).size.width)*(0.3), bottom: 40.00),
                  child: RaisedButton(
                    onPressed: () {
                      if(_formkey.currentState.validate()){
                          slang = myController.text;
                          getData(slang);
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
  void getData(String slangWord) async{
    final String url = 'https://mashape-community-urban-dictionary.p.rapidapi.com/define?term=$slangWord';

    final response =
    await http.get(url, headers: {"x-rapidapi-host" : "mashape-community-urban-dictionary.p.rapidapi.com", "x-rapidapi-key" : "50ac9c4044msh39981ef1f9bb08fp1f4257jsncc3806f82680"});

    if (response.statusCode == 200) {
      setState(() {
        _listOfEverything.clear(); // So that if used it a 2nd time, previous data is not shown again
        _count = 0;
      });
      int i = 0;
      try { // Couldnt figure out how to find how many definitions exist (probably 10) so used try catch block
        while (true) {
          setState(() {
            _listOfEverything.add(
                (Data.fromJson(json.decode(response.body), i)));
            _count++;
            i++;
          });
        }
      }
      catch(error){
        print(error);
        showSnackBar('Found $i definitions');
      }
    } else {
      print(response.statusCode);
      showSnackBar('An error occured');
      print(response.statusCode);
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
                        return SlangsExplaination(_listOfEverything, position, slang);
                      }
                  ));
                },
              ),
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
  String definition;
  String example;
  String link;
  int thumbsup;
  int thumbsdown;
  String author;

  Data({this.definition, this.link, this.thumbsup, this.thumbsdown, this.author,this.example});

  factory Data.fromJson(Map<String, dynamic> json, int position) {
    return Data(
        definition: json['list'][position]['definition'],
        link: json['list'][position]['permalink'],
        thumbsup: json['list'][position]['thumbs_up'],
        thumbsdown: json['list'][position]['thumbs_down'],
        author: json['list'][position]['author'],
        example: json['list'][position]['example']);
  }
}

