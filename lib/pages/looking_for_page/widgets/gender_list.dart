import 'package:dating_app/pages/create_profile_page/widget/gender_card.dart';
import 'package:flutter/material.dart';

import '../../../routes.dart';

class GenderList extends StatefulWidget {
  GenderList({Key key}) : super(key: key);

  @override
  _GenderListState createState() => _GenderListState();
}

class _GenderListState extends State<GenderList> {
  int selectedMenuIndex = 0;

  List<Map<String, dynamic>> itemGender = [
    {
      "gender": "Male",
      "image": "assets/icons/male.png",
      'isActive': true,
    },
    {
      "gender": "Female",
      "image": "assets/icons/female.png",
      'isActive': false,
    },
    {
      "gender": "other",
      "image": "null",
      'isActive': false,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: itemGender.length,
        itemBuilder: (BuildContext context, int index) {
          dynamic item = itemGender[index];
          return Container(
              height: 80,
              width: 60,
              child: GenderCard(
                name: item["gender"],
                image: item["image"],
                isActive: item["isActive"],
                onTap: () {
                  if (mounted) {
                    setState(() {
                      selectedMenuIndex = index;
                      itemGender = itemGender.map<Map<String, dynamic>>(
                          (Map<String, dynamic> item) {
                        item['isActive'] = false;
                        return item;
                      }).toList();
                      itemGender[index]['isActive'] = true;
                    });
                  }
                  print(
                      'pppppppppppppppppppppppppppppppppppp${item["gender"]}');

                  goToFindMatchPage();
                },
              ));
        });
  }

  goToFindMatchPage() {
      NavigateFunction()
        .withquery(Navigate.findMatchPage);
   
  }
}
