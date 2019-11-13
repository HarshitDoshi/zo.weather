import 'dart:ui';
import 'package:flutter/material.dart';
import 'weather.dart';
import 'header.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimatedHeader animatedHeader = new AnimatedHeader();
  AnimationController rotationController;
  TabController tabController;
  PlaceWidget placeWidget = PlaceWidget();
  WeatherDisplay weatherDisplay = WeatherDisplay();
  Future<Weather> refresher;

  @override
  void initState() {
    super.initState();
    rotationController = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );
    rotationController.repeat();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    rotationController.reset();
    rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
          scrollDirection: Axis.vertical,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                brightness: Brightness.dark,
                elevation: 16.0,
                backgroundColor: Colors.white,
                centerTitle: true,
                forceElevated: true,
                expandedHeight: 150.0,
                floating: true,
                pinned: true,
                snap: false,
                bottom: AppBar(
                  centerTitle: true,
                  brightness: Brightness.light,
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  title: placeWidget,
                ),
                primary: true,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: animatedHeader,
                ),
              ),
            ];
          },
          body: SafeArea(
            top: true,
            child: Center(
              child: weatherDisplay,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(
            Icons.my_location,
            color: Colors.white,
          ),
          backgroundColor: Colors.lightBlue,
          label: Text(
            'Refresh',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          elevation: 8.0,
          disabledElevation: 4.0,
          focusElevation: 16.0,
          highlightElevation: 16.0,
          hoverElevation: 16.0,
          onPressed: () async {
            setState(() {
              refresher = fetchWeather();
            });
          },
          tooltip: 'Get current location',
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 16.0,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.details,
                color: Colors.blue,
              ),
              title: Text(
                'Overview',
                style: TextStyle(
                  color: Colors.lightBlue,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.insert_chart,
                color: Colors.blue,
              ),
              title: Text(
                'Analysis',
                style: TextStyle(
                  color: Colors.lightBlue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
