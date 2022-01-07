import 'package:dating_app/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WebGradientButton extends StatefulWidget {
  WebGradientButton(
      {Key key,
      this.name,
      this.onPressed,
      this.height = 15,
      this.width,
      this.gradient,
      this.buttonColor,
      this.color,
      this.isLoading = false,
      this.border,
      this.active = false,
      this.margin,
      this.boxShadow,
      this.fontWeight,
      this.fontSize,
      this.borderRadius,
      this.hoverColor,
      this.hoverTextColor,
      this.hoverborder})
      : super(key: key);

  final String name;
  final Function onPressed;
  final double width;
  final double height;
  final double fontSize;
  final Gradient gradient;
  final Color color;
  final BoxBorder border;
  final bool active;
  final Color buttonColor;
  final bool isLoading;
  final EdgeInsetsGeometry margin;
  final List<BoxShadow> boxShadow;
  final FontWeight fontWeight;
  final Gradient hoverColor;
  final Color hoverTextColor;
  final BorderRadiusGeometry borderRadius;
  final BoxBorder hoverborder;

  @override
  _WebGradientButtonState createState() => _WebGradientButtonState();
}

class _WebGradientButtonState extends State<WebGradientButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        // onHover: (value) {
        //   setState(() {
        //     isHovered = value;
        //   });
        // },
        child: Container(
            height: widget.height,
            width: widget.width,
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: widget.border,
              boxShadow: <BoxShadow>[
                BoxShadow(color: Colors.grey.shade300, blurRadius: 1.0)
              ],
              color: Colors.black,
              gradient: widget.gradient,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    height: widget.height,
                    minWidth: widget.width,
                    onPressed: widget.onPressed,
                    child: Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            !widget.active
                                ? Container(
                                    margin: EdgeInsetsDirectional.only(end: 10),
                                    child: Icon(
                                      Icons.mail_outline,
                                      color: Colors.grey,
                                    ))
                                : Container(),
                            Flexible(
                                child: Container(
                                    child: Text(widget.name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: widget.color,
                                            fontFamily: "Inter",
                                            fontSize: widget.fontSize ??
                                                ScreenUtil().setSp(40),
                                            fontWeight: FontWeight.w500))))
                          ]),
                    )))));
  }
}
