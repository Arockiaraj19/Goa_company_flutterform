import 'package:dating_app/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatefulWidget {
  const InputField({
    Key key,
    this.controller,
    this.validators,
    this.hintText,
    this.prefix,
    this.onTap,
    this.maxLines = 1,
    this.readOnly = false,
    this.obscureText = false,
    this.inputType = TextInputType.text,
    this.padding,
    this.suffixIcon,
    this.margin,
    this.autofocus = false,
    this.focusNode,
    this.prefixText,
    this.inputFormatters,
    this.contentPadding,
    this.inputStateKey,
    this.lableColor,
    this.textColor,
    this.inputBoxBorder,
    this.labelBehavior,
    this.height,
    this.gradient,
  }) : super(key: key);
  final GlobalKey<FormFieldState> inputStateKey;
  final TextEditingController controller;
  final Function(String) validators;
  final String hintText;
  final Widget prefix;
  final String prefixText;
  final TextInputType inputType;
  final bool obscureText;
  final int maxLines;
  final EdgeInsetsGeometry padding;
  final bool readOnly;
  final EdgeInsetsGeometry contentPadding;
  final Function onTap;
  final Widget suffixIcon;
  final InputBorder inputBoxBorder;
  final double height;
  final Gradient gradient;

  final FloatingLabelBehavior labelBehavior;

  final List<TextInputFormatter> inputFormatters;
  final EdgeInsets margin;
  final FocusNode focusNode;
  final bool autofocus;
  final Color textColor;
  final Color lableColor;

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool active = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: widget.padding ?? EdgeInsets.all(10),
        child: Column(children: [
          Container(
              width: MediaQuery.of(context).size.width,
              child: Row(children: [
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 1.0,
                            offset: Offset(0, 3),
                          )
                        ],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Column(children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: widget.gradient),
                          //height: widget.height ?? 80,
                          padding: EdgeInsets.all(1),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: TextFormField(
                              obscuringCharacter: "*",
                              key: widget.inputStateKey,
                              autofocus: widget.autofocus ?? false,
                              focusNode: widget.focusNode,
                              onTap: () {
                                widget.onTap();
                                onchange();
                              },
                              validator: widget.validators,
                              controller: widget.controller,
                              keyboardType: widget.inputType,
                              obscureText: widget.obscureText,
                              maxLines: widget.maxLines,
                              readOnly: widget.readOnly,
                              style: TextStyle(
                                  color: widget.textColor ?? Colors.black,
                                  fontWeight: FontWeight.normal),
                              inputFormatters: widget.inputFormatters ?? [],
                              decoration: InputDecoration(
                                border:
                                    widget.inputBoxBorder ?? InputBorder.none,
                                focusedBorder:
                                    widget.inputBoxBorder ?? InputBorder.none,
                                enabledBorder:
                                    widget.inputBoxBorder ?? InputBorder.none,
                                errorBorder:
                                    widget.inputBoxBorder ?? InputBorder.none,
                                disabledBorder:
                                    widget.inputBoxBorder ?? InputBorder.none,
                                filled: true,
                                fillColor: Colors.white,
                                floatingLabelBehavior: widget.labelBehavior ??
                                    FloatingLabelBehavior.auto,
                                suffixIcon: widget.suffixIcon,
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 5, 5, 10),
                                prefixText: widget.prefixText,
                                labelText: widget.hintText,
                                labelStyle: TextStyle(
                                  color: widget.lableColor ?? Colors.grey,
                                  fontSize: 15,),
                                prefixStyle: TextStyle(color: Colors.black),
                                prefix: widget.prefix,
                                suffixIconConstraints:
                                    BoxConstraints(maxHeight: 17),
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        )
                      ])),
                )
              ])),
        ]));
  }

  onchange() {
    setState(() {
      if (active == false) {
        active = true;
      }
    });
  }
}
