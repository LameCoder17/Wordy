import 'package:flutter/material.dart';
import 'package:msa/pages/about_page.dart';
import 'package:msa/pages/antonym_page.dart';
import 'package:msa/pages/exit_page.dart';
import 'package:msa/pages/meaning_page.dart';
import 'package:msa/pages/slangs_page.dart';
import 'package:msa/pages/start_page.dart';
import 'package:msa/pages/synonym_page.dart';

class MyDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Padding(
            padding: EdgeInsets.zero,
            child: ListView(
              children: <Widget>[
                DrawerHeader(
                  child: Padding(
                    padding: EdgeInsets.only(top: (MediaQuery.of(context).size.height)*(0.05)),
                    child: Text(
                      'Wordy - The App',
                      textScaleFactor: 1.3,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue
                  ),
                ),
                ListTile(
                  title: Text(
                    'Start',
                    textScaleFactor: 1.5,
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Start()
                    ));
                  },
                ),
                ListTile(
                  title: Text(
                    'About',
                    textScaleFactor: 1.5,
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => About()
                    ),);
                  },
                ),
                ListTile(
                  title: Text(
                    'Meaning',
                    textScaleFactor: 1.5,
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Meaning()
                    ),);
                  },
                ),
                ListTile(
                  title: Text(
                    'Synonym',
                    textScaleFactor: 1.5,
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Synonym()
                    ),);
                  },
                ),
                ListTile(
                  title: Text(
                    'Antonym',
                    textScaleFactor: 1.5,
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Antonym()
                    ),);
                  },
                ),
                ListTile(
                  title: Text(
                    'Slangs',
                    textScaleFactor: 1.5,
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Slang()
                    ),);
                  },
                ),
                ListTile(
                    title: Text(
                      'Exit',
                      textScaleFactor: 1.5,
                    ),
                    onTap: () => exitDialog(context),
                  )
              ],
            ))
    );
  }
}