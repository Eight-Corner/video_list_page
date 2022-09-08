import 'dart:convert'; //(jsonDecode)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // (loadJson)

class ProverbDisplay extends StatefulWidget {
  final int myId;
  final String myCountry;

  const ProverbDisplay(this.myId, this.myCountry);

  @override
  _ProverbDisplayState createState() => _ProverbDisplayState();
}

class _ProverbDisplayState extends State<ProverbDisplay> {
  Future getJsonProverbFuture = getJsonProverb();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getJsonProverbFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('Loading...');
          } else {
            return Container(
              color: Colors.blue,
              height: 250,
              child: Row(
                children: [
                  Container(
                    width: 300,
                    child: PageView.builder(itemBuilder: (context, index) {
                      return Text("${snapshot.data}");
                    }),
                  ),
                ],
              ),
            );
          }
        });
  }
}

//Get JSON
Future getJsonProverb() async {
  final String rawJson = await rootBundle.loadString('assets/json/data.json');
  return await jsonDecode(rawJson);
}
