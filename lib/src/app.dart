import 'package:chart_test/src/widgets/chart.dart';
import 'package:chart_test/src/widgets/chart_bar.dart';
import 'package:chart_test/src/widgets/chart_pie.dart';
import 'package:chart_test/src/widgets/chart_simple.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with TickerProviderStateMixin {
  Animation<double> appBarAnimation;
  AnimationController appBarController;

  @override
  void initState() {
    super.initState();

    appBarController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    appBarAnimation = Tween(begin: 160.0, end: 170.0).animate(CurvedAnimation(
      parent: appBarController,
      curve: Curves.easeIn,
    ));
  }

  onTap() {
    if (appBarController.status == AnimationStatus.completed) {
      appBarController.reverse();
    } else if (appBarController.status == AnimationStatus.dismissed) {
      appBarController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: screenItems(),
    ));
  }

  Widget screenItems() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          GestureDetector(
            child: buildAnimation(),
            onTap: onTap,
          ),
          roundSquareWidget(ChartA1.withSampleData(), Colors.white, 600, 150),
          roundSquareWidget(
              PartialPieChart.withSampleData(), Colors.white, 400, 200),
          roundSquareWidget(
              SimpleScatterPlotChart.withSampleData(), Colors.white, 600, 200),
              roundSquareWidget(RTLBarChart.withSampleData(), Colors.white, 600, 200),
        ],
      ),
    );
  }

  Widget roundSquareWidget(
      Widget child, Color color, double width, double height,
      {EdgeInsetsGeometry margin}) {
    if (margin == null) {
      margin = EdgeInsets.only(right: 20, left: 20, bottom: 20);
    }
    return Container(
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15.0, // has the effect of softening the shadow
              spreadRadius: 0, // has the effect of extending the shadow
              offset: Offset(
                0, // horizontal, move right 10
                0, // vertical, move down 10
              ),
            )
          ]),
      child: child,
      padding: EdgeInsets.all(20),
    );
  }

  Widget buildAnimation() {
    return AnimatedBuilder(
      animation: appBarAnimation,
      builder: (context, child) {
        return Container(
          child: child,
          height: appBarAnimation.value,
        );
      },
      child: roundSquareWidget(appBarContent(), Colors.blue[400], 600, 150,
          margin: EdgeInsets.only(bottom: 20)),
    );
  }

  Widget appBarContent() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text(
              "Some Google Charts".toUpperCase(),
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
            ),
          ),
          Container(
            child: Text(
              "Click here to expand the AppBar".toUpperCase(),
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
            ),
          )
        ],
      ),
    );
  }
}
