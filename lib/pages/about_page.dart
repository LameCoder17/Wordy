import 'package:flutter/material.dart';
import 'package:msa/drawer.dart';

class About extends StatefulWidget {
  @override
  AboutPage createState() => AboutPage();
}

class AboutPage extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      drawer: MyDrawer(),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: (MediaQuery.of(context).size.height)*(0.3)),
            child: Center(
              child: Text(
                'Created by G Shalom using Flutter',
                textScaleFactor: 1.5,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: (MediaQuery.of(context).size.height)*(0.03), left:  (MediaQuery.of(context).size.width)*(0.05), right: (MediaQuery.of(context).size.width)*(0.05)),
            child: Center(
              child: Text(
                  'Uses the Wordnik API for Meanings, Synonyms and Antonyms (Limit - 100/hr)',
                textScaleFactor: 1.5,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: (MediaQuery.of(context).size.height)*(0.03), left:  (MediaQuery.of(context).size.width)*(0.05), right: (MediaQuery.of(context).size.width)*(0.05)),
            child: Center(
              child: Text(
                'Uses Urban Dictionary for slangs (through RapidAPI) (No Limit)',
                textScaleFactor: 1.5,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: (MediaQuery.of(context).size.height)*(0.10)),
            child: Center(
              child: AboutDialog(
                applicationName: 'Wordy',
                applicationVersion: '0.1',
                applicationLegalese: 'Created for non-commercial use',
              )
            ),
          )
        ],
      ),
    );
  }
}
