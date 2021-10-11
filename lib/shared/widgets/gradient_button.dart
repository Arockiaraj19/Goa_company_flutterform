import 'package:dating_app/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GradientButton extends StatefulWidget {
  GradientButton(
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
      this.borderRadius})
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
  final BorderRadiusGeometry borderRadius;

  @override
  _GradientButtonState createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          border: widget.border ?? null,
          boxShadow: widget.boxShadow ??
              <BoxShadow>[
                BoxShadow(color: Colors.grey.shade300, blurRadius: 1.0)
              ],
          color: widget.buttonColor ?? Colors.black,
          gradient: widget.gradient,
          borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
        ),
        child: MaterialButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.white,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            height: widget.height,
            minWidth: widget.width ?? MediaQuery.of(context).size.width,
            onPressed: !widget.isLoading ? widget.onPressed : () {},
            child: Row(children: [
              Expanded(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: widget.color,
                                  fontFamily: "Inter",
                                  fontSize:
                                      widget.fontSize ?? ScreenUtil().setSp(35),
                                  fontWeight:
                                      widget.fontWeight ?? FontWeight.w500))))
                ]),
              )
            ])));
  }
}
