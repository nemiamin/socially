import 'package:flutter/material.dart';
import 'package:socially/screens/login.dart';
import 'package:socially/screens/signUp.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  List<Tab> tabList = List();
  TabController _tabController;
  @override
  void initState() {
    tabList.add(new Tab(
      text: 'Login',
    ));
    tabList.add(new Tab(
      text: 'Sign Up',
    ));
    _tabController = new TabController(vsync: this, length: tabList.length);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.45),
              child: new Column(
                children: <Widget>[
                  new Container(
                    color: Color(0xFF311f4f),
                    child: new TabBar(
                        controller: _tabController,
                        indicatorColor: Color(0xFF682daa),
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: tabList),
                  ),
                  new Container(
                    height: size.height * 0.55,
                    child: new TabBarView(
                      controller: _tabController,
                      children: tabList.map((Tab tab) {
                        return _getPage(tab);
                      }).toList(),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getPage(Tab tab) {
    switch (tab.text) {
      case 'Login':
        return LoginScreen();
      case 'Sign Up':
        return SignUpScreen();
      default:
        return LoginScreen();
    }
  }
}
