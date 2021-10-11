import 'package:dating_app/models/gender_model.dart';
import 'package:dating_app/networks/gender_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenderPage extends StatefulWidget {
  List<GenderModel> data;
  GenderPage(this.data);
  @override
  _GenderPageState createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  int choosenvalue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Icon(
          Icons.arrow_back_ios,
          color: Color(0xff181725),
          size: 60.sp,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Looking for",
          style: TextStyle(
            color: Color(0xff181725),
            fontSize: 60.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
              children: List.generate(widget.data.length, (index) {
            return widget.data[index].title == "Male" ||
                    widget.data[index].title == "Female"
                ? Container()
                : InkWell(
                    onTap: () {
                      setState(() {
                        choosenvalue = index;
                      });
                      Navigator.pop(context, widget.data[index]);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(20.0.w),
                      child: Card(
                        elevation: 2,
                        child: Container(
                          height: 350.w,
                          width: 500.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.w),
                              color: Colors.white,
                              border: choosenvalue == index
                                  ? Border.all(width: 2, color: Colors.pink)
                                  : null),
                          child: Column(
                            children: [
                              Icon(
                                Icons.person,
                                size: 200.r,
                                color: Colors.pink,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                widget.data[index].title,
                                style: TextStyle(
                                  color: choosenvalue == index
                                      ? Colors.pink
                                      : Colors.grey[400],
                                  fontSize: 45.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
          })),
        ),
      ),
    );
  }
}
