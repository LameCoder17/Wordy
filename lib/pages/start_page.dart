import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:msa/drawer.dart';

class Start extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Wordy'
        ),
      ),
      drawer: MyDrawer(),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: (MediaQuery.of(context).size.height)/5),
            child: Center(
              child: (
                  Text('Wordy',
                    textScaleFactor: 5,)
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50.00),
            child: Center(
              child: (
                  Text(
                    'Easiest way to get \nmeanings, \nsynonyms \nand antonyms \nfor English words',
                    textScaleFactor: 2,
                    textAlign: TextAlign.center,
                  )
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: (MediaQuery.of(context).size.height)/7),
            child: Center(
              child: Text(
                'Tap on the Navigation Drawer to get started !',
                textScaleFactor: 1.4,
              ),
            ),
          )
        ],
      ),
    );
  }
}