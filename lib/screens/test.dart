import 'package:flutter/material.dart';
//import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:Queuemahogany/widget/bottom_navy_bar.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("PICO THAILAND"),
      //   backgroundColor: Colors.blue,
      // ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            Container(
              color: Colors.blueGrey,
            ),
            Container(
              color: Colors.red,
            ),
            Container(
              color: Colors.green,
            ),
            Container(
              color: Colors.greenAccent,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        //containerHeight: 70.0,
        iconSize: 30,
        backgroundColor: Color(0xFF3B45C3),
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            title: Text(
              'NEWS',
              style: TextStyle(color: Color(0xFF3B45C3), fontSize: 16),
            ),
            icon: Icon(
              Icons.fiber_new,
              color: Color(0xFF3B45C3),
              size: 30,
            ),
            inactiveColor: Colors.white,
            activeColor: Colors.white,
          ),
          BottomNavyBarItem(
            title: Text(
              'BRANCH',
              style: TextStyle(color: Color(0xFF3B45C3), fontSize: 16),
            ),
            icon: Icon(
              Icons.map,
              color: Color(0xFF3B45C3),
              size: 30,
            ),
            inactiveColor: Colors.white,
            activeColor: Colors.white,
          ),
          BottomNavyBarItem(
            title: Text(
              'CONTACT',
              style: TextStyle(color: Color(0xFF3B45C3), fontSize: 16),
            ),
            icon: Icon(
              Icons.person,
              color: Color(0xFF3B45C3),
              size: 30,
            ),
            inactiveColor: Colors.white,
            activeColor: Colors.white,
          ),
          BottomNavyBarItem(
            title: Text(
              'OTHER',
              style: TextStyle(color: Color(0xFF3B45C3), fontSize: 16),
            ),
            icon: Icon(
              Icons.info,
              color: Color(0xFF3B45C3),
              size: 30,
            ),
            inactiveColor: Colors.white,
            activeColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
