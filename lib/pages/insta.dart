import 'package:flutter/material.dart';

class InstaGram extends StatefulWidget {
  const InstaGram({Key key}) : super(key: key);

  @override
  _InstaGramState createState() => _InstaGramState();
}

class _InstaGramState extends State<InstaGram> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Text("Instagram"),
        ),
      ),
    );
  }
}
