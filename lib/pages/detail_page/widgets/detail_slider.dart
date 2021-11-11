import 'package:dating_app/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class DetailSlider extends StatefulWidget {
  DetailSlider({Key key, this.onTap, this.promos = const <String>[]})
      : super(key: key);
  final Function(dynamic) onTap;
  final List<dynamic> promos;
  @override
  _DetailSliderState createState() => _DetailSliderState();
}

class _DetailSliderState extends State<DetailSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: 250.h,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            dynamic _trens = widget.promos[index];
            return InkWell(
              onTap: () {
                widget.onTap(_trens);
              },
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: Colors.grey, blurRadius: 1.0)
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _trens == null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/images/placeholder.png',
                          fit: BoxFit.cover,
                        ))
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          _trens,
                          fit: BoxFit.cover,
                        )),
              ),
            );
          },
          itemCount: widget.promos.length,
          autoplay: false,
          pagination: SwiperPagination(
              alignment: Alignment.bottomLeft,
              builder: DotSwiperPaginationBuilder(
                  color: Colors.grey[300],
                  activeColor: MainTheme.primaryColor)),
          // control: SwiperControl(),
        ),
      ),
    );
  }
}
