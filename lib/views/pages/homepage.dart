import 'package:flutter/material.dart';
import 'package:formapp/size.dart';
import 'package:formapp/views/widgets/form.dart';
import 'package:formapp/views/widgets/listdata.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentindex = 0;
  List<Widget> pages = [
    Listdata(),
    Formpart(),
  ];

  PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentindex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _currentindex = page;
    });
  }

  void onTabTapped(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("User Detail App"),
      ),
      body: PageView(
        children: pages,
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        onTap: onTabTapped,
        currentIndex:
            _currentindex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Users"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_align_center),
            title: Text("Form"),
          ),
        ],
      ),
    );
  }
}
