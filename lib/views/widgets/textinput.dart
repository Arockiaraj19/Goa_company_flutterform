import 'package:flutter/material.dart';

import '../../size.dart';

class Inputform extends StatefulWidget {
  final String title;
  final String placeholder;
  final TextEditingController _controller;
  final validator;

  Inputform(this.title, this.placeholder, this._controller, this.validator);

  @override
  _InputformState createState() => _InputformState();
}

class _InputformState extends State<Inputform> {
  bool istrue = true;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 5, 0, 8),
          child: Text(widget.title),
        ),
        Container(
          width: SizeConfig.width * 100,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 2, 8),
            child: TextFormField(
              validator: widget.validator,
              controller: widget._controller,
              decoration: InputDecoration(
                hintText: "  ${widget.placeholder}",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: SizeConfig.height * 2,
        ),
      ],
    );
  }
}
