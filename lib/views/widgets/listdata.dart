import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:formapp/model/userapi.dart';
import 'package:formapp/size.dart';

class Listdata extends StatefulWidget {
  @override
  State<Listdata> createState() => _ListdataState();
}

class _ListdataState extends State<Listdata> {
  @override
  void initState() {
    super.initState();
    controller.addListener(_scrollListener);
  }

  List outputdata = [];

  void _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      print("at the end of list");
    }
  }

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return FutureBuilder(
      future: Api().getdata(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          outputdata = snapshot.data;
          return Container(
            height: double.infinity,
            width: double.infinity,
            child: GridView.builder(
                controller: controller,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 2 / 2.8,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5),
                itemCount: outputdata.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    )),
                    alignment: Alignment.center,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CachedNetworkImage(
                            imageUrl: snapshot.data[index]["image"],
                            fit: BoxFit.cover,
                            height: SizeConfig.height * 25,
                          ),
                          Text(snapshot.data[index]["name"]),
                          Text(snapshot.data[index]["number"].toString()),
                        ]),
                  );
                }),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
